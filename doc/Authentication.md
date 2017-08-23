## Routes


post 'auth' => 'authentication#authenticate_user'
get 'logout', 				 to: 'authentication#destroy'
get '/'

`GET    /reservations -> Retrieve all the reservations`

`POST   /reservations -> Create a reservation`

`GET    /reservations/:id -> show a specific reservation`

`PUT    /reservations/:id -> Update a reservation`

`DELETE /reservations/:id -> Delete a reservation`

**Authentication (JWT)**
----
Authenticate the user and return a unique token
 
 * **URL**

  /auth

* **Method:**
  
  `POST`

*  **URL Params**

   email: [String]
   
   password: [String]

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{"auth_token": {JSONWebToken},"user":{"id":1,"email":"demoarsguest@gmail.com"}}`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Invalid Username/Password"]}`

* **Sample Call:**

    `curl --Header "Authorization: Bearer {MyJSONWebToken}" https://api.mydomain.com/reservations `
 
 **Authentication using OAuth 2 (Google account)**
----
 Log in the user using a third party server.
 
 * **URL**

  /

* **Method:**
  
  `GET`

*  **URL Params**

   host: email address

   guest: email address

* **Success Response:**

  * **Redirect to:** / <br />

* **Note:**

  You can log in using your google account through a web browser going on the root page ('/')

 **Logout**
----
 Logout the user
 
 * **URL**

  /logout

* **Method:**
  
  `GET`

*  **URL Params**

   No params

* **Success Response:**

  * **Code:** 200 OK <br />
    **Content:** `{"message":"Done"}`

* **Note:**

    This function never fail.
    
