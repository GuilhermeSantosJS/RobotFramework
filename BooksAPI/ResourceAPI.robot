*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library          RequestsLibrary
Library          Collections
Library    XML

*** Variables ***
${URL_API}       https://fakerestapi.azurewebsites.net/api/v1/Books
&{BOOK_15}      id=15
...             title=Book 15
...             description=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n
...             pageCount=1500
...             excerpt=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\n


*** Keywords ***
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

Requisitar todos os livros
    ${RESPOSTA}    GET On Session    fakeAPI    ${URL_API}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET On Session    fakeAPI    ${URL_API}/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir o status code
    [Arguments]        ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason 
    [Arguments]    ${REASON_DESEJADO}    
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retornar uma lista com "${QTDE_LIVROS}" livros
    Length Should Be   ${RESPOSTA.json()}   ${QTDE_LIVROS}     

Conferir se retornar todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description    ${BOOK_15.description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_15.pageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt        ${BOOK_15.excerpt}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}               publishDate   

Cadastrar um novo livro
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    POST On Session   fakeAPI    ${URL_API}
    ...                           data={"id": 5000,"title": "teste","description": "teste", "pageCount": 200,"excerpt": "teste","publishDate": "2022-07-15T21:04:38.936Z"}
    ...                           headers=${HEADERS}
    Log                           ${RESPOSTA.text}
    Set Test Variable             ${RESPOSTA}

Alterar o livro "${ID_LIVRO}"
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    PUT On Session   fakeAPI    ${URL_API}/${ID_LIVRO}
    ...                           data={"id": 5000,"title": "ola tudo bem","description": "teste", "pageCount": 200,"excerpt": "teste","publishDate": "2022-07-15T21:04:38.936Z"}
    ...                           headers=${HEADERS}
    Log                           ${RESPOSTA.text}
    Set Test Variable             ${RESPOSTA}        

Deletar o livro "${ID_LIVRO}"
    ${RESPOSTA}    DELETE On Session    fakeAPI    ${URL_API}/${ID_LIVRO}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Conferir se deletou o livro "${ID_LIVRO}"
    ${RESPOSTA}    GET On Session    fakeAPI    ${URL_API}/${ID_LIVRO} 
