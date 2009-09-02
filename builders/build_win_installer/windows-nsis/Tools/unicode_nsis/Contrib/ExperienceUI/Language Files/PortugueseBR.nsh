;ExperienceUI for NSIS - Language File
;Compatible with "Bryce" M1 and later

;Language: Brazilian Portuguese (1046)
;By Jenner Modesto <jennermodesto@gmail.com>

;--------------------------------

!insertmacro XPUI_LANGUAGEFILE_BEGIN "PortugueseBR"

; Use only ASCII characters (if this is not possible, use the English name)
!define XPUI_LANGNAME "Portugu�s do Brasil"

; BUTTONS
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_NEXT   Avan�ar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_BACK   Voltar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CANCEL Cancelar
!insertmacro XPUI_DEFAULT XPUI_BUTTONTEXT_CLOSE  Fechar

!insertmacro XPUI_DEFAULT XPUI_ABORTWARNING_TEXT "Voc� deseja realmente finalizar a instala��o do $(^Name)?"

; +---------+
; | INSTALL |
; +---------+

; WELCOME PAGE
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT_TOP "Bem-vindo ao Assistente de Instala��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TEXT "Esse Assistente ir� orient�-lo durante o processo de instala��o de $(^Name).\r\n\r\n� recomendado que todos os outros aplicativos sejam fechados antes de iniciar o Assistente. Isso tornar� poss�vel a atualiza��o de arquivos de sistema sem a necessidade de reiniciar seu computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Instala��o de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGE_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT_TOP "Bem-vindo ao assistente de desinstala��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TEXT "Esse Assistente ir� orient�-lo durante o processo de desinstala��o de $(^Name).\r\n\r\n� recomendado que todos os outros aplicativos sejam fechados antes de iniciar o Assistente. Isso tornar� poss�vel a atualiza��o de arquivos de sistema sem a necessidade de reiniciar seu computador.\r\n\r\n"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_SUBTITLE "Bem-vindo ao Assistente de Desinstala��o de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGE_CAPTION " "

; WELCOME PAGE STYLE 2
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGESTYLE2_TEXT_TOP "Bem-vindo ao Assistente de Instala��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGESTYLE2_TEXT "Bem-vindo � Instala��o de $(^Name).  $(^Name) ser� instalado em seu computador."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGESTYLE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGESTYLE2_SUBTITLE "Bem-vindo � Instala��o de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_WELCOMEPAGESTYLE2_CAPTION " "

!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGESTYLE2_TEXT_TOP "Bem-vindo ao Assistente do NSIS de Desinstala��o de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGESTYLE2_TEXT "Bem-vindo � Desinstala��o de $(^Name).  $(^Name) ser� desinstalado do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGESTYLE2_TITLE "Bem-vindo"
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGESTYLE2_SUBTITLE "Bem-vindo � Desinstala��o de $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNWELCOMEPAGESTYLE2_CAPTION " "

; LICENSE PAGE
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_CAPTION ": Acordo de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu n�o concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_SUBTITLE "Por favor, leia os termos de licen�a abaixo antes de desinstalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TITLE "Acordo de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_TOP "Pressione Page Down ou use a barra de rolagem para ver o resto do acordo."
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, clique em Eu Concordo para continuar. Voc� tem que aceitar o acordo para instalar $(^Name)."
  !endif
!endif
!ifndef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, marque a caixa abaixo. Voc� tem que aceitar o acordo para instalar $(^Name)."
  !endif
!endif
!ifdef XPUI_LICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_LICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_LICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, selecione a primeira op��o acima. Voc� tem que aceitar o acordo para instalar $(^Name)."
  !endif
!endif

!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_CAPTION ": Acordo de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "Eu concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "Eu n�o concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_CHECKBOX "Eu concordo com os termos e condi��es acima"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_SUBTITLE "Por favor, leia os termos de licen�a abaixo antes de desinstalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TITLE "Acordo de Licen�a"
!insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_TOP "Pressione Page Down ou use a barra de rolagem para ver o resto do acordo."
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, clique em Eu Concordo para continuar. Voc� tem que aceitar o acordo para desinstalar $(^Name)."
  !endif
!endif
!ifndef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifdef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, marque a caixa abaixo. Voc� tem que aceitar o acordo para desinstalar $(^Name)."
  !endif
!endif
!ifdef XPUI_UNLICENSEPAGE_RADIOBUTTONS
  !ifndef XPUI_UNLICENSEPAGE_CHECKBOX
    !insertmacro XPUI_DEFAULT XPUI_UNLICENSEPAGE_TEXT_BOTTOM "Se voc� aceita os termos do acordo, selecione a primeira op��o acima. Voc� tem que aceitar o acordo para desinstalar $(^Name)."
  !endif
!endif

; COMPONENTS PAGE
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_CAPTION ": Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_SUBTITLE "Escolha quais componentes de $(^Name) devem ser instalados."
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descri��o"
!insertmacro XPUI_DEFAULT XPUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o mouse sobre um componente para ver sua descri��o"

!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_CAPTION ": Selecione os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_SUBTITLE "Escolha quais componentes de $(^Name) devem ser desinstalados."
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TITLE "Escolha os Componentes"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descri��o"
!insertmacro XPUI_DEFAULT XPUI_UNCOMPONENTSPAGE_TEXT_DESCRIPTION_INFO  "Passe o mouse sobre um componente para ver sua descri��o"

; DIRECTORY PAGE
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_CAPTION ": Selecione o Diret�rio de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_TOP "O Assistente ir� instalar $(^Name) no diret�rio abaixo.$\n$\nPara instalar nesse diret�rio, clique em Avan�ar.  Para instalar em outro diret�rio, digite manualmente ou clique em Procurar.  $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_DESTINATION "Diret�rio de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor, selecione um diret�rio:"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_TITLE "Escolha o Local de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_DIRECTORYPAGE_SUBTITLE "Escolha o diret�rio no qual ser� instalado $(^Name)."

!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_CAPTION ": Selecione o Diret�rio de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_TOP "O Assistente ir� desinstalar $(^Name) do diret�rio abaixo.$\n$\nPara desinstalar desse diret�rio, clique em Avan�ar.  Para desinstalar de outro diret�rio, digite manualmente ou clique em Procurar. $_CLICK"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_DESTINATION "Diret�rio de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSE "Procurar"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TEXT_BROWSEDIALOG "Por favor, selecione um diret�rio:"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_TITLE "Escolha o Local de Instala��o"
!insertmacro XPUI_DEFAULT XPUI_UNDIRECTORYPAGE_SUBTITLE "Escolha o diret�rio do qual ser� desinstalado $(^Name)."

; START MENU PAGE
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CAPTION    ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TITLE      "Selecione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_SUBTITLE   "Selecione a pasta na qual ser�o criados atalhos no Menu Iniciar para $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_TEXT       "Selecione a pasta do Menu Iniciar na qual ser�o criados os atalhos para $(^Name):"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_CHECKBOX   "N�o criar pasta no Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_STARTMENUPAGE_FOLDER     "$(^Name)"

!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CAPTION  ": Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TITLE    "Selecione a Pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_SUBTITLE "Selecione a pasta da qual ser�o removidos os atalhos do Menu Iniciar:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_TEXT     "Selecione a pasta do Menu Iniciar da qual ser�o removidos os atalhos:"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_CHECKBOX "N�o remover a pasta do Menu Iniciar"
!insertmacro XPUI_DEFAULT XPUI_UNSTARTMENUPAGE_FOLDER   "$(^Name)"

; INSTALL CONFIRM PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_CAPTION ": Confirmar a Instala��o"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_SUBTITLE "O Assistente terminou de reunir informa��es e est� pronto para instalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TITLE "Confirmar a Instala��o"
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_TOP "O Assistente est� pronto para instalar $(^Name) em seu computador."
!insertmacro XPUI_DEFAULT XPUI_INSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_CAPTION ": Confirmar a Desinstala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_SUBTITLE "O Assistente terminou de reunir informa��es e est� pronto para desinstalar $(^Name)."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TITLE "Confirmar a desinstala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_TOP "O Assistente est� pronto para desinstalar $(^Name) do seu computador."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_TEXT_BOTTOM "$_CLICK"

; INSTFILES PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_CAPTION ": Copiando Arquivos"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_SUBTITLE "Por favor, aguarde enquanto $(^Name) est� sendo instalado."
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_TITLE "Instalando"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_TITLE "Instala��o Completada"
!insertmacro XPUI_DEFAULT XPUI_INSTFILESPAGE_DONE_SUBTITLE "A instala��o foi conclu�da com sucesso."

!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_CAPTION ": Desinstalando Arquivos"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_SUBTITLE "Por favor, aguarde enquanto $(^Name) est� sendo desinstalado."
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_TITLE "Desinstalando"
!insertmacro XPUI_DEFAULT XPUI_UNINSTFILESPAGE_DONE_TITLE "Deinstala��o Completada"
!insertmacro XPUI_DEFAULT XPUI_UBINSTFILESPAGE_DONE_SUBTITLE "A deinstala��o foi conclu�da com sucesso."

; INSTALL SUCCESS PAGE
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_CAPTION ": Instala��o Bem Sucedida"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_SUBTITLE "O Assistente instalou $(^Name) em seu computador com �xito."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TITLE "Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_TOP    "$(^Name) foi instalado com �xito."
!insertmacro XPUI_DEFAULT XPUI_INSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_CAPTION ": Desinstala��o Bem Sucedida"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_SUBTITLE "O Assistente desinstalou $(^Name) do seu computador com �xito."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TITLE "Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_TOP    "$(^Name) foi desinstalado com �xito."
!insertmacro XPUI_DEFAULT XPUI_UNINSTSUCCESSPAGE_TEXT_BOTTOM "Clique em Fechar para sair."

; FINISH PAGE
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TITLE "Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_SUBTITLE "O Assistente instalou $(^Name) em seu computador com �xito."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CAPTION ": Instala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP "Completando o Assistente de Instala��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_TOP_ALT "Assistente do NSIS de Instala��o Terminado"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_RUN "O Assistente instalou $(^Name) em seu computador com �xito.\r\n\r\nO que voc� deseja executar?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT_REBOOT "O Assistente terminou de copiar os arquivos para o seu computador.\r\n\r\n� preciso reiniciar seu computador para terminar a instala��o.  Voc� quer reiniciar seu computador agora?"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_TEXT "O Assistente instalou $(^Name) em seu computador com �xito.\r\n\r\nPor favor, clique em Fechar para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_RUN "Executar $(^Name) agora"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_CHECKBOX_DOCS "Ver a documenta��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_REBOOT "Sim, reinicie meu computador agora."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_RADIOBUTTON_NOREBOOT "N�o, eu reiniciarei meu computador mais tarde."
!insertmacro XPUI_DEFAULT XPUI_FINISHPAGE_REBOOT_MESSAGEBOX "O Assistente est� prestes a reiniciar seu computador.$\n$\nPor favor, salve e feche todos os arquivos e documentos abertos e clique em OK para reiniciar seu computador."

!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TITLE "Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_SUBTITLE "O Assistente desinstalou $(^Name) do seu computador com �xito."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_CAPTION ": Desinstala��o Completa"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP "Terminando o Assistente de Instala��o de $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_TOP_ALT "Assistente do NSIS de Instala��o Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT_REBOOT "O Assistente terminou de copiar os arquivos para o seu computador.\r\n\r\n� preciso reiniciar seu computador para terminar a desinstala��o.  Voc� quer reiniciar seu computador agora?"
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_TEXT "O Assistente desinstalou $(^Name) do seu computador com �xito.\r\n\r\nPor favor, clique em Fechar para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_REBOOT "Sim, reinicie me computador agora."
!insertmacro XPUI_DEFAULT XPUI_UNFINISHPAGE_RADIOBUTTON_NOREBOOT "N�o, eu reiniciarei meu computador mais tarde."

; ABORT PAGE
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT_TOP "Assistente do NSIS de Instala��o Terminado"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TEXT "O assistente foi interrompido antes que $(^Name) pudesse ser completamente instalado.\r\n\r\nSeu sistema n�o foi modificado.  Para instalar esse programa mais tarde, execute o assistente novamente.\r\n\r\n\r\n\r\n\r\nPor favor, clique em $(XPUI_BUTTONTEXT_CLOSE) para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_TITLE "Instala��o Incompleta"
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_SUBTITLE "Instala��o de $(^Name) n�o teve �xito."
!insertmacro XPUI_DEFAULT XPUI_ABORTPAGE_CAPTION ": Instala��o Cancelada"

!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT_TOP "Assistente do NSIS de Desinstala��o Terminado"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TEXT "O assistente foi interrompido antes que $(^Name) pudesse ser completamente desinstalado.$\n$\nSeu sistema n�o foi modificado.  Para desinstalar esse programa mais tarde, execute o assistente novamente.\r\n\r\n\r\n\r\n\r\nPor favor, clique em $(XPUI_BUTTONTEXT_CLOSE) para sair do Assistente."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_TITLE "Desinstala��o Incompleta"
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_SUBTITLE "Desinstala��o de $(^Name) n�o teve �xito."
!insertmacro XPUI_DEFAULT XPUI_UNABORTPAGE_CAPTION ": Desinstala��o Cancelada"

; +-----------+
; | UNINSTALL |
; +-----------+

; MOST OF THE UNINSTALL PAGES ARE TAKEN CARE OF USING THE PAGE MODE SYSTEM
; THE XPUI CONFIRM, UNINSTFILES, AND SUCCESS PAGES USE THE PAGE MODE SYSTEM,
; BUT THE NSIS-STYLE UNINSTALL CONFIRM PAGE SIMPLY USES A NON-PAGE-MODE METHOD.

; UNINST CONFIRM PAGE (NSIS)
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_CAPTION ": Confirmar Desinstala��o"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_SUBTITLE "Remover $(^Name) do seu computador"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TITLE "Desinstalar $(^Name)"
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_TOP "$(^Name) ser� desinstalado.  Clique em Desinstalar para iniciar a desinstala��o."
!insertmacro XPUI_DEFAULT XPUI_UNINSTCONFIRMPAGE_NSIS_TEXT_FOLDER "Desinstalando de:"

!insertmacro XPUI_LANGUAGEFILE_END
