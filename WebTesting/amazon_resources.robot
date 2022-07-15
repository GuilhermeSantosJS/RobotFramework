*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                     chrome
${URL}                         https://www.amazon.com.br
${MENU_ELETRONICOS}            //a[contains(@href,'electronics')]
${HEADER_ELETRONICOS}          //h1[contains(.,'Eletrônicos e Tecnologia')]
${ADD_PRODUTO_CARRINHO}        //span[contains(.,'Adicionado ao carrinho')]
${REMOVE_PRODUTO_CARRINHO}     //h1[contains(.,'Seu carrinho de compras da Amazon está vazio.')]
${ESVAZIAR_CARRINHO}           //input[@value='Excluir']

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window    

Fechar o navegador
    Capture Page Screenshot    
    Close Browser
    
Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains         text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}
    
Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible        locator=//a[@aria-label='${NOME_CATEGORIA}']

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-text

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]

Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    locator=(//span[contains(.,'${PRODUTO}')])[2]
    Click Element    locator=add-to-cart-button

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Wait Until Element Is Visible     locator=${ADD_PRODUTO_CARRINHO}

Remover o produto "${PRODUTO}" do carrinho
    Click Element    locator=sw-gtc
    Click Element    locator=${ESVAZIAR_CARRINHO}

Verificar se o carrinho fica vazio
    Wait Until Element Is Visible    locator=${REMOVE_PRODUTO_CARRINHO}


# GHERKIN STEPS
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"

Quando adicionar o produto "Console Xbox Series S" no carrinho
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

E existe o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio