;ExperienceUI for NSIS
;Header Bitmap Example Script
;Written by Dan Fuhry

;OK, I cheated, Joost wrote it :)

;--------------------------------
;Include ExperienceUI

  !include "XPUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ExperienceUI Test"
  OutFile "HeaderBitmap.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\ExperienceUI Test"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\ExperienceUI Test" ""

;--------------------------------
;Interface Configuration

  !define XPUI_HEADERIMAGE "${NSISDIR}\Contrib\ExperienceUI\Skins\Windows XP\Header.bmp"
  ; might as well do a bottom image as well...
  !define XPUI_BOTTOMIMAGE ;we don't have to define a custom bottom image, the default is fine.
  !define XPUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
  !insertmacro XPUI_PAGE_COMPONENTS
  !insertmacro XPUI_PAGE_DIRECTORY
  !insertmacro XPUI_PAGE_INSTFILES
  
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

  DeleteRegKey /ifempty HKCU "Software\ExperienceUI Test"

SectionEnd