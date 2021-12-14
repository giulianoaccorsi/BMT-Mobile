### Por onde começar ?

* [URL base](https://flask-login-api.herokuapp.com/api) - https://flask-login-api.herokuapp.com/api 

### Pré-requisitos

```
HTTPie
```

## API Endpoints

|  URL | Métodos | Descrição |
| -------- | ------------- | --------- |
| `/api/ads/<int:id>` | GET, PUT, DELETE  | Visualizar anúncio específico , alterar anúncio, deletar anúncio |
| `/api/ads` | GET, POST  | Ver todas os anúncios, cadastrar anúncio |
| `/api/users/<int:id>` | GET, PUT  | Visualizar usuario específico, alterar usuário |
| `/api/users` | GET, POST, PUT  | Ver todas os usuários, cadastrar usurios, alterar usuários |

## Acessando a API com um token

É necessário possuir um usuário para gerar um token para usar a API. Instale o [HTTPie](https://httpie.org/#installation). É possivel então gerar um token com seu usuário e senha. Exemplo:

```
http POST https://flask-login-api.herokuapp.com/api full_name="name" email="username@domain.com" password="123"
```

```
http --auth username@domain.com:123 POST https://flask-login-api.herokuapp.com/api
```

O comando acima irá gerar seu token de acesso. Ele possui uma hora de duração. Para maior praticidade, guarde-o em uma variavel com o seguinte comando:

```
export TOKEN=<seu_token>
```

Acesse um dos endpoints da seguinte maneira:

```
http GET https://flask-login-api.herokuapp.com/api/users Authorization:"Bearer $TOKEN"
```
APROVEITE!

## Construído com

* [Flask](https://flask.palletsprojects.com/en/1.1.x/) - Framework utilizado

## Dúvidas ?

Pergunte qualquer coisa na seção "Issue". Em caso de erros, poste o motivo e o log para uma melhor resposta!

* [Dúvidas](https://github.com/WadsonGarbes/pontotel/issues)
