*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BTN_LOGIN}          xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]
${BTN_CRIAR_CONTA}    id=email_create
${BTN_SUBMIT}         id=SubmitCreate

*** Keywords ***
Clicar em "Sign in"
    Click Element    ${BTN_LOGIN}

Informar um e-mail válido
    Wait Until Element Is Visible   ${BTN_CRIAR_CONTA}
    ${EMAIL}                        Generate Random String
    Input Text                      ${BTN_CRIAR_CONTA}    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Click Button    ${BTN_SUBMIT}
