/*
ExperienceUI for NSIS:
"Windows Notepad"
Real World Installation Script (9/24/05) version 1.1
Structure:

Start
  |
  +--Basic Info
  |
  +--XPUI: Pages
  |  |
  |  --XPUI Page Functions
  |
  +--Version Signature Info
  +--Callback Functions
  |  |
  |  +--.onInit
  |  +--.onInstSuccess
  |  +--.onUserAbort
  |
  +--Data Macros
  |  |
  |  +--Base Files
  |  +--Start Menu LNKs
  |
  +--Sections
  |  |
  |  +--SubSection: Files
  |     |
  |     +--Section: Base Files
  |     +--Section: Start Menu LNKs
  |
  +--Repair
  |  |
  |  +--Maintenance Selection Page
  |  +--Maintenance Selection Page Verifier
  |  +--Repair Comfirm Page
  |  |  |
  |  |  +--Copy Files "Page"
  |  |
  |  +--Repair Success Page
  |
  +--Uninstall
  |  |
  |  +--Pages
  |  |  |
  |  |  +--Page Table
  |  |  +--RMDir Notice
  |  |
  |  +--Uninstall Files Function
  |  +--Uninstall Section
  |
 End

*/

CRCCheck off
SetCompressor /FINAL lzma
SetCompressorDictSize 32

######################################################
#                     BASIC INFO                     #
######################################################

!define NAME "Windows Notepad"
!define VERSION 5.1.2600.2180
!define EXECUTABLE "Notepad.exe"
Name "${NAME}"
Caption "$(^Name)"
OutFile NotepadSampleSetup.exe
InstallDir "$PROGRAMFILES\${NAME}"
InstallDirRegKey HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name) InstallDir

MiscButtonText "Previous" "Next" "Cancel" "Close"
CheckBitmap ${NSISDIR}\Contrib\Graphics\Checks\Modern.bmp

!define XPUI_SKIN "Orange"
!define XPUI_DISABLEBG
!define XPUI_LICENSEBKCOLOR ${XPUI_TEXT_BGCOLOR}
!define XPUI_LICENSEPAGE_CHECKBOX
!define XPUI_FINISHPAGE_RUN
!define XPUI_FINISHPAGE_RUN_FILE "$INSTDIR\Notepad.exe"
!define XPUI_FINISHPAGE_TEXT_USE_TOP_ALT
!define MUI_ABORTWARNING
!define XPUI_VERBOSE 4
!include XPUI.nsh
!include system.nsh
!insertmacro XPUI_RESERVEFILE_HEADERIMAGE
!insertmacro XPUI_RESERVEFILE_BOTTOMIMAGE
!insertmacro XPUI_RESERVEFILE_LEFTBRANDINGIMAGE

######################################################
#                     XPUI: PAGES                    #
######################################################

Page custom setrepair setrpverify " "
Page custom repair rpverify " "
Page custom repaircomplete "" " "
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW WelSetTime
!insertmacro XPUI_PAGE_WELCOME
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW LicSetTime
!insertmacro XPUI_PAGE_LICENSE "${NSISDIR}\Contrib\ExperienceUI\License.rtf"
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW CmpSetTime
!insertmacro XPUI_PAGE_COMPONENTS
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW DirSetTime
!insertmacro XPUI_PAGE_DIRECTORY
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW ICSetTime
!insertmacro XPUI_PAGE_INSTCONFIRM
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW IFSetTime
!insertmacro XPUI_PAGE_INSTFILES
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW ISSetTime
!insertmacro XPUI_PAGE_FINISH
!define XPUI_PAGE_CUSTOMFUNCTION_SHOW ABSetTime
!insertmacro XPUI_PAGE_ABORT

!insertmacro XPUI_LANGUAGE English

######################################################
#                   PAGE FUNCTIONS                   #
######################################################

Function WelSetTime
BringToFront
!insertmacro XPUI_LEFT_SETTIME "10 Minutes"
FunctionEnd

Function LicSetTime
!insertmacro XPUI_LEFT_SETTIME "8 Minutes"
FunctionEnd

Function CmpSetTime
!insertmacro XPUI_LEFT_SETTIME "6 Minutes"
FunctionEnd

Function DirSetTime
!insertmacro XPUI_LEFT_SETTIME "4 Minutes"
FunctionEnd

Function ICSetTime
!insertmacro XPUI_LEFT_SETTIME "2 Minutes"
FunctionEnd

Function IFSetTime
!insertmacro XPUI_LEFT_SETTIME "1 Minute"
FunctionEnd

Function ISSetTime
!insertmacro XPUI_LEFT_SETTIME "Less Than 1 Minute"
SetAutoClose true
FunctionEnd

Function ABSetTime
!insertmacro XPUI_LEFT_SETTIME "Not anytime soon..."
FunctionEnd

######################################################
#                  VERSION SIGNATURE                 #
######################################################

VIProductVersion "1.0.0.1"
VIAddVersionKey /LANG=1033 "FileVersion" "${VERSION}"
VIAddVersionKey /LANG=1033 "ProductVersion" "${VERSION}"
VIAddVersionKey /LANG=1033 "ProductName" "${NAME}"
VIAddVersionKey /LANG=1033 "Comments" "This installer was written by Dan Fuhry using Nullsoft Scriptable Install System (http://nsis.sourceforge.net)"
VIAddVersionKey /LANG=1033 "CompanyName" "Fuhry Computers, Inc."
VIAddVersionKey /LANG=1033 "LegalTrademarks" "${NAME} by Dan Fuhry. Copyright © 2004-2005 Fuhry Computers, Inc."
VIAddVersionKey /LANG=1033 "LegalCopyright" "Copyright © Dan Fuhry"
VIAddVersionKey /LANG=1033 "FileDescription" "${NAME} Setup/Maintenance Program"
VIAddVersionKey /LANG=1033 "SpecialBuild" "${NAME} Setup, built on ${__TIMESTAMP__}"

######################################################
#                   INITIALIZATION                   #
######################################################

Var WB
Var WBUNLOADED

Function .onInit
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds InstallLocation
IfFileExists $0\WBLoad.exe "" NoWB
StrCpy $WB 1
MessageBox MB_YESNO|MB_ICONQUESTION "Setup has found WindowBlinds on your system.  If WindowBlinds is loaded, it may cause visual problems with the Install Wizard.$\nDo you want to unload WindowBlinds now? (assuming it is loaded)" IDNO NoWB
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds InstallLocation
ExecWait '"$0\WBLoad.exe" UNLOAD'
StrCpy $WBUNLOADED 1
NoWB:
InitPluginsDir
FunctionEnd

######################################################
#                INSTALLATION SUCCESS                #
######################################################

Function .onInstSuccess
HideWindow
StrCmp $WBUNLOADED 1 "" NoWB
MessageBox MB_YESNO|MB_ICONQUESTION "You unloaded WindowBlinds when you started Setup. Do you want to load it again now?" IDNO NoWB
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds InstallLocation
ExecWait "$0\WBLoad.exe"
StrCpy $WB 1
NoWB:
FunctionEnd

######################################################
#                     USER ABORT                     #
######################################################

/*
Function .onUserAbort
StrCmp $NOABORTWARNING 1 NoWarn
MessageBox MB_YESNO|MB_ICONQUESTION "Are you sure you want to cancel Setup?" IDYES NoWarn
Abort:
Abort
NoWarn:
StrCmp $WBUNLOADED 1 "" NoWB
MessageBox MB_YESNOCANCEL|MB_ICONQUESTION "You unloaded WindowBlinds when you started Setup. Do you want to load it again now?" IDNO NoWB IDCANCEL Abort
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds InstallLocation
Exec $0\WBLoad.exe
NoWB:
FunctionEnd
*/

######################################################
#                    INSTALL DATA                    #
######################################################

Var INSTALLING_README

!macro INSTALL_BASEFILES
StrCpy $INSTALLING_README 0
SetOutPath "$INSTDIR"
File Data\Notepad.exe
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString "$INSTDIR\Uninst.exe"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" ModifyPath "$INSTDIR\Setup.exe"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon "$INSTDIR\${EXECUTABLE}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" InstallDir "$INSTDIR"
WriteUninstaller $INSTDIR\Uninst.exe
Call GetInstallerEXEName
Pop $0
StrCmp $0 "" "" +3
CopyFiles $CMDLINE $INSTDIR\Setup.exe
Goto +2
CopyFiles $0 $INSTDIR\Setup.exe
!macroend

!macro INSTALL_STARTLNK
CreateDirectory $SMPROGRAMS\$(^Name)
CreateShortcut "$SMPROGRAMS\$(^Name)\$(^Name).lnk" $INSTDIR\${EXECUTABLE}
CreateShortcut $SMPROGRAMS\$(^Name)\Uninstall.lnk $INSTDIR\Uninst.exe
!macroend

######################################################
#                      SECTIONS                      #
######################################################

ShowInstDetails show
InstType "Standard Install"
InstType "Standard Install (sans Start Menu Shortcuts)"

SubSection "!$(^Name) - Files" SubFiles

Section "Base Files (Required)" SecBase
FindWindow $0 "#32770" "" $HWNDPARENT
GetDlgItem $1 $0 1016
ShowWindow $1 ${SW_HIDE}
SetDetailsPrint textonly
DetailPrint "Initializing Installation..."
SetDetailsPrint listonly
Sleep 1000
FindWindow $0 "#32770" "" $HWNDPARENT
GetDlgItem $1 $0 1016
ShowWindow $1 ${SW_SHOW}
SectionIn RO
SectionIn 1 2
SetDetailsPrint textonly
DetailPrint "Installing Base Files..."
SetDetailsPrint listonly
!insertmacro INSTALL_BASEFILES
SetAutoClose true
SectionEnd

Section "Start Menu Shortcuts" SecLNK
SectionIn 1
SetDetailsPrint textonly
DetailPrint "Installing Start Menu Shortcuts..."
SetDetailsPrint listonly
!insertmacro INSTALL_STARTLNK
SectionEnd

SubSectionEnd

Section "Review Installation Details After Setup" SecReview
SectionIn 1 2
SetAutoClose false
SetDetailsPrint textonly
DetailPrint "Installation Complete"
SetDetailsPrint both
SectionEnd

Section -post
!insertmacro XPUI_HEADER_TEXT "Installation Complete" "Setup has successfully installed $(^Name) on your computer."
DetailPrint `SetBrandingImage /IMGID=1302 "$$PLUGINSDIR\Header.bmp"`
DetailPrint "GetDlgItem $$0 $$HWNDPARENT 1037"
DetailPrint `SendMessage $$0 0xC 0 "STR:Installation Complete"`
DetailPrint "GetDlgItem $$0 $$HWNDPARENT 1038"
DetailPrint `SendMessage $$0 0xC 0 "STR:Setup has successfully installed $(^Name) on your computer."`
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 0xC 0 "STR:Finish"
SectionEnd

!insertmacro XPUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro XPUI_DESCRIPTION_TEXT ${SubFiles} "$(^Name) - Files to Install"
!insertmacro XPUI_DESCRIPTION_TEXT ${SecBase} "$(^Name)'s Base Files"
!insertmacro XPUI_DESCRIPTION_TEXT ${SecLNK} "Start Menu Shortcuts for easy access"
!insertmacro XPUI_DESCRIPTION_TEXT ${SecReview} "Rewiew the installation log window after Setup completes"
!insertmacro XPUI_FUNCTION_DESCRIPTION_END

######################################################
#                       REPAIR                       #
######################################################

Function setrepair
!ifdef XPUI_CUSTOMSKIN
!insertmacro XPUI_UNSET XPUI_SET_BG_INSERTED
!insertmacro XPUI_SET_BG
!endif
!ifndef XPUI_CUSTOMSKIN
!insertmacro SETBG_NSIS
!endif
FindWindow $0 "#32770" "$(^Name)"
SendMessage $0 ${WM_SETFOCUS} 1 1
ShowWindow $0 1
BringToFront
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name) DisplayName
StrCmp $0 "" "" +2
Abort
!insertmacro XPUI_INSTALLOPTIONS_EXTRACT_AS "${NSISDIR}\Contrib\ExperienceUI\INI\Repair.ini" "Repair.ini"
!insertmacro XPUI_HEADER_TEXT `Welcome to the $(^Name) Setup Wizard` `Select which maintenance action you wish to perform.`
!insertmacro XPUI_INSTALLOPTIONS_INITDIALOG "Repair.ini"
Pop $1
GetDlgItem $0 $1 1200
SendMessage $0 ${WM_SETTEXT} 0 "STR:Repair $(^Name)"
GetDlgItem $0 $1 1201
SendMessage $0 ${WM_SETTEXT} 0 "STR:Remove $(^Name)"
GetDlgItem $0 $1 1204
SendMessage $0 ${WM_SETTEXT} 0 "STR:Select whether you want to repair or remove $(^Name),$\nor if you want to continue Setup normally."
GetDlgItem $0 $1 1205
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 ${WM_SETTEXT} "" "STR:Repair"
GetDlgItem $0 $HWNDPARENT 2
SendMessage $0 ${WM_SETTEXT} "" "STR:Cancel"
!insertmacro XPUI_INSTALLOPTIONS_SHOW
FunctionEnd

######################################################
#                  REPAIR: VERIFIER                  #
######################################################

Function setrpverify
ReadINIStr $0 $PLUGINSDIR\Repair.ini Settings State
StrCmp $0 1 SetRepair
StrCmp $0 2 SetRemove
StrCmp $0 3 SetContinueSetup
Return
SetRepair:
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 ${WM_SETTEXT} "" "STR:Repair"
Abort
SetRemove:
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 ${WM_SETTEXT} "" "STR:Remove"
Abort
SetContinueSetup:
GetDlgItem $0 $HWNDPARENT 1
SendMessage $0 ${WM_SETTEXT} "" "STR:Next"
Abort
Functionend

Function CopyFiles
!insertmacro INSTALL_BASEFILES
!insertmacro INSTALL_STARTLNK
FunctionEnd

######################################################
#              REPAIR: LOAD UNINSTALLER              #
######################################################

Function Repair
StrCmp $XPUI_ABORTED 1 "" +2
Abort
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name) DisplayName
StrCmp $0 "" "" +3
Delete $PLUGINSDIR\repair.ini
Abort
ReadINIStr $0 $PLUGINSDIR\Repair.ini "Field 1" State
StrCmp $0 0 "" Repair
ReadINIStr $0 $PLUGINSDIR\Repair.ini "Field 3" State
StrCmp $0 1 ContinueNormally1
HideWindow
ReadRegStr $4 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name) InstallDir
Banner::show /NOUNLOAD "Please wait while setup loads the Uninstall wizard..."
Banner::getWindow /NOUNLOAD
Pop $1
!insertmacro XPUI_CONTROL_SKIN $1
SendMessage $1 0xC 0 STR:
GetDlgItem $0 $1 1032
!insertmacro XPUI_CONTROL_SKIN $0
GetDlgItem $0 $1 1030
!insertmacro XPUI_CONTROL_SKIN $0
Sleep 500
ExecWait $4\Uninst.exe
Banner::destroy
Quit
Repair:
!insertmacro XPUI_INSTALLOPTIONS_EXTRACT_AS "${NSISDIR}\Contrib\ExperienceUI\INI\confirm_rep.ini" "confirm_rep.ini"
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_rep.ini "Settings" NextButtonText "Next"
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_Rep.ini "Settings" BackEnabled 1
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_Rep.ini "Field 2" Text "Setup is ready to repair $(^Name)."
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_Rep.ini "Field 3" Text "Click 'Repair' to contunue."
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_Rep.ini "Field 4" Top "-17"
!insertmacro XPUI_INSTALLOPTIONS_WRITE Confirm_Rep.ini "Field 4" Bottom "-1"
!insertmacro XPUI_INSTALLOPTIONS_INITDIALOG confirm_rep.ini
GetDlgItem $0 $HWNDPARENT 1
EnableWindow $0 0
!insertmacro XPUI_HEADER_TEXT "Confirm Repair" "Please confirm that you want to repair $(^Name)."
!insertmacro XPUI_INSTALLOPTIONS_SHOW
ContinueNormally1:
FunctionEnd

Function rpverify
StrCmp $XPUI_ABORTED 1 "" +2
Return
ReadINIStr $0 $PLUGINSDIR\Repair.ini "Field 3" State
StrCmp $0 1 ContinueNormally2
Call CopyFiles
GetDlgItem $0 $HWNDPARENT 2
EnableWindow $0 0
GetDlgItem $0 $HWNDPARENT 3
EnableWindow $0 0

######################################################
#                 REPAIR: COPY FILES                 #
######################################################

!insertmacro XPUI_HEADER_TEXT `Repairing Installation` `Please wait while Setup repairs your installation of $(^Name).`
GetDlgItem $0 $1 1201
SendMessage $0 ${WM_SETTEXT} "" "STR:Setup is repairing your installation of $(^Name)"
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\n"
Sleep 500
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\nCopying Files..."
Sleep 5000
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\nWriting registry data..."
Sleep 1000
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\nWriting Uninstaller..."
Sleep 1000
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\nCopying Maintenance Program..."
Sleep 1000
GetDlgItem $0 $1 1202
SendMessage $0 ${WM_SETTEXT} "" "STR:This may take a few minutes. Please wait...$\nRemoving Backup Files..."
Sleep 500
Call CopyFiles
Sleep 1000
StrCpy $7 1
GetDlgItem $0 $HWNDPARENT 2
EnableWindow $0 1
BringToFront
Return
ContinueNormally2:
BringToFront
FunctionEnd

######################################################
#                  REPAIR: FINISH UP                 #
######################################################

Function RepairComplete
StrCmp $XPUI_ABORTED 1 "" +2
Abort
StrCmp $7 1 RepairIt!
HideWindow
BringToFront
Return
Repairit!:
ShowWindow $HWNDPARENT 5
!insertmacro XPUI_SET_BG
SetOutPath $PLUGINSDIR
File "${NSISDIR}\Contrib\ExperienceUI\INI\Confirm.ini"
!insertmacro XPUI_HEADER_TEXT `Repair Complete` `Setup has successfully repaired your installation of $(^Name).`
WriteINIStr $PLUGINSDIR\Confirm.ini "Settings" NextButtonText "Finish"
WriteINIStr $PLUGINSDIR\Confirm.ini "Settings" BackEnabled 0
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 1" Text "$(^Name) has been successfully repaired."
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 2" Text "Click $\"Finish$\" to exit."
!insertmacro XPUI_INSTALLOPTIONS_INITDIALOG Confirm.ini
GetDlgItem $0 $HWNDPARENT 1
EnableWindow $0 0
SendMessage $0 ${WM_SETTEXT} "" "STR:Next"
GetDlgItem $0 $HWNDPARENT 2
SendMessage $0 ${WM_SETTEXT} "" "STR:Finish"
StrCpy $NOABORTWARNING 1
InstallOptions::show
Delete $PLUGINSDIR\Confirm.ini
Delete $PLUGINSDIR\repair.ini
Quit
FunctionEnd

######################################################
#                   UNINSTALL:PAGES                  #
######################################################

!insertmacro XPUI_PAGEMODE_UNINST
!insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
UninstPage custom un.DelConfirm un.DelConfirm.GetReturn
!insertmacro XPUI_PAGE_INSTFILES
UninstPage custom un.unsuccess

SetPluginUnload alwaysoff
Function un.unsuccess
StrCmp $6 1 "" UninstGood
SetOutPath $PLUGINSDIR
File "${NSISDIR}\Contrib\ExperienceUI\INI\confirm.ini"
!insertmacro XPUI_HEADER_TEXT `Uninstall Incomplete` `Setup encountered a problem while uninstalling $(^Name).`
WriteINIStr $PLUGINSDIR\Confirm.ini "Settings" NextButtonText "Close"
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 2" Text "An error occured while uninstalling $(^Name)."
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 3" Text "Click $\"Close$\" to exit.\r\nError: The folder $0 is a nonexistent, system, or invalid directory, or Setup could not locate the file ${EXECUTABLE} in $0."
WriteINIStr $PLUGINSDIR\Confirm.ini Settings BackEnabled No
!insertmacro XPUI_INSTALLOPTIONS_INITDIALOG Confirm.ini
GetDlgItem $0 $HWNDPARENT 1
EnableWindow $0 0
SendMessage $0 ${WM_SETTEXT} 0 STR:Next
GetDlgItem $0 $HWNDPARENT 2
EnableWindow $0 1
SendMessage $0 ${WM_SETTEXT} 0 STR:Close
StrCpy $NOABORTWARNING 1
InstallOptions::show
Delete $PLUGINSDIR\Confirm.ini
Return
UninstGood:
SetOutPath $PLUGINSDIR
File "${NSISDIR}\Contrib\ExperienceUI\INI\confirm.ini"
!insertmacro XPUI_HEADER_TEXT `Uninstall Complete` `Setup has successfully uninstalled $(^Name) from your computer.`
WriteINIStr $PLUGINSDIR\Confirm.ini "Settings" NextButtonText "Close"
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 1" Text "$(^Name) has been successfully uninstalled."
WriteINIStr $PLUGINSDIR\Confirm.ini "Field 2" Text "Click $\"Close$\" to exit."
WriteINIStr $PLUGINSDIR\Confirm.ini Settings BackEnabled No
!insertmacro XPUI_INSTALLOPTIONS_INITDIALOG Confirm.ini
GetDlgItem $0 $HWNDPARENT 1
EnableWindow $0 0
SendMessage $0 ${WM_SETTEXT} 0 STR:Next
GetDlgItem $0 $HWNDPARENT 2
EnableWindow $0 1
SendMessage $0 ${WM_SETTEXT} 0 STR:Close
StrCpy $NOABORTWARNING 1
InstallOptions::show
Delete $PLUGINSDIR\Confirm.ini
FunctionEnd

######################################################
#               UNINSTALL: RMDIR NOTICE              #
######################################################

Function un.DelConfirm
!insertmacro XPUI_HEADER_TEXT "Uninstall Warning" "If you continue, any of your changes to $(^Name) will be lost!"
!insertmacro XPUI_LEFT_MESSAGE "WARNING:" "This uninstaller deletes all of the files in the installation directory. If you have made any changes to $(^Name), they will be lost.  Continue?" 3
FunctionEnd

Function un.DelConfirm.GetReturn
ReadINIStr "$R0" "$PLUGINSDIR\MBSide.ini" "Settings" "State"
StrCmp $R0 2 Yes
Quit
Yes:
FunctionEnd

######################################################
#                     UNINSTFILES                    #
######################################################

Function un.unin
ReadRegStr $0 HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name) InstallDir
StrCmp $0 $WINDIR UnError
StrCmp $0 $SYSDIR UnError
StrCmp $0 $TEMP UnError
StrCmp $0 $PROGRAMFILES UnError
IfFileExists $0\${EXECUTABLE} "" UnError
Delete $INSTDIR\Notepad.exe
Delete $INSTDIR\Uninst.exe
RMDir $INSTDIR
DeleteRegKey HKLM Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)
Delete $SMPROGRAMS\$(^Name).lnk
Delete $SMPROGRAMS\$(^Name)\$(^Name).lnk
Delete $SMPROGRAMS\$(^Name)\Uninstall.lnk
RMDir $INSTDIR
RMDir $SMPROGRAMS\$(^Name)
Return
UnError:
MessageBox MB_OK|MB_ICONEXCLAMATION|MB_TOPMOST "Setup was either unable to find a valid installation of $(^Name), or $(^Name) was installed in a system folder.  Uninstall incomplete."
StrCpy $6 1
FunctionEnd

######################################################
#                  UNINSTALL SECTION                 #
######################################################

Section Uninstall
!insertmacro XPUI_HEADER_TEXT "Uninstalling" "Please wait while $(^Name) is being uninstalled."
SetAutoClose true
Call un.unin
SectionEnd

; EOF