/**
 * Copyright (c) 2005-2009 Aptana, Inc.
 *
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html. If redistributing this code,
 * this entire header must remain intact.
 */
package com.aptana.ide.rcp.main.preferences;

/**
 * Contains all preferences for the com.aptana.ide.rcp.main plugin. To add a
 * preference, create a static string with an all-uppercase preference key. Then
 * assign a identically-named string to it, prefixing it with the plugin name,
 * i.e. SHOW_WHITESPACE = "com.aptana.ide.server.ui.SHOW_WHITESPACE".
 * 
 * @author Ingo Muschenetz
 */
public interface IPreferenceConstants {

    /**
     * WORKSPACE_ENCODING_SET
     */
    String WORKSPACE_ENCODING_SET = "com.aptana.ide.rcp.main.WORKSPACE_ENCODING_SET"; //$NON-NLS-1$
}
