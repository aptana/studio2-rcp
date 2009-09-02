;Language: Brazilian Portuguese (1046)
;By Diego Marcos <jump@osite.com.br>

!insertmacro LANGFILE "PortugueseBR" "Portugu�s (do Brasil)"

!ifdef MUI_WELCOMEPAGE
  ${LangFileString} MUI_TEXT_WELCOME_INFO_TITLE "Bem-vindo ao Assistente de Instala��o do $(^NameDA)"
  ${LangFileString} MUI_TEXT_WELCOME_INFO_TEXT "Este assistente o guiar� durante a instala��o do $(^NameDA).$\r$\n$\r$\n� recomendado que voc� feche todas as outras aplica��es antes de iniciar a Instala��o. Isto possibilitar� fazer update dos arquivos do sistema sem reiniciar o computador.$\r$\n$\r$\n$_CLICK"
!endif

!ifdef MUI_UNWELCOMEPAGE
  ${LangFileString} MUI_UNTEXT_WELCOME_INFO_TITLE "Bem-vindo ao Assistente de Desinstala��o do $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_WELCOME_INFO_TEXT "Este assistente o guiar� durante a desinstala��o do $(^NameDA).$\r$\n$\r$\nAntes de iniciar a desinstala��o, tenha certeza que o $(^NameDA) n�o est� sendo executado.$\r$\n$\r$\n$_CLICK"
!endif

!ifdef MUI_LICENSEPAGE
  ${LangFileString} MUI_TEXT_LICENSE_TITLE "Contrato de Licen�a"
  ${LangFileString} MUI_TEXT_LICENSE_SUBTITLE "Por favor, verifique os termos da licen�a antes de instalar o $(^NameDA)."
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM "Se voc� aceitar os termos da licen�a, clique em Concordo para continuar. Voc� deve aceitar o contrato para instalar o $(^NameDA)."
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_CHECKBOX "Se voc� aceitar os termos da licen�a, clique na caixa de sele��o abaixo. Voc� deve aceitar o contrato para instalar o $(^NameDA). $_CLICK"
  ${LangFileString} MUI_INNERTEXT_LICENSE_BOTTOM_RADIOBUTTONS "Se voc� aceitar os termos da licen�a, selecione a primeira op��o abaixo. Voc� deve aceitar o contrato para instalar o $(^NameDA). $_CLICK"
!endif

!ifdef MUI_UNLICENSEPAGE
  ${LangFileString} MUI_UNTEXT_LICENSE_TITLE "Contrato de Licen�a"
  ${LangFileString} MUI_UNTEXT_LICENSE_SUBTITLE "Por favor, verifique os termos da licen�a antes de desinstalar o $(^NameDA)."
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM "Se voc� aceitar os termos da licen�a, clique em Concordo para continuar. Voc� deve aceitar o contrato para desinstalar o $(^NameDA)."
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM_CHECKBOX "Se voc� aceitar os termos da licen�a, clique na caixa de sele��o abaixo. Voc� deve aceitar o contrato para desinstalar o $(^NameDA). $_CLICK"
  ${LangFileString} MUI_UNINNERTEXT_LICENSE_BOTTOM_RADIOBUTTONS "Se voc� aceitar os termos da licen�a, selecione a primeira op��o abaixo. Voc� deve aceitar o contrato para desinstalar o $(^NameDA). $_CLICK"
!endif

!ifdef MUI_LICENSEPAGE | MUI_UNLICENSEPAGE
  ${LangFileString} MUI_INNERTEXT_LICENSE_TOP "Tecle Page Down para ver o restante da licen�a."
!endif

!ifdef MUI_COMPONENTSPAGE
  ${LangFileString} MUI_TEXT_COMPONENTS_TITLE "Escolha de Componentes"
  ${LangFileString} MUI_TEXT_COMPONENTS_SUBTITLE "Escolha quais caracter�sticas do $(^NameDA) que voc� deseja instalar."
  ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_TITLE "Descri��o"
!endif

!ifdef MUI_UNCOMPONENTSPAGE
  ${LangFileString} MUI_UNTEXT_COMPONENTS_TITLE "Escolher Componentes"
  ${LangFileString} MUI_UNTEXT_COMPONENTS_SUBTITLE "Escolha quais qualidades do $(^NameDA) quer desinstalar."
!endif

!ifdef MUI_COMPONENTSPAGE | MUI_UNCOMPONENTSPAGE
  !ifndef NSIS_CONFIG_COMPONENTPAGE_ALTERNATIVE
    ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_INFO "Passe o ponteiro do mouse sobre um componente para ver sua descri��o."
  !else
    ${LangFileString} MUI_INNERTEXT_COMPONENTS_DESCRIPTION_INFO "Passe o ponteiro do mouse sobre um componente para ver sua descri��o."
  !endif
!endif

!ifdef MUI_DIRECTORYPAGE
  ${LangFileString} MUI_TEXT_DIRECTORY_TITLE "Escolha do Local da Instala��o"
  ${LangFileString} MUI_TEXT_DIRECTORY_SUBTITLE "Escolha a pasta na qual deseja instalar o $(^NameDA)."
!endif

!ifdef MUI_UNDIRECTORYSPAGE
  ${LangFileString} MUI_UNTEXT_DIRECTORY_TITLE "Escolha do Local da Desinstala��o"
  ${LangFileString} MUI_UNTEXT_DIRECTORY_SUBTITLE "Escolha a pasta na qual deseja desinstalar o $(^NameDA)."
!endif

!ifdef MUI_INSTFILESPAGE
  ${LangFileString} MUI_TEXT_INSTALLING_TITLE "Instalando"
  ${LangFileString} MUI_TEXT_INSTALLING_SUBTITLE "Por favor, aguarde enquanto o $(^NameDA) est� sendo instalado."
  ${LangFileString} MUI_TEXT_FINISH_TITLE "Instala��o Completada"
  ${LangFileString} MUI_TEXT_FINISH_SUBTITLE "A instala��o foi conclu�da com sucesso."
  ${LangFileString} MUI_TEXT_ABORT_TITLE "Instala��o Abortada"
  ${LangFileString} MUI_TEXT_ABORT_SUBTITLE "A instala��o n�o foi conclu�da com sucesso."
!endif

!ifdef MUI_UNINSTFILESPAGE
  ${LangFileString} MUI_UNTEXT_UNINSTALLING_TITLE "Desinstalando"
  ${LangFileString} MUI_UNTEXT_UNINSTALLING_SUBTITLE "Por favor, aguarde enquanto o $(^NameDA) est� sendo desinstalado."
  ${LangFileString} MUI_UNTEXT_FINISH_TITLE "Desinstala��o Completada"
  ${LangFileString} MUI_UNTEXT_FINISH_SUBTITLE "A desinstala��o foi conclu�da com sucesso."
  ${LangFileString} MUI_UNTEXT_ABORT_TITLE "Desinstala��o Abortada"
  ${LangFileString} MUI_UNTEXT_ABORT_SUBTITLE "A desinstala��o n�o foi conclu�da com sucesso"
!endif

!ifdef MUI_FINISHPAGE
  ${LangFileString} MUI_TEXT_FINISH_INFO_TITLE "Concluindo o Assistente de Instala��o do $(^NameDA)"
  ${LangFileString} MUI_TEXT_FINISH_INFO_TEXT "$(^NameDA) foi instalado no seu computador.$\r$\n$\r$\nClique em Terminar para fechar este assistente."
  ${LangFileString} MUI_TEXT_FINISH_INFO_REBOOT "Seu computador deve ser reiniciado para conclu�r a instala��o do $(^NameDA). Voc� quer reiniciar agora?"
!endif

!ifdef MUI_UNFINISHPAGE
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_TITLE "Concluindo o Assistente de Desinstala��o do $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_TEXT "$(^NameDA) foi desinstalado do seu computador.$\r$\n$\r$\nClique em Terminar para fechar este assistente."
  ${LangFileString} MUI_UNTEXT_FINISH_INFO_REBOOT "Seu computador tem que ser reiniciado para completar a desinstala��o do $(^NameDA). Quer reiniciar agora?"
!endif

!ifdef MUI_FINISHPAGE | MUI_UNFINISHPAGE
  ${LangFileString} MUI_TEXT_FINISH_REBOOTNOW "Reiniciar Agora"
  ${LangFileString} MUI_TEXT_FINISH_REBOOTLATER "Eu quero reiniciar manualmente depois"
  ${LangFileString} MUI_TEXT_FINISH_RUN "&Executar $(^NameDA)"
  ${LangFileString} MUI_TEXT_FINISH_SHOWREADME "&Mostrar Leiame"
  ${LangFileString} MUI_BUTTONTEXT_FINISH "&Terminar"  
!endif

!ifdef MUI_STARTMENUPAGE
  ${LangFileString} MUI_TEXT_STARTMENU_TITLE "Escolha uma Pasta do Menu Iniciar"
  ${LangFileString} MUI_TEXT_STARTMENU_SUBTITLE "Escolha uma pasta do Menu Iniciar para os atalhos do programa."
  ${LangFileString} MUI_INNERTEXT_STARTMENU_TOP "Selecione uma pasta do Menu Iniciar em que deseja criar os atalhos do programa. Voc� pode tamb�m digitar um nome para criar uma nova pasta. "
  ${LangFileString} MUI_INNERTEXT_STARTMENU_CHECKBOX "N�o criar atalhos"
!endif

!ifdef MUI_UNCONFIRMPAGE
  ${LangFileString} MUI_UNTEXT_CONFIRM_TITLE "Desinstalar o $(^NameDA)"
  ${LangFileString} MUI_UNTEXT_CONFIRM_SUBTITLE "Remover o $(^NameDA) do seu computador."
!endif

!ifdef MUI_ABORTWARNING
  ${LangFileString} MUI_TEXT_ABORTWARNING "Voc� deseja realmente finalizar a instala��o do $(^Name)?"
!endif

!ifdef MUI_UNABORTWARNING
  ${LangFileString} MUI_UNTEXT_ABORTWARNING "Voc� deseja realmente finalizar a desinstala��o do $(^Name)?"
!endif
