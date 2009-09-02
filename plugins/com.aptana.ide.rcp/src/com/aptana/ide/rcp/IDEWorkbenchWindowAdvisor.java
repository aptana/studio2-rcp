/*******************************************************************************
 * Copyright (c) 2005, 2008 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
package com.aptana.ide.rcp;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.eclipse.core.runtime.IAdaptable;
import org.eclipse.core.runtime.IProduct;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Platform;
import org.eclipse.core.runtime.Status;
import org.eclipse.jface.action.ToolBarManager;
import org.eclipse.jface.dialogs.ErrorDialog;
import org.eclipse.jface.dialogs.IDialogConstants;
import org.eclipse.jface.dialogs.MessageDialogWithToggle;
import org.eclipse.jface.preference.IPreferenceStore;
import org.eclipse.jface.resource.JFaceResources;
import org.eclipse.osgi.util.NLS;
import org.eclipse.swt.SWT;
import org.eclipse.swt.dnd.DropTargetEvent;
import org.eclipse.swt.dnd.FileTransfer;
import org.eclipse.swt.dnd.TransferData;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.layout.GridLayout;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Control;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Label;
import org.eclipse.swt.widgets.ToolBar;
import org.eclipse.ui.IEditorPart;
import org.eclipse.ui.IEditorReference;
import org.eclipse.ui.IPageListener;
import org.eclipse.ui.IPartListener2;
import org.eclipse.ui.IPerspectiveDescriptor;
import org.eclipse.ui.IPerspectiveRegistry;
import org.eclipse.ui.IPropertyListener;
import org.eclipse.ui.IWorkbench;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchPartConstants;
import org.eclipse.ui.IWorkbenchPartReference;
import org.eclipse.ui.IWorkbenchWindow;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PerspectiveAdapter;
import org.eclipse.ui.WorkbenchException;
import org.eclipse.ui.actions.ActionFactory;
import org.eclipse.ui.actions.ActionFactory.IWorkbenchAction;
import org.eclipse.ui.application.ActionBarAdvisor;
import org.eclipse.ui.application.IActionBarConfigurer;
import org.eclipse.ui.application.IWorkbenchWindowConfigurer;
import org.eclipse.ui.application.WorkbenchWindowAdvisor;
import org.eclipse.ui.internal.ide.AboutInfo;
import org.eclipse.ui.internal.ide.EditorAreaDropAdapter;
import org.eclipse.ui.internal.ide.IDEInternalPreferences;
import org.eclipse.ui.internal.ide.IDEWorkbenchMessages;
import org.eclipse.ui.internal.ide.IDEWorkbenchPlugin;
import org.eclipse.ui.internal.ide.WorkbenchActionBuilder;
import org.eclipse.ui.internal.ide.dialogs.WelcomeEditorInput;
import org.eclipse.ui.part.EditorInputTransfer;
import org.eclipse.ui.part.MarkerTransfer;
import org.eclipse.ui.part.ResourceTransfer;
import org.eclipse.ui.statushandlers.StatusManager;
import org.eclipse.update.configurator.ConfiguratorUtils;
import org.eclipse.update.configurator.IPlatformConfiguration;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleException;

import com.aptana.ide.core.StringUtils;
import com.aptana.ide.core.ui.CoreUIPlugin;
import com.aptana.ide.core.ui.WorkbenchHelper;
import com.aptana.ide.update.FeatureUtil;

/**
 * Window-level advisor for the IDE.
 */
public class IDEWorkbenchWindowAdvisor extends WorkbenchWindowAdvisor {

	private static final String WELCOME_EDITOR_ID = "org.eclipse.ui.internal.ide.dialogs.WelcomeEditor"; //$NON-NLS-1$

	private IDEWorkbenchAdvisor wbAdvisor;
	private boolean editorsAndIntrosOpened = false;
	private IEditorPart lastActiveEditor = null;
	private IPerspectiveDescriptor lastPerspective = null;

	private IWorkbenchPage lastActivePage;
	private String lastEditorTitle = StringUtils.EMPTY;

	private IPropertyListener editorPropertyListener = new IPropertyListener() {
		public void propertyChanged(Object source, int propId) {
			if (propId == IWorkbenchPartConstants.PROP_TITLE) {
				if (lastActiveEditor != null) {
					String newTitle = getTitle(lastActiveEditor);
					if (!lastEditorTitle.equals(newTitle)) {
						recomputeTitle();
					}
				}
			}
		}
	};

	private IAdaptable lastInput;

	private IWorkbenchAction openPerspectiveAction;

	/**
	 * Crates a new IDE workbench window advisor.
	 * 
	 * @param wbAdvisor
	 *            the workbench advisor
	 * @param configurer
	 *            the window configurer
	 */
	public IDEWorkbenchWindowAdvisor(IDEWorkbenchAdvisor wbAdvisor,
			IWorkbenchWindowConfigurer configurer) {
		super(configurer);
		this.wbAdvisor = wbAdvisor;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchWindowAdvisor#createActionBarAdvisor(org.eclipse.ui.application.IActionBarConfigurer)
	 */
	public ActionBarAdvisor createActionBarAdvisor(
			IActionBarConfigurer configurer) {
		return new WorkbenchActionBuilder(configurer);
	}

	/**
	 * Returns the workbench.
	 * 
	 * @return the workbench
	 */
	private IWorkbench getWorkbench() {
		return getWindowConfigurer().getWorkbenchConfigurer().getWorkbench();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchAdvisor#preWindowShellClose
	 */
	public boolean preWindowShellClose() {
		if (getWorkbench().getWorkbenchWindowCount() > 1) {
			return true;
		}
		// the user has asked to close the last window, while will cause the
		// workbench to close in due course - prompt the user for confirmation
		IPreferenceStore store = IDEWorkbenchPlugin.getDefault()
				.getPreferenceStore();
		boolean promptOnExit = store
				.getBoolean(IDEInternalPreferences.EXIT_PROMPT_ON_CLOSE_LAST_WINDOW);

		if (promptOnExit) {
			String message;

			String productName = null;
			IProduct product = Platform.getProduct();
			if (product != null) {
				productName = product.getName();
			}
			if (productName == null) {
				message = IDEWorkbenchMessages.PromptOnExitDialog_message0;
			} else {
				message = NLS.bind(
						IDEWorkbenchMessages.PromptOnExitDialog_message1,
						productName);
			}

			MessageDialogWithToggle dlg = MessageDialogWithToggle
					.openOkCancelConfirm(getWindowConfigurer().getWindow()
							.getShell(),
							IDEWorkbenchMessages.PromptOnExitDialog_shellTitle,
							message,
							IDEWorkbenchMessages.PromptOnExitDialog_choice,
							false, null, null);
			if (dlg.getReturnCode() != IDialogConstants.OK_ID) {
				return false;
			}
			if (dlg.getToggleState()) {
				store
						.setValue(
								IDEInternalPreferences.EXIT_PROMPT_ON_CLOSE_LAST_WINDOW,
								false);
				IDEWorkbenchPlugin.getDefault().savePluginPreferences();
			}
		}

		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchAdvisor#preWindowOpen
	 */
	public void preWindowOpen() {

		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		
		// register to handle file transfer drag/drop operations (supports Windows shell)
		configurer.addEditorAreaTransfer(FileTransfer.getInstance());
		
		// show the shortcut bar and progress indicator, which are hidden by
		// default
		configurer.setShowPerspectiveBar(true);
		configurer.setShowFastViewBars(true);
		configurer.setShowProgressIndicator(true);

		// add the drag and drop support for the editor area
		configurer.addEditorAreaTransfer(EditorInputTransfer.getInstance());
		configurer.addEditorAreaTransfer(ResourceTransfer.getInstance());
		configurer.addEditorAreaTransfer(FileTransfer.getInstance());
		configurer.addEditorAreaTransfer(MarkerTransfer.getInstance());
		configurer.configureEditorAreaDropListener(new EditorAreaDropAdapter2(
				configurer.getWindow()));

		hookTitleUpdateListeners(configurer);
	}
	
	/**
	 * Enhances the standard Eclipse EditorAreaDropAdapter to add support for opening files dragged
	 * in from the windows shell. This logic orginates from NavigatorDragDropAdapter and
	 * OpenExtenalFileAction.
	 * 
	 * @author Spike Washburn
	 */
	class EditorAreaDropAdapter2 extends EditorAreaDropAdapter
	{
		IWorkbenchWindow window;
		
		/**
		 * Constructs a new EditorAreaDropAdapter.
		 * 
		 * @param window
		 *            the workbench window
		 */
		public EditorAreaDropAdapter2(IWorkbenchWindow window)
		{
			super(window);
			this.window = window;
		}
		
		/**
		 * @see org.eclipse.swt.dnd.DropTargetListener#drop(org.eclipse.swt.dnd.DropTargetEvent)
		 */
		public void drop(final DropTargetEvent event)
		{
			TransferData currentTransfer = event.currentDataType;
			
			// if the transfer datatype is a FileTransfer, handle it, otherwise let our parent class
			// handle it.
			if (FileTransfer.getInstance().isSupportedType(currentTransfer))
			{
				String[] names = (String[]) event.data;
				File[] files = new File[names.length];
				for (int i = 0; i < files.length; i++)
				{
					WorkbenchHelper.openFile(new File(names[i]), window);
				}
			}
			else
			{
				super.drop(event);
			}
		}
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchAdvisor#postWindowOpen
	 */
	public void postWindowOpen() {
		super.postWindowOpen();
	}

	/**
	 * Hooks the listeners needed on the window
	 * 
	 * @param configurer
	 */
	private void hookTitleUpdateListeners(IWorkbenchWindowConfigurer configurer) {
		// hook up the listeners to update the window title
		configurer.getWindow().addPageListener(new IPageListener() {
			public void pageActivated(IWorkbenchPage page) {
				updateTitle();
			}

			public void pageClosed(IWorkbenchPage page) {
				updateTitle();
			}

			public void pageOpened(IWorkbenchPage page) {
				// do nothing
			}
		});
		configurer.getWindow().addPerspectiveListener(new PerspectiveAdapter() {
			public void perspectiveActivated(IWorkbenchPage page,
					IPerspectiveDescriptor perspective) {
				updateTitle();
			}

			public void perspectiveSavedAs(IWorkbenchPage page,
					IPerspectiveDescriptor oldPerspective,
					IPerspectiveDescriptor newPerspective) {
				updateTitle();
			}

			public void perspectiveDeactivated(IWorkbenchPage page,
					IPerspectiveDescriptor perspective) {
				updateTitle();
			}
		});
		configurer.getWindow().getPartService().addPartListener(
				new IPartListener2() {
					public void partActivated(IWorkbenchPartReference ref) {
						if (ref instanceof IEditorReference) {
							updateTitle();
						}
					}

					public void partBroughtToTop(IWorkbenchPartReference ref) {
						if (ref instanceof IEditorReference) {
							updateTitle();
						}
					}

					public void partClosed(IWorkbenchPartReference ref) {
						updateTitle();
					}

					public void partDeactivated(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partOpened(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partHidden(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partVisible(IWorkbenchPartReference ref) {
						// do nothing
					}

					public void partInputChanged(IWorkbenchPartReference ref) {
						// do nothing
					}
				});
	}

	private String computeTitle() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		IWorkbenchPage currentPage = configurer.getWindow().getActivePage();
		IEditorPart activeEditor = null;
		if (currentPage != null) {
			activeEditor = currentPage.getActiveEditor();
		}

		String title = null;
		IProduct product = Platform.getProduct();
		if (product != null) {
			title = product.getName();
		}
		if (title == null) {
			title = StringUtils.EMPTY;
		}

		if (currentPage != null) {
			if (activeEditor != null) {
				lastEditorTitle = getTitle(activeEditor);
				title = NLS.bind(
						IDEWorkbenchMessages.WorkbenchWindow_shellTitle,
						lastEditorTitle, title);
			}
			IPerspectiveDescriptor persp = currentPage.getPerspective();
			String label = StringUtils.EMPTY;
			if (persp != null) {
				label = persp.getLabel();
			}
			IAdaptable input = currentPage.getInput();
			if (input != null && !input.equals(wbAdvisor.getDefaultPageInput())) {
				label = currentPage.getLabel();
			}
			if (label != null && !label.equals(StringUtils.EMPTY)) { //$NON-NLS-1$ 
				title = NLS.bind(
						IDEWorkbenchMessages.WorkbenchWindow_shellTitle, label,
						title);
			}
		}

		String workspaceLocation = wbAdvisor.getWorkspaceLocation();
		if (workspaceLocation != null) {
			title = NLS.bind(IDEWorkbenchMessages.WorkbenchWindow_shellTitle,
					title, workspaceLocation);
		}

//		title = title.replaceAll(" Aptana Studio", " Aptana Studio Community Edition"); //$NON-NLS-1$ //$NON-NLS-2$
 
		return title;
	}

	private void recomputeTitle() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		String oldTitle = configurer.getTitle();
		String newTitle = computeTitle();
		if (!newTitle.equals(oldTitle)) {
			configurer.setTitle(newTitle);
		}
	}

	/**
	 * Updates the window title. Format will be: [pageInput -]
	 * [currentPerspective -] [editorInput -] [workspaceLocation -] productName
	 */
	private void updateTitle() {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		IWorkbenchWindow window = configurer.getWindow();
		IEditorPart activeEditor = null;
		IWorkbenchPage currentPage = window.getActivePage();
		IPerspectiveDescriptor persp = null;
		IAdaptable input = null;

		if (currentPage != null) {
			activeEditor = currentPage.getActiveEditor();
			persp = currentPage.getPerspective();
			input = currentPage.getInput();
		}

		// Nothing to do if the editor hasn't changed
		if (activeEditor == lastActiveEditor && currentPage == lastActivePage
				&& persp == lastPerspective && input == lastInput) {
			return;
		}

		if (lastActiveEditor != null) {
			lastActiveEditor.removePropertyListener(editorPropertyListener);
		}

		lastActiveEditor = activeEditor;
		lastActivePage = currentPage;
		lastPerspective = persp;
		lastInput = input;

		if (activeEditor != null) {
			activeEditor.addPropertyListener(editorPropertyListener);
		}

		recomputeTitle();
	}

    private static String getTitle(IEditorPart part)
    {
        String title = part.getTitleToolTip();
        return title.equals(StringUtils.EMPTY) ? part.getTitle() : title;
    }

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchAdvisor#postWindowRestore
	 */
	public void postWindowRestore() throws WorkbenchException {
		IWorkbenchWindowConfigurer configurer = getWindowConfigurer();
		IWorkbenchWindow window = configurer.getWindow();

		int index = getWorkbench().getWorkbenchWindowCount() - 1;

		AboutInfo[] welcomePerspectiveInfos = wbAdvisor
				.getWelcomePerspectiveInfos();
		if (index >= 0 && welcomePerspectiveInfos != null
				&& index < welcomePerspectiveInfos.length) {
			// find a page that exist in the window
			IWorkbenchPage page = window.getActivePage();
			if (page == null) {
				IWorkbenchPage[] pages = window.getPages();
				if (pages != null && pages.length > 0) {
					page = pages[0];
				}
			}

			// if the window does not contain a page, create one
			String perspectiveId = welcomePerspectiveInfos[index]
					.getWelcomePerspectiveId();
			if (page == null) {
				IAdaptable root = wbAdvisor.getDefaultPageInput();
				page = window.openPage(perspectiveId, root);
			} else {
				IPerspectiveRegistry reg = getWorkbench()
						.getPerspectiveRegistry();
				IPerspectiveDescriptor desc = reg
						.findPerspectiveWithId(perspectiveId);
				if (desc != null) {
					page.setPerspective(desc);
				}
			}

			// set the active page and open the welcome editor
			window.setActivePage(page);
			page.openEditor(new WelcomeEditorInput(
					welcomePerspectiveInfos[index]), WELCOME_EDITOR_ID, true);
		}
	}

	/**
	 * Tries to open the intro, if one exists and otherwise will open the legacy
	 * Welcome pages.
	 * 
	 * @see org.eclipse.ui.application.WorkbenchWindowAdvisor#openIntro()
	 */
	public void openIntro() {
		if (editorsAndIntrosOpened) {
			return;
		}

		editorsAndIntrosOpened = true;

		// don't try to open the welcome editors if there is an intro
		if (wbAdvisor.hasIntro()) {
			super.openIntro();
		} else {
			openWelcomeEditors(getWindowConfigurer().getWindow());
			// save any preferences changes caused by the above actions
			IDEWorkbenchPlugin.getDefault().savePluginPreferences();
		}
	}

	/*
	 * Open the welcome editor for the primary feature and for any newly
	 * installed features.
	 */
	private void openWelcomeEditors(IWorkbenchWindow window) {
		if (IDEWorkbenchPlugin.getDefault().getPreferenceStore().getBoolean(
				IDEInternalPreferences.WELCOME_DIALOG)) {
			// show the welcome page for the product the first time the
			// workbench opens
			IProduct product = Platform.getProduct();
			if (product == null) {
				return;
			}

			AboutInfo productInfo = new AboutInfo(product);
			URL url = productInfo.getWelcomePageURL();
			if (url == null) {
				return;
			}

			IDEWorkbenchPlugin.getDefault().getPreferenceStore().setValue(
					IDEInternalPreferences.WELCOME_DIALOG, false);
			openWelcomeEditor(window, new WelcomeEditorInput(productInfo), null);
		} else {
			// Show the welcome page for any newly installed features
			List welcomeFeatures = new ArrayList();
			for (Iterator it = wbAdvisor.getNewlyAddedBundleGroups().entrySet()
					.iterator(); it.hasNext();) {
				Map.Entry entry = (Map.Entry) it.next();
				String versionedId = (String) entry.getKey();
				String featureId = versionedId.substring(0, versionedId
						.indexOf(':'));
				AboutInfo info = (AboutInfo) entry.getValue();

				if (info != null && info.getWelcomePageURL() != null) {
					welcomeFeatures.add(info);
					// activate the feature plug-in so it can run some install
					// code
					IPlatformConfiguration platformConfiguration = ConfiguratorUtils
							.getCurrentPlatformConfiguration();
					IPlatformConfiguration.IFeatureEntry feature = platformConfiguration
							.findConfiguredFeatureEntry(featureId);
					if (feature != null) {
						String pi = feature.getFeaturePluginIdentifier();
						if (pi != null) {
							// Start the bundle if there is one
							Bundle bundle = Platform.getBundle(pi);
							if (bundle != null) {
								try {
									bundle.start(Bundle.START_TRANSIENT);
								} catch (BundleException exception) {
									StatusManager
											.getManager()
											.handle(
													new Status(
															IStatus.ERROR,
															IDEApplication.PLUGIN_ID,
															"Failed to load feature", exception));//$NON-NLS-1$
								}
							}
						}
					}
				}
			}

			int wCount = getWorkbench().getWorkbenchWindowCount();
			for (int i = 0; i < welcomeFeatures.size(); i++) {
				AboutInfo newInfo = (AboutInfo) welcomeFeatures.get(i);
				String id = newInfo.getWelcomePerspectiveId();
				// Other editors were already opened in postWindowRestore(..)
				if (id == null || i >= wCount) {
					openWelcomeEditor(window, new WelcomeEditorInput(newInfo),
							id);
				}
			}
		}
	}

	/**
	 * Open a welcome editor for the given input
	 */
	private void openWelcomeEditor(IWorkbenchWindow window,
			WelcomeEditorInput input, String perspectiveId) {
		if (getWorkbench().getWorkbenchWindowCount() == 0) {
			// Something is wrong, there should be at least
			// one workbench window open by now.
			return;
		}

		IWorkbenchWindow win = window;
		if (perspectiveId != null) {
			try {
				win = getWorkbench().openWorkbenchWindow(perspectiveId,
						wbAdvisor.getDefaultPageInput());
				if (win == null) {
					win = window;
				}
			} catch (WorkbenchException e) {
				IDEWorkbenchPlugin
						.log(
								"Error opening window with welcome perspective.", e.getStatus()); //$NON-NLS-1$
				return;
			}
		}

		if (win == null) {
			win = getWorkbench().getWorkbenchWindows()[0];
		}

		IWorkbenchPage page = win.getActivePage();
		String id = perspectiveId;
		if (id == null) {
			id = getWorkbench().getPerspectiveRegistry()
					.getDefaultPerspective();
		}

		if (page == null) {
			try {
				page = win.openPage(id, wbAdvisor.getDefaultPageInput());
			} catch (WorkbenchException e) {
				ErrorDialog.openError(win.getShell(),
						IDEWorkbenchMessages.Problems_Opening_Page, e
								.getMessage(), e.getStatus());
			}
		}
		if (page == null) {
			return;
		}

		if (page.getPerspective() == null) {
			try {
				page = getWorkbench().showPerspective(id, win);
			} catch (WorkbenchException e) {
				ErrorDialog
						.openError(
								win.getShell(),
								IDEWorkbenchMessages.Workbench_openEditorErrorDialogTitle,
								IDEWorkbenchMessages.Workbench_openEditorErrorDialogMessage,
								e.getStatus());
				return;
			}
		}

		page.setEditorAreaVisible(true);

		// see if we already have an editor
		IEditorPart editor = page.findEditor(input);
		if (editor != null) {
			page.activate(editor);
			return;
		}

		try {
			page.openEditor(input, WELCOME_EDITOR_ID);
		} catch (PartInitException e) {
			ErrorDialog
					.openError(
							win.getShell(),
							IDEWorkbenchMessages.Workbench_openEditorErrorDialogTitle,
							IDEWorkbenchMessages.Workbench_openEditorErrorDialogMessage,
							e.getStatus());
		}
		return;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.eclipse.ui.application.WorkbenchAdvisor#createEmptyWindowContents(org.eclipse.ui.application.IWorkbenchWindowConfigurer,
	 *      org.eclipse.swt.widgets.Composite)
	 */
	public Control createEmptyWindowContents(Composite parent) {
		final IWorkbenchWindow window = getWindowConfigurer().getWindow();
		Composite composite = new Composite(parent, SWT.NONE);
		composite.setLayout(new GridLayout(2, false));
		Display display = composite.getDisplay();
		Color bgCol = display
				.getSystemColor(SWT.COLOR_TITLE_INACTIVE_BACKGROUND);
		composite.setBackground(bgCol);
		Label label = new Label(composite, SWT.WRAP);
		label.setForeground(display
				.getSystemColor(SWT.COLOR_TITLE_INACTIVE_FOREGROUND));
		label.setBackground(bgCol);
		label.setFont(JFaceResources.getFontRegistry().getBold(
				JFaceResources.DEFAULT_FONT));
		String msg = IDEWorkbenchMessages.IDEWorkbenchAdvisor_noPerspective;
		label.setText(msg);
		ToolBarManager toolBarManager = new ToolBarManager();
		// TODO: should obtain the open perspective action from ActionFactory
		openPerspectiveAction = ActionFactory.OPEN_PERSPECTIVE_DIALOG
				.create(window);
		toolBarManager.add(openPerspectiveAction);
		ToolBar toolBar = toolBarManager.createControl(composite);
		toolBar.setBackground(bgCol);
		return composite;
	}
	/* (non-Javadoc)
	 * @see org.eclipse.ui.application.WorkbenchWindowAdvisor#dispose()
	 */
	public void dispose() {
		if (openPerspectiveAction!=null) {
			openPerspectiveAction.dispose();
			openPerspectiveAction = null;
		}
		super.dispose();
	}

}
