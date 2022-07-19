*** Settings ***
Resource            ../resources/Resource.robot
Resource            ../resources/PO/Home.robot
Resource            ../resources/PO/Carrinho.robot
Resource            ../resources/PO/MinhaConta.robot
Resource            ../resources/PO/CriarConta.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador

*** Test Case ***
Caso de Teste com PO 01: Remover Produtos do Carrinho
    Home.Acessar a página home do site
    Home.Adicionar o produto "t-shirt" no carrinho
    Carrinho.Excluir o produto do carrinho
    Carrinho.Conferir se o carrinho fica vazio

### EXERCÍCIO
Caso de Teste com PO 02: Adicionar Cliente
    Home.Acessar a página home do site
    MinhaConta.Clicar em "Sign in"
    MinhaConta.Informar um e-mail válido
    MinhaConta.Clicar em "Create an account"
    CriarConta.Preencher os dados obrigatórios
    CriarConta.Submeter cadastro
    CriarConta.Conferir se o cadastro foi efetuado com sucesso
