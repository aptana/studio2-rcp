
SetCompressor /FINAL /SOLID lzma

# Defines
!define REGKEY "SOFTWARE\$(^Name)"
!define VERSION 2.0.0
!define COMPANY "Aptana, Inc."
!define URL http://www.aptana.com

!define XPUI_SKIN "Aptana"

!define XPUI_DISABLEBG
;!define XPUI_LICENSEPAGE_CHECKBOX
!define XPUI_BRANDINGTEXT "Aptana Studio"
!define XPUI_BRANDINGTEXT_COLOR_FG FFFFFF
!define XPUI_TEXT_COLOR FFFFFF
!define XPUI_ABORTWARNING
!define XPUI_UNABORTWARNING
!define XPUI_ICON "Icons\aptana_install.ico"
!define XPUI_UNICON "Icons\aptana_uninstall.ico"

# Included files
!addincludedir Tools\nsis\Include
!addincludedir Tools\nsis\Contrib
!include Sections.nsh
!include XPUI.nsh
!include InstallOptions.nsh
!include LogicLib.nsh
!include gettime.nsh
!include local_settings.nsh

# Reserved Files
ReserveFile "${NSISDIR}\Plugins\AdvSplash.dll"
ReserveFile "${NSISDIR}\Plugins\SimpleFC.dll" 
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll" 
ReserveFile "associations.ini" 
#ReserveFile "FirewallDialog.ini" 

# Variables
Var StartMenuGroup
Var SMFOLDER
var OnWindows2000
var OnWindowsXP
var OnVista
var MajorVersion
var MinorVersion
var BuildNumber
var PlatformID
var CSDVersion
var IconLocation

# Installer languages
!insertmacro XPUI_LANGUAGE "English"
!insertmacro XPUI_PAGE_STARTMENU_INIT App $SMFOLDER

LangString WPTEXT1 ${LANG_ENGLISH} "Welcome to Aptana Studio installer."
LangString WPTEXT2 ${LANG_ENGLISH} "\r\n\r\nClick Next to start.\r\n\r\n"
!define XPUI_WELCOMEPAGESTYLE2_TEXT_TOP "$(WPTEXT1)"
!define XPUI_WELCOMEPAGESTYLE2_TEXT     "$(WPTEXT2)"
!insertmacro XPUI_PAGE_WELCOME2
!insertmacro XPUI_PAGE_LICENSE "License.rtf"
!insertmacro XPUI_PAGE_DIRECTORY
!insertmacro XPUI_PAGE_STARTMENU_SHOW App
Page custom SetAssociations
!insertmacro XPUI_PAGE_INSTCONFIRM
!insertmacro XPUI_PAGE_INSTFILES
!insertmacro XPUI_PAGE_FINISH
!insertmacro XPUI_PAGE_ABORT
!insertmacro XPUI_PAGEMODE_UNINST
!insertmacro XPUI_PAGE_WELCOME2
!insertmacro XPUI_PAGE_UNINSTCONFIRM_NSIS
!insertmacro XPUI_PAGE_INSTCONFIRM
!insertmacro XPUI_PAGE_INSTFILES
!insertmacro XPUI_PAGE_FINISH
!insertmacro XPUI_PAGE_ABORT

# Installer attributes
OutFile Aptana_Studio_Setup.exe
CRCCheck on
XPStyle off
ShowInstDetails hide
VIProductVersion 1.0.0.0
VIAddVersionKey ProductName "Aptana Studio"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey CompanyWebsite "${URL}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey FileDescription ""
VIAddVersionKey LegalCopyright ""
InstallDirRegKey HKLM "${REGKEY}" Path
ShowUninstDetails hide

################################################################################
# Installer sections
Section -Main SEC0000

    SetOutPath "$INSTDIR"
    SetOverwrite on

    File "${INSTALL_FILES_ROOT}\.eclipseproduct"
    File "${INSTALL_FILES_ROOT}\AptanaStudio.exe"
    File "${INSTALL_FILES_ROOT}\AptanaStudio.ini"
    File "${INSTALL_FILES_ROOT}\artifacts.xml"
    File "${INSTALL_FILES_ROOT}\full_uninstall.txt"
    File "${INSTALL_FILES_ROOT}\version.txt"

    SetOutPath "$INSTDIR\features"
    File /r "${INSTALL_FILES_ROOT}\features\*"
    
    SetOutPath "$INSTDIR\p2"
    File /r "${INSTALL_FILES_ROOT}\p2\*"

    SetOutPath "$INSTDIR\plugins"
    File /r "${INSTALL_FILES_ROOT}\plugins\*"
    
    SetOutPath "$INSTDIR\configuration"
    File /r "${INSTALL_FILES_ROOT}\configuration\*"
    
    SetOutPath "$INSTDIR\dropins"
    
    WriteRegStr HKLM "${REGKEY}\Components" Main 1

    SetOutPath "$INSTDIR\jre"
    File /r "${JRE_ROOT}\*"
    
    SetOutPath "$INSTDIR\Icons\legacy"
    File "Icons\legacy\*.ico"
   
    SetOutPath "$INSTDIR\Icons\standard"
    File "Icons\standard\*.ico"

SectionEnd

Section -post SEC0001
    WriteRegStr HKLM "${REGKEY}" Path $INSTDIR
    SetOutPath $INSTDIR
    WriteUninstaller $INSTDIR\uninstall.exe

    # Write Desktop shortcut
    CreateShortCut "$DESKTOP\$(^Name).lnk" "$INSTDIR\AptanaStudio.exe" ""

    # Create QuickLaunch shortcut
    CreateShortCut "$QUICKLAUNCH\$(^Name).lnk" "$INSTDIR\AptanaStudio.exe" ""
    
    # Grab the first character of the SMFOLDER, if it is '>', then they don't want SM items
    StrCpy $R0 $SMFOLDER 1
    
    # Check to see if we need to install Start Menu items
    ${if} $R0 != ">"
        # Write Start Menu shortcuts    
        SetShellVarContext all
        SetOutPath $SMPROGRAMS\$StartMenuGroup
        CreateShortCut "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk" "$INSTDIR\AptanaStudio.exe" ""
        WriteINIStr "$SMPROGRAMS\$StartMenuGroup\Aptana Forums.url" "InternetShortcut" "URL" "http://www.aptana.com/forums/"
        WriteINIStr "$SMPROGRAMS\$StartMenuGroup\Aptana Website.url" "InternetShortcut" "URL" "http://www.aptana.com/"
        SetShellVarContext current
    ${endif}    
        
    # JS
    WriteRegStr HKCR "AptanaStudio.js"                              ""                      "JSFile"
    WriteRegStr HKCR ".js\OpenWithProgids"                          "AptanaStudio.js"       ""
    WriteRegStr HKCR ".js\OpenWithList\aptanastudio.exe"            "aptanastudio.exe"            ""
    
    # SDOC
    WriteRegStr HKCR "AptanaStudio.sdoc"                            ""                      "SDOCFile"
    WriteRegStr HKCR ".sdoc\OpenWithProgids"                        "AptanaStudio.sdoc"     ""
    WriteRegStr HKCR ".sdoc\OpenWithList\aptanastudio.exe"          "aptanastudio.exe"      ""
    
    # HTML
    WriteRegStr HKCR "AptanaStudio.html"                            ""                      "htmlfile"
    WriteRegStr HKCR ".htm\OpenWithProgids"                         "AptanaStudio.html"     ""
    WriteRegStr HKCR ".htm\OpenWithList\aptanastudio.exe"           "aptanastudio.exe"      ""
    WriteRegStr HKCR ".html\OpenWithProgids"                        "AptanaStudio.html"     ""
    WriteRegStr HKCR ".html\OpenWithList\aptanastudio.exe"          "aptanastudio.exe"      ""

    # CSS
    
    ; CSS is derived from HTML, so we do not need to add an explicit CSS entry here
    
    # XML
    WriteRegStr HKCR "AptanaStudio.xml"                             ""                      "xmlfile"
    WriteRegStr HKCR ".xml\OpenWithProgids"                         "AptanaStudio.xml"      ""
    WriteRegStr HKCR ".xml\OpenWithList\aptanastudio.exe"           "aptanastudio.exe"            ""

    # Now see which icon set we use, legacy or standard
    StrCmp $OnWindows2000 "1" ItIsWindows2000 ItIsNotWindows2000
    
    ItIsWindows2000:
        StrCpy $IconLocation "legacy"
        Goto DoneSetIconLocation
            
    ItIsNotWindows2000:
        StrCpy $IconLocation "standard"
        
    DoneSetIconLocation:
    
    #  
    # Now set icons for each of the file types
    #
    
    # CSS
    !insertmacro INSTALLOPTIONS_READ $R0 "associations.ini" "Field 1" "State" 
    ${if} $R0 == "1"
        WriteRegStr HKCR "CSSFile\DefaultIcon"          ""              "$INSTDIR\Icons\$IconLocation\aptana_file_css.ico"
        WriteRegStr HKCR "CSSFile\shell\open\command"   ""              '"$INSTDIR\AptanaStudio.exe" "%1"'
    ${endif}
    
    # JS
    !insertmacro INSTALLOPTIONS_READ $R0 "associations.ini" "Field 2" "State" 
    ${if} $R0 == "1"
        WriteRegStr HKCR "JSFile\DefaultIcon"           ""              "$INSTDIR\Icons\$IconLocation\aptana_file_js.ico"
        WriteRegStr HKCR "JSFile\shell\open\command"    ""              '"$INSTDIR\AptanaStudio.exe" "%1"'
    ${endif}
  
    # SDOC
    !insertmacro INSTALLOPTIONS_READ $R0 "associations.ini" "Field 3" "State" 
    ${if} $R0 == "1"
        WriteRegStr HKCR ".sdoc"                        ""              "SDOCFile"
        WriteRegStr HKCR ".sdoc"                        "ContentType"   "text/plain"
        WriteRegStr HKCR ".sdoc"                        "PerceivedType" "text"
        WriteRegStr HKCR "SDOCFile\DefaultIcon"         ""              "$INSTDIR\Icons\$IconLocation\aptana_file_sdoc.ico"
        WriteRegStr HKCR "SDOCFile\shell\open\command"  ""              '"$INSTDIR\AptanaStudio.exe" "%1"'
    ${endif}        
      
    # XML
    !insertmacro INSTALLOPTIONS_READ $R0 "associations.ini" "Field 4" "State" 
    ${if} $R0 == "1"
        WriteRegStr HKCR "xmlfile\DefaultIcon"          ""              "$INSTDIR\Icons\$IconLocation\aptana_file_xml.ico"
        WriteRegStr HKCR "xmlfile\shell\open\command"   ""              '"$INSTDIR\AptanaStudio.exe" "%1"'
    ${endif}

    
    #
    # Write uninstall reg info
    #
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayVersion "${VERSION}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" Publisher "${COMPANY}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" URLInfoAbout "${URL}"
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon $INSTDIR\uninstall.exe
    WriteRegStr HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString $INSTDIR\uninstall.exe
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
SectionEnd

################################################################################
# Installer functions
Function .onInit
    InitPluginsDir

    !insertmacro INSTALLOPTIONS_EXTRACT "associations.ini"
    
    StrCpy $StartMenuGroup Aptana
    Push $R1
    File /oname=$PLUGINSDIR\spltmp.bmp "Bitmaps\splash.bmp"
    advsplash::show 1500 500 400 -1 $PLUGINSDIR\spltmp
    Pop $R1
    Pop $R1

    ; Check to see if already installed
    ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "UninstallString"
    IfFileExists $R0 +1 NotInstalled
    
    MessageBox MB_YESNO "Aptana Studio is apparently already installed. Would you like to Uninstall it now?" IDYES true IDNO false
    true:
        Exec $R0
    false:
        Goto Quit
                
    Quit:
        Quit
      
    NotInstalled:

    ; set the default install location
    StrCpy $INSTDIR "$PROGRAMFILES\Aptana\$(^Name)"

    ; get the version of windows  
    Version::IsWindows2000
    Pop $OnWindows2000
          
    Version::IsWindowsXP
    Pop $OnWindowsXP
    
    StrCmp $OnWindowsXP "1" ItIsWindowsXP ItIsNotWindowsXP
 
    ItIsWindowsXP:
        StrCpy $OnVista "0" 
        Goto Go2
     
    ItIsNotWindowsXP:
        ; it is not XP, but is it Vista?
        Version::GetWindowsVersion
        Pop $MajorVersion
        Pop $MinorVersion
        Pop $BuildNumber
        Pop $PlatformID
        Pop $CSDVersion
        
        StrCmp $MajorVersion "6" ItIsVista Go2
        
        ItIsVista:
            StrCpy $OnVista "1"
            StrCpy $INSTDIR "$LOCALAPPDATA\$(^Name)"
    
    Go2:
    ;noop

FunctionEnd

################################################################################
# Uninstaller sections
Section /o -un.Main UNSEC0000
    RmDir /r /REBOOTOK "$INSTDIR"

    ; Get the local time
    ${GetTime} "" "L" $0 $1 $2 $3 $4 $5 $6
    StrCpy $R1 '$0$1$2.$4$5$6'
    Rename /REBOOTOK "$APPDATA\Aptana\Aptana Studio" "$APPDATA\Aptana\Aptana Studio.$R1"
    
    DeleteRegValue HKLM "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"

    Delete /REBOOTOK $INSTDIR\uninstall.exe
    
    Delete /REBOOTOK "$DESKTOP\$(^Name).lnk"
    Delete /REBOOTOK "$QUICKLAUNCH\$(^Name).lnk"
    
    # Delete Start Menu Items
    SetShellVarContext all
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\$(^Name).lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Aptana Forums.url"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Aptana Website.url"  
    RmDir /REBOOTOK $SMPROGRAMS\$StartMenuGroup
    SetShellVarContext current
        
    DeleteRegValue HKLM "${REGKEY}" Path
    DeleteRegKey /IfEmpty HKLM "${REGKEY}\Components"
    DeleteRegKey /IfEmpty HKLM "${REGKEY}"

    DeleteRegKey HKCR "AptanaStudio.js"
    DeleteRegValue HKCR ".js\OpenWithProgids" "AptanaStudio.js"
    DeleteRegKey HKCR ".js\OpenWithList\aptanastudio.exe"

    DeleteRegKey HKCR "AptanaStudio.sdoc"
    DeleteRegValue HKCR ".sdoc\OpenWithProgids" "AptanaStudio.js"
    DeleteRegKey HKCR ".sdoc\OpenWithList\aptanastudio.exe"

    DeleteRegKey HKCR "AptanaStudio.html"
    DeleteRegValue HKCR ".html\OpenWithProgids" "AptanaStudio.js"
    DeleteRegKey HKCR ".html\OpenWithList\aptanastudio.exe"
    DeleteRegValue HKCR ".htm\OpenWithProgids" "AptanaStudio.js"
    DeleteRegKey HKCR ".htm\OpenWithList\aptanastudio.exe"

    DeleteRegKey HKCR "AptanaStudio.xml"
    DeleteRegValue HKCR ".xml\OpenWithProgids" "AptanaStudio.js"
    DeleteRegKey HKCR ".xml\OpenWithList\aptanastudio.exe"
    
    #
    # Only remove the following if they were originally set by us
    #
    
    # JS
    ReadRegStr $R0 HKCR "JSFile\shell\open\command" ""
    ${if} $R0 == '"$INSTDIR\AptanaStudio.exe" "%1"'
        DeleteRegKey HKCR "JSFile\DefaultIcon"
        DeleteRegKey HKCR "JSFile\shell\open\command"
    ${endif}
    
    # SDOC
    ReadRegStr $R0 HKCR "SDOCFile\shell\open\command" ""
    ${if} $R0 == '"$INSTDIR\AptanaStudio.exe" "%1"'
        DeleteRegKey HKCR "SDOCFile\DefaultIcon"
        DeleteRegKey HKCR "SDOCFile\shell\open\command"
    ${endif}

    # CSS
    ReadRegStr $R0 HKCR "CSSFile\shell\open\command" ""
    ${if} $R0 == '"$INSTDIR\AptanaStudio.exe" "%1"'
        DeleteRegKey HKCR "CSSFile\DefaultIcon"
        DeleteRegKey HKCR "CSSFile\shell\open\command"
    ${endif}

    # XML
    ReadRegStr $R0 HKCR "CSSFile\shell\open\command" ""
    ${if} $R0 == '"$INSTDIR\AptanaStudio.exe" "%1"'
        DeleteRegKey HKCR "xmlfile\DefaultIcon"
        DeleteRegKey HKCR "xmlfile\shell\open\command"
    ${endif}
    
    # Delete the main install dir
    RmDir /REBOOTOK $INSTDIR

SectionEnd

################################################################################
# Uninstaller functions

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 HKLM "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

Function un.onInit
    ReadRegStr $INSTDIR HKLM "${REGKEY}" Path
    StrCpy $StartMenuGroup Aptana
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd

Function SetAssociations 

    !insertmacro INSTALLOPTIONS_INITDIALOG "associations.ini"

    Pop $R0 ;HWND of dialog
    SetCtlColors "$R0" 0xFFFFFF 0x242b33
    
    ${For} $R1 1 5
        !insertmacro INSTALLOPTIONS_READ $R0 "associations.ini" "Field $R1" "HWND"
        SetCtlColors "$R0" 0xFFFFFF 0x242b33
    ${Next}
            
    !insertmacro INSTALLOPTIONS_SHOW
  
FunctionEnd 

#END
