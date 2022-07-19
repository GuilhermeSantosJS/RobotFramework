*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                  chrome
${ID_GENDER}                id=id_gender2
${CUSTOMER_FIRSTNAME}       id=customer_firstname
${CUSTOMER_LASTNAME}        id=customer_lastname
${PASSWORD}                 id=passwd
${ADDRESS}                  id=address1 
${CITY}                     id=city
${ID_STATE}                 id=id_state
${POST_CODE}                id=postcode
${PHONE_MOBILE}             id=phone_mobile
${TITLE_PERSONAL}           xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
${SUBMIT_ACCOUNT}           submitAccount
${CADASTRO_SUCESS}          xpath=//*[@id="center_column"]/p
${NOME_USER}                xpath=//*[@id="header"]/div[2]//div[1]/a/span    


*** Keywords ***
Preencher os dados obrigatórios
    Wait Until Element Is Visible   ${TITLE_PERSONAL}    
    Click Element                   ${ID_GENDER}
    Input Text                      ${CUSTOMER_FIRSTNAME}        May
    Input Text                      ${CUSTOMER_LASTNAME}         Fernandes
    Input Text                      ${PASSWORD}                  123456
    Input Text                      ${ADDRESS}                   Rua Framework, Bairro Robot
    Input Text                      ${CITY}                      Floripa
    Set Focus To Element            ${ID_STATE}
    ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
    ### pelo elemento quando for firefox
    Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   ${ID_STATE}
    Select From List By Index       ${ID_STATE}              9
    Input Text                      ${POST_CODE}             12345
    Input Text                      ${PHONE_MOBILE}          99988877

Submeter cadastro
    Click Button                    ${SUBMIT_ACCOUNT}

### Conferências
Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    ${CADASTRO_SUCESS}
    Element Text Should Be           ${CADASTRO_SUCESS}
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           ${NOME_USER}            May Fernandes