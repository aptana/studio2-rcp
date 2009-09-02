;ExperienceUI for NSIS
;Welcome/Finish Page Example Script
;Written by Dan Fuhry

;OK, I cheated, Joost wrote it :)

;--------------------------------
;Include ExperienceUI

  !define XPUI_SKIN Win2k
  !include "XPUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ExperienceUI Test"
  OutFile "WelcomeFinish.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\ExperienceUI Test"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\ExperienceUI Test" ""

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGE_ABORT
  !endif

  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGEMODE_UNINST
    !insertmacro XPUI_PAGE_WELCOME
    !insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
    !insertmacro XPUI_PAGE_INSTFILES
    !insertmacro XPUI_PAGE_FINISH
    !insertmacro XPUI_PAGE_ABORT
  !else
    !insertmacro MUI_UNPAGE_WELCOME
    !insertmacro MUI_UNPAGE_CONFIRM
    !insertmacro MUI_UNPAGE_INSTFILES
    !insertmacro MUI_UNPAGE_FINISH
  !endif
  
  !ifdef XPUI_VERSION
    !insertmacro XPUI_PAGE_ABORT
  !endif
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\ExperienceUI Test" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END
 
;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\ExperienceUI Test"

SectionEnd  