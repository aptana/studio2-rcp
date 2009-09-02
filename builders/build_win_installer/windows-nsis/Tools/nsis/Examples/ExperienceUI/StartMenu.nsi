;ExperienceUI for NSIS
;Header Bitmap Example Script
;Written by Dan Fuhry

;OK, I cheated, Joost wrote it :)

!define XPUI_WANSIS

;--------------------------------
;Include ExperienceUI

  !include "XPUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ExperienceUI Test"
  OutFile "StartMenu.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\ExperienceUI Test"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\ExperienceUI Test" ""

;--------------------------------
;Variables

  Var XPUI_TEMP
  Var STARTMENU_FOLDER

;--------------------------------
;Interface Settings

  !define XPUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
  !insertmacro XPUI_PAGE_COMPONENTS
  !insertmacro XPUI_PAGE_DIRECTORY
  
  ;Start Menu Folder Page Configuration
  !define XPUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU"
  !define XPUI_STARTMENUPAGE_REGISTRY_KEY "Software\ExperienceUI Test"
  !define XPUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro XPUI_PAGE_STARTMENU Application $STARTMENU_FOLDER
  
  !insertmacro XPUI_PAGE_INSTFILES
  !insertmacro XPUI_PAGE_FINISH
  !insertmacro XPUI_PAGE_ABORT
  
  !insertmacro XPUI_PAGEMODE_UNINST
  !insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
  !insertmacro XPUI_PAGE_INSTFILES

;--------------------------------
;Languages
 
  !insertmacro XPUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\ExperienceUI Test" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  !insertmacro XPUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
  !insertmacro XPUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro XPUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro XPUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro XPUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"
  
  !insertmacro XPUI_STARTMENU_GETFOLDER Application $XPUI_TEMP
    
  Delete "$SMPROGRAMS\$XPUI_TEMP\Uninstall.lnk"
  
  ;Delete empty start menu parent diretories
  StrCpy $XPUI_TEMP "$SMPROGRAMS\$XPUI_TEMP"
 
  startMenuDeleteLoop:
	ClearErrors
    RMDir $XPUI_TEMP
    GetFullPathName $XPUI_TEMP "$XPUI_TEMP\.."
    
    IfErrors startMenuDeleteLoopDone
  
    StrCmp $XPUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  DeleteRegKey /ifempty HKCU "Software\ExperienceUI Test"

SectionEnd