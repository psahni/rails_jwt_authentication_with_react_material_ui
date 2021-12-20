## System requirements
  * Ruby - 3.0.0
  * nodejs
  * postgresql
  * yarn
  * Postman


## How to run on local machine
  ```
    git clone https://github.com/psahni/ruby-service-posts-comments-rating
  ```

  * open database.yml and update your database settings

  ```
    default: &default
    adapter: postgresql
    encoding: unicode
    pool: 40
    host: 127.0.0.1
    port: 5432
    username: <your_postgresql_username>
    password: <your_password>
  ```

```
 $ rake db:create
```

```
  $ rake db:migrate
```

```
  $ rails s
```


## Api requests
* open Postman


* Register

```
  SIGN UP http://127.0.0.1:3000/api/signup

  Body

    {  
      "user": {
        "email": "pra100@gmail.com",
        "password": "password",
        "password_confirmation": "password"
    }
  }

  Headers

  Content-Type application/json
  Accept    application/json
  
```

* Login Request

```
  POST http://127.0.0.1:3000/api/login

  Body 

  {
    "user":
      {
        "email": "pra100@gmail.com",
        "password": "password"
      }
  }

  
  Headers

  Content-Type application/json
  Accept    application/json
  Authorization Bearer <token_rece
```


* Home

```
  SIGN UP http://127.0.0.1:3000/home


  Headers

  Content-Type application/json
  Accept    application/json
  Authorization Bearer <token_received_from_the_login_req>

```

* Logout

```
  SIGN UP http://127.0.0.1:3000/api/logout


  Headers

  Content-Type application/json
  Accept    application/json
  Authorization Bearer <token_received_from_the_login_req>

```