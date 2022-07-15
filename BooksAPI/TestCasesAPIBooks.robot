*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource         ResourceAPI.robot
Suite Setup      Conectar a minha API


*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retornar uma lista com "200" livros
    
Buscar um livro específico (GET em um livro específico)
    Requisitar o livro "15"
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se retornar todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
 
Altera um livro (PUT)
    Alterar o livro "5000"
    Conferir o status code    200
    Conferir o reason    OK

Deletar um livro (DELETE)
    Deletar o livro "15"
    Conferir o status code    200
    Conferir o reason    OK
    Conferir se deletou o livro "15"

