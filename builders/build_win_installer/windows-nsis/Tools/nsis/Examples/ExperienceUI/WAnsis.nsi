SetCompressor /SOLID /FINAL lzma

!define       XPUI_WANSIS
!define       XPUI_TEXT_COLOR 30343D
!define       XPUI_TEXT_BGCOLOR 8DB174
!define       XPUI_TEXT_LIGHTCOLOR FFFFFF
!define       XPUI_WANSIS_SKIN Gangsta
!define       XPUI_WANSIS_HEADERIMAGE
!define       XPUI_BUTTONTEXT_CLOSE "Finish"
!define       XPUI_FINISHPAGE_TEXT "Setup has successfully installed $(^Name) on your computer.\r\n\r\nBut we're NOT DONE YET!\r\n\r\n\r\n\r\n\r\nPlease click Finish to find out what's just around the corner..."
!define       XPUI_LICENSEPAGE_RADIOBUTTONS
;!define       XPUI_SKIN "Windows XP"
!define       XPUI_DISABLEBG
!define       XPUI_BOTTOMIMAGE

!include      XPUI.nsh

!define       XPUI_ABORTWARNING
!define       XPUI_UNABORTWARNING

!insertmacro  XPUI_LANGUAGE English
!define       XPUI_FINISHPAGE_TEXT_USE_TOP_ALT
!define       XPUI_UNFINISHPAGE_TEXT_USE_TOP_ALT

!define       XPUI_PAGE_CUSTOMFUNCTION_PRE SetTime
!insertmacro  XPUI_PAGE_WELCOME
!insertmacro  XPUI_PAGE_WELCOME2
!insertmacro  XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
!insertmacro  XPUI_PAGE_COMPONENTS
!insertmacro  XPUI_PAGE_DIRECTORY
!insertmacro  XPUI_PAGE_STARTMENU App $0
!insertmacro  XPUI_PAGE_INSTCONFIRM
!insertmacro  XPUI_PAGE_INSTFILES
!insertmacro  XPUI_PAGE_FINISH
!insertmacro  XPUI_PAGE_ABORT

!insertmacro  XPUI_PAGEMODE_UNINST
!insertmacro  XPUI_PAGE_WELCOME
!insertmacro  XPUI_PAGE_WELCOME2
!insertmacro  XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
!insertmacro  XPUI_PAGE_COMPONENTS
!insertmacro  XPUI_PAGE_DIRECTORY
!insertmacro  XPUI_PAGE_STARTMENU UninstApp $0
!insertmacro  XPUI_PAGE_INSTCONFIRM
!insertmacro  XPUI_PAGE_INSTFILES
!insertmacro  XPUI_PAGE_FINISH
!insertmacro  XPUI_PAGE_ABORT

Icon D:\Nullsoft\NSIS2\Contrib\Graphics\Icons\modern-install-colorful.ico
UninstallIcon D:\Nullsoft\NSIS2\Contrib\Graphics\Icons\modern-uninstall-colorful.ico

Name "ExperienceUI $\"Bryce$\" Milestone One WAnsis Test"
OutFile WAnsis.exe
InstallDir $PROGRAMFILES\$(^Name)

Section "Program"
  DetailPrint "Installing program (nah!)..."
  WriteUninstaller $EXEDIR\WAnsis-Uninst.exe
SectionEnd

SectionGroup /e "Documentation"
  Section "Help"
    DetailPrint "Installing docs (nah!)..."
  SectionEnd

  Section "Reference"
    DetailPrint "Installing docs (nah!)..."
  SectionEnd
SectionGroupEnd

Section "Source code"
  DetailPrint "Installing souce code (nah!)..."
SectionEnd

!insertmacro XPUI_PAGEMODE_INST
!undef        XPUI_FINISHPAGE_TEXT_USE_TOP_ALT
!define       XPUI_FINISHPAGE_LINK
!define       XPUI_FINISHPAGE_LINK_TEXT "Here is a link. (No function set here, but functionality is obvious)"
!define       XPUI_PAGE_CUSTOMFUNCTION_PRE ChangeSkin
!insertmacro  XPUI_PAGE_WELCOME
!insertmacro  XPUI_PAGE_WELCOME2
!insertmacro  XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
!insertmacro  XPUI_PAGE_COMPONENTS
!insertmacro  XPUI_PAGE_DIRECTORY
!insertmacro  XPUI_PAGE_INSTCONFIRM
!insertmacro  XPUI_PAGE_INSTFILES
!define       XPUI_PAGE_CUSTOMFUNCTION_SHOW SetTextOnFinish
!insertmacro  XPUI_PAGE_FINISH
!insertmacro  XPUI_PAGE_ABORT

!insertmacro XPUI_PAGEMODE_UNINST
!undef        XPUI_UNFINISHPAGE_TEXT_USE_TOP_ALT
!define       XPUI_UNFINISHPAGE_LINK
!define       XPUI_UNFINISHPAGE_LINK_TEXT "Here is a link. (No function set here, but functionality is obvious)"
!define       XPUI_UNPAGE_CUSTOMFUNCTION_PRE un.ChangeSkin
!insertmacro  XPUI_PAGE_WELCOME
!insertmacro  XPUI_PAGE_WELCOME2
!insertmacro  XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
!insertmacro  XPUI_PAGE_COMPONENTS
!insertmacro  XPUI_PAGE_DIRECTORY
!insertmacro  XPUI_PAGE_INSTCONFIRM
!insertmacro  XPUI_PAGE_INSTFILES
!define       XPUI_PAGE_CUSTOMFUNCTION_SHOW un.SetTextOnFinish
!insertmacro  XPUI_PAGE_FINISH
!insertmacro  XPUI_PAGE_ABORT

Function SetTime
!insertmacro XPUI_LEFT_SETTIME "This is a test"
FunctionEnd

; /*
Function ChangeSkin
LockWindow on
SetOutPath $PLUGINSDIR
File "${NSISDIR}\Contrib\ExperienceUI\Skins\LCD\*.bmp"
SetBrandingImage /IMGID=1302 /RESIZETOFIT $PLUGINSDIR\LeftLogo.bmp
SetBrandingImage /IMGID=1039 /RESIZETOFIT $PLUGINSDIR\bottom.bmp
SetBrandingImage /IMGID=1046 /RESIZETOFIT $PLUGINSDIR\Header.bmp
wansis::setskin /NOUNLOAD "$PLUGINSDIR\gen.bmp" "$PLUGINSDIR\genex.bmp"
FunctionEnd
; */

; /*
Function un.ChangeSkin
LockWindow on
SetOutPath $PLUGINSDIR
File "${NSISDIR}\Contrib\ExperienceUI\Skins\LCD\*.bmp"
SetBrandingImage /IMGID=1302 /RESIZETOFIT $PLUGINSDIR\LeftLogo.bmp
SetBrandingImage /IMGID=1039 /RESIZETOFIT $PLUGINSDIR\bottom.bmp
SetBrandingImage /IMGID=1046 /RESIZETOFIT $PLUGINSDIR\Header.bmp
wansis::setskin /NOUNLOAD "$PLUGINSDIR\gen.bmp" "$PLUGINSDIR\genex.bmp"
FunctionEnd
; */

Function SetTextOnFinish
GetDlgItem $0 $XPUI_TEMP2 1204
SendMessage $0 0xC 0 "STR:Setup has successfully installed $(^Name) on your computer.$\r$\n$\r$\nPlease click $(XPUI_BUTTONTEXT_CLOSE) to exit Setup."
FunctionEnd

Function un.SetTextOnFinish
GetDlgItem $0 $XPUI_TEMP2 1204
SendMessage $0 0xC 0 "STR:Setup has successfully uninstalled $(^Name) from your computer.$\r$\n$\r$\nPlease click $(XPUI_BUTTONTEXT_CLOSE) to exit Setup."
FunctionEnd

Function .onInit
  InitPluginsDir
  SetOutPath $PLUGINSDIR
  File /oname=splash.bmp "${NSISDIR}\Contrib\ExperienceUI\LargeLogo.bmp"
  AdvSplash::Show 5000 1000 1000 -1 "$PLUGINSDIR\splash"
FunctionEnd