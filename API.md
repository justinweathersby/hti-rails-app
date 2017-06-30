| path | method | purpose |
| :---: | :---: | --- |
| POST | /api/auth | Email registration. Requires **`email`**, **`password`**, and **`password_confirmation`** params.|

*Parameters:*
```json
{
  "email": "user@mail.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```
*Response:*

* **Success**
  ```json
  {
    "status": "success",
    "data": {
      "id": 3,
      "email": "user@mail.com",
      "provider": "email",
      "uid": "user@mail.com",
      "name": null,
      "password": "123456",
      "profession": null,
      "device_token": null,
      "device_type": null,
      "auth_token": null,
      "role": null,
      "created_at": "2017-06-30T08:35:02.773Z",
      "updated_at": "2017-06-30T08:35:02.947Z"
    }
  }
  ```
  *Headers:*
  ```
  ...
  access-token: SJfzuAXwJhTxnp0_4pVXNA
  client: 4qh59FM7S2WGSHiiJRHcvQ
  expiry: 1500021302
  token-type: Bearer
  uid: user@mail2.com
  ...
  ```
* **Error**
  ```json
  {
    "status": "error",
    "data": {
      "id": null,
      "name": null,
      "email": "user@mail.com",
      "password": null,
      "profession": null,
      "device_token": null,
      "device_type": null,
      "auth_token": null,
      "role": null,
      "created_at": null,
      "updated_at": null,
      "provider": "email",
      "uid": ""
    },
    "errors": {
      "email": [
        "has already been taken",
        "has already been taken"
      ],
      "full_messages": [
        "Email has already been taken",
        "Email has already been taken"
      ]
    }
  }
  ```

| path | method | purpose |
| :---: | :---: | --- |
| DELETE | /api/auth | Account deletion. This route will destroy users identified by their **`uid`**, **`access_token`** and **`client`** headers.|

*Parameters:*
```json
{
  "access-token": "SJfzuAXwJhTxnp0_4pVXNA", 
  "client": "4qh59FM7S2WGSHiiJRHcvQ",
  "uid": "user@mail.com"
}
```
*Responce:*

* **Success**
  ```json
  {
    "status": "success",
    "message": "Account with UID 'user@mail.com' has been destroyed."
  }
  ```
* **Error**
  ```json
  {
    "status": "error",
    "errors": [
      "Unable to locate account for destruction."
    ]
  }
  ```
  
| path | method | purpose |
| :---: | :---: | --- |
| PUT | /api/auth | Account updates. This route will update an existing user's account settings. The default accepted params are password and password_confirmation, but this can be customized using the devise_parameter_sanitizer system. If config.check_current_password_before_update is set to :attributes the current_password param is checked before any update, if it is set to :password the current_password param is checked only if the request updates user password|

*Parameters:* 
```json
{
  "access-token": "SJfzuAXwJhTxnp0_4pVXNA", 
  "client": "4qh59FM7S2WGSHiiJRHcvQ",
  "uid": "user@mail.com",
  "name": "User"
}
```
*Responce:*
* **Success**
  ```json
  {
      "status": "success",
      "data": {
          "id": 5,
          "name": "User",
          "email": "user@mail.com",
          "provider": "email",
          "uid": "user@mail.com",
          "password": null,
          "profession": null,
          "device_token": null,
          "device_type": null,
          "auth_token": null,
          "role": null,
          "created_at": "2017-06-30T08:52:59.197Z",
          "updated_at": "2017-06-30T10:13:07.159Z"
      }
  }
  ```
  *Headers:*
  ```
  ...
    access-token: ezjZvbPF6ErG5gv9EEcFKA
    client: 4qh59FM7S2WGSHiiJRHcvQ
    expiry: 1500029187
    token-type: Bearer
    uid: user@mail.com
  ...
  ```
* **Error**
  ```json
  {
    "status": "error",
    "errors": [
      "User not found."
    ]
  }
  ```

| path | method | purpose |
| :---: | :---: | --- |
| POST | /api/auth/sign_in | Email authentication. Requires **`email`** and **`password`** as params. This route will return a JSON representation of the User model on successful login along with the access-token and client in the header of the response.|

*Params:*
```json
{
  "email": "user@mail.com",
  "password": "123456"
}
```
*Responce:*
* **Success**
  ```json
  {
    "data": {
      "id": 5,
      "email": "user@mail.com",
      "provider": "email",
      "uid": "user@mail.com",
      "name": "User",
      "password": null,
      "profession": null,
      "device_token": null,
      "device_type": null,
      "auth_token": null,
      "role": null
    }
  }
  ```
  *Headers:*
  ```
  ...
    access-token: TruHwTkBivbescwC-Teopg
    client: 5bR9Al2jndT7F9hdo8pheQ
    uid: user@mail.com
  ...
  ```
* **Error**
  ```json
  {
    "errors": [
      "Invalid login credentials. Please try again."
    ]
  }
  ```



| path | method | purpose |
| :---: | :---: | --- |
| DELETE | /api/auth/sign_out | Use this route to end the user's current session. This route will invalidate the user's authentication token. You must pass in **`uid`**, **`client`**, and **`access-token`** in the request headers.|

*Params:*
```json
{
  "access-token": "8gKEXimQ-NUb1KSOa38TOg",
  "client": "rvYmHSEn9pTJ3TWPs3u5nA",
  "uid": "user@mail.com"
}
```
*Responce:*
* **Success**
  ```json
  {
    "success": true
  }
  ```
* **Error**
  ```json
  {
    "errors": [
      "User was not found or was not logged in."
    ]
  }
  ```
  
| path | method | purpose |
| :---: | :---: | --- |
| GET | /api/auth/validate_token | Use this route to validate tokens on return visits to the client. Requires **`uid`**, **`client`**, and **`access-token`** as params. These values should correspond to the columns in your User table of the same names.|

*Params:*
```json
{
  "access-token": "8gKEXimQ-NUb1KSOa38TOg",
  "client": "EvSKWUPjMBMT9rOkOuz5zg",
  "uid": "user@mail.com"
}
```
*Responce:*
* **Success**
  ```json
  {
    "success": true,
    "data": {
      "id": 5,
      "name": "User",
      "email": "user@mail.com",
      "password": null,
      "profession": null,
      "device_token": null,
      "device_type": null,
      "auth_token": null,
      "role": null,
      "provider": "email",
      "uid": "user@mail.com"
    }
  }
  ```
  *Headers:*
  ```
  ...
    access-token: KJ6HTBCw6ZuLNgltSWGltQ
    client: EvSKWUPjMBMT9rOkOuz5zg
    uid: user@mail.com
  ...
  ```
* **Error**
  ```json
  {
    "success": false,
    "errors": [
      "Invalid login credentials"
    ]
  }
  ```

| path | method | purpose |
| :---: | :---: | --- |
| POST | /api/auth/password | Use this route to send a password reset confirmation email to users that registered by email. Accepts **`email`** and **`redirect_url`** as params. The user matching the email param will be sent instructions on how to reset their password. redirect_url is the url to which the user will be redirected after visiting the link contained in the email.|

*Params:*
```json
{
  "email": "user@mail.com",
  "redirect_url": "/"
}
```
*Responce:*
* **Success**
  ```json
  {
    "success": true,
    "message": "An email has been sent to 'user@mail.com' containing instructions for resetting your password."
  }
  ```
* **Error**
  ```json
  {
    "success": false,
    "errors": [
        "Unable to find user with email 'user@mail.com'."
    ]
  }
  ```

| path | method | purpose |
| :---: | :---: | --- |
| PUT | /api/auth/password | Use this route to change users' passwords. Requires **`password`** and **`password_confirmation`** as params. This route is only valid for users that registered by email (OAuth2 users will receive an error). It also checks current_password if config.check_current_password_before_update is not set false (disabled by default).|

*Params:*
```json
{
  "access-token": "1_VBzMdkLsvMW-Cdh8qr1w",
  "client": "Q7YnDdh0wm2j6gk11O-I_g",
  "uid": "user@mail.com",
  "password": "1234567",
  "password_confirmation": "1234567"
}
```
*Responce:*
* **Success**
  ```json
    {
      "success": true,
      "data": {
        "id": 5,
        "provider": "email",
        "email": "user@mail2.com",
        "uid": "user@mail2.com",
        "name": "User",
        "password": "1234567",
        "profession": null,
        "device_token": null,
        "device_type": null,
        "auth_token": null,
        "role": null,
        "created_at": "2017-06-30T08:52:59.197Z",
        "updated_at": "2017-06-30T12:19:38.912Z"
      },
      "message": "Your password has been successfully updated."
    }
  ```
* **Error**
  ```json
  {
    "success": false,
    "errors": [
      "Unauthorized"
    ]
  }
  ```

  ```json
  {
    "success": false,
    "errors": {
      "password_confirmation": [
        "doesn't match Password"
      ],
      "full_messages": [
        "Password confirmation doesn't match Password"
      ]
    }
  }
  ```