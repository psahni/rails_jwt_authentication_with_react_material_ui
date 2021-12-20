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

  ```yaml
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
  $ bundle install
```

```
  $ yarn
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
  #### Open Postman


  #### Register

```
  POST http://127.0.0.1:3000/api/signup

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

  #### Login Request

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
```


  #### Home

```
  GET http://127.0.0.1:3000/home


  Headers

  Content-Type application/json
  Accept    application/json
  Authorization Bearer <token_received_from_the_login_req>

```

  #### Logout

```
  DELETE http://127.0.0.1:3000/api/logout


  Headers

  Content-Type application/json
  Accept    application/json
  Authorization Bearer <token_received_from_the_login_req>

```

## Materal UI

* Material UI has been integrated
* Refer 
  - package.json
  - Login.jsx component


## TODO: Referrals

* Create Model Referral

```
  table referrals
    id: integer
    referral_code: string
    referral_email: string
    user_id: integer
```

* Create a form on UI 

  ```
    form with email text field
    submit button
    create Referral object (generate referral code at the backend)
  ```

* Trigger email

  ```
    send email with referral link with referral code appended in the url
  ```

* On Email Receive

  ```
    User clicks the email
    lands on the referral page
    If referral code is valid, redirect the user on the registration page with email field filled (option 1)
    If referral code is valid, create the user with referral email and dummy password and sign in the user (option 2)
    Send the dummy password through email (User will have the ability change the password later on)
  ```
