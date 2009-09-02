;ExperienceUI for NSIS
;Header Bitmap Example Script
;Written by Dan Fuhry

;OK, I cheated, Joost wrote it :)

;---------------------
;Include ExperienceUI

  !include "XPUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "ExperienceUI Test 1.1"
  OutFile "InstallOptions.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\ExperienceUI Test"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\ExperienceUI Test" ""

;--------------------------------
;Pages

  !insertmacro XPUI_PAGE_LICENSE "${NSISDIR}\Docs\ExperienceUI\Text.htm"
  Page custom CustomPageA
  !insertmacro XPUI_PAGE_COMPONENTS
  Page custom CustomPageB
  !insertmacro XPUI_PAGE_DIRECTORY
  Page custom CustomPageC
  !insertmacro XPUI_PAGE_INSTFILES
  
  !insertmacro XPUI_PAGEMODE_UNINST
  !insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
  !insertmacro XPUI_PAGE_INSTFILES
  
;--------------------------------
;Interface Settings

  !define XPUI_ABORTWARNING
  
;--------------------------------
;Languages
 
  !insertmacro XPUI_LANGUAGE "English"

;--------------------------------
;Reserve Files
  
  ;These files should be inserted before other files in the data block
  ;Keep these lines before any File command
  ;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)
  
  ReserveFile "ioA.ini"
  ReserveFile "ioB.ini"
  ReserveFile "ioC.ini"
  !insertmacro XPUI_RESERVEFILE_INSTALLOPTIONS

;--------------------------------
;Variables

  Var INI_VALUE

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  
  ;Store installation folder
  WriteRegStr HKCU "Software\ExperienceUI Test" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  ;Read a value from an InstallOptions INI file
  !insertmacro XPUI_INSTALLOPTIONS_READ $INI_VALUE "ioC.ini" "Field 2" "State"
  
  ;Display a messagebox if check box was checked
  StrCmp $INI_VALUE "1" "" +2
    MessageBox MB_OK "You checked the check box, here is the MessageBox..."

SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

  ;Extract InstallOptions INI files
  !insertmacro XPUI_INSTALLOPTIONS_EXTRACT "ioA.ini"
  !insertmacro XPUI_INSTALLOPTIONS_EXTRACT "ioB.ini"
  !insertmacro XPUI_INSTALLOPTIONS_EXTRACT "ioC.ini"
  
FunctionEnd

LangString TEXT_IO_TITLE ${LANG_ENGLISH} "InstallOptions page"
LangString TEXT_IO_SUBTITLE ${LANG_ENGLISH} "This is a page created using the InstallOptions plug-in."

Function CustomPageA

  !insertmacro XPUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
  !insertmacro XPUI_INSTALLOPTIONS_DISPLAY "ioA.ini"

FunctionEnd

Function CustomPageB

  !insertmacro XPUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
  !insertmacro XPUI_INSTALLOPTIONS_DISPLAY "ioB.ini"

FunctionEnd

Function CustomPageC

  !insertmacro XPUI_HEADER_TEXT "$(TEXT_IO_TITLE)" "$(TEXT_IO_SUBTITLE)"
  !insertmacro XPUI_INSTALLOPTIONS_DISPLAY "ioC.ini"

FunctionEnd

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