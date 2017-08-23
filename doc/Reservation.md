**Show all reservations**
----
 Return JSON data about all the reservations.
 
 * **URL**

  /reservations

* **Method:**
  
  `GET`

*  **URL Params**

   No Params

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `[{"id":2,"guest":"demoarsguest@gmail.com","host":"demoarshost@gmail.com","status":0,"house_id":2,"created_at":"2017-08-20T11:30:46.174Z","updated_at":"2017-08-20T11:30:46.174Z"}]`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Not Authenticated"]}`

* **Sample Call:**

    `curl --Header "Authorization: Bearer {MyJSONWebToken}" https://api.mydomain.com/reservations `
 
 **Create a reservation**
----
 Create and return a reservation in JSON format
 
 * **URL**

  /reservations

* **Method:**
  
  `POST`

*  **URL Params**

   host: email address

   guest: email address
   
   house_id: [Integer]

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{"id":8,"guest":"demoarsguest@gmail.com","host":"demoarshost@gmail.com","status":0,"house_id":1,"created_at":"2017-08-22T21:24:49.337Z","updated_at":"2017-08-22T21:24:49.337Z"}`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Not Authenticated"]}`
   
OR

  * **Code:** 422 UNPROCESSABLE ENTRY <br />
    **Content:**  {"house_id":["can't be blank"]}

* **Sample Call:**

    `curl --Header "Authorization: Bearer {JsonWEBToken}" https://api.domain.com/reservations -X POST -d 'host=demoarshost@gmail.com' -d 'guest=demoarsguest@gmail.com' -d 'house_id=2'`
    

 **Show a reservation**
----
Show a specific reservation based on the ID
 
 * **URL**

  /reservations/:id

* **Method:**
  
  `GET`

*  **URL Params**

   id: Id of the reservation

* **Success Response:**

  * **Code:** 200 OK <br />
    **Content:** `{"id":8,"guest":"demoarsguest@gmail.com","host":"demoarshost@gmail.com","status":0,"house_id":1,"created_at":"2017-08-22T21:24:49.337Z","updated_at":"2017-08-22T21:24:49.337Z"}`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Not Authenticated"]}`
   
OR

  * **Code:** 404 NOT Found <br />
    **Content:**  {"error":"Couldn't find Reservation with 'id'=1"}

* **Sample Call:**

    `--Header "Authorization: Bearer {JsonWEBToken}" https://api.domain.com/reservations/8`
    
**Update a reservation**
----
 Update the reservations (Accepted, declined, cancelled) and return it.
 
 * **URL**

  /reservations/:id

* **Method:**
  
  `PUT`

*  **URL Params**

   status: [Integer] 1 = Cancel - 2 = Decline - 3 = Accepted

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** `{"id":8,"status":2,"guest":"demoarsguest@gmail.com","host":"demoarshost@gmail.com","house_id":1,"created_at":"2017-08-22T21:24:49.337Z","updated_at":"2017-08-22T21:42:27.549Z"}`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Not Authenticated"]}`

* **Sample Call:**

    `curl --Header "Authorization: Bearer {JsonWEBToken}" https://api.domain.com/reservations/8 -X PUT -d 'status=2' `
 

**Remove a reservation**
----
 Remove the specified reservation.
 
 * **URL**

  /reservations/:id

* **Method:**
  
  `DELETE`

*  **URL Params**

   Id: [Integer]

* **Success Response:**

  * **Code:** 204 <br />
    **Content:** `no content`
 
* **Error Response:**

  * **Code:** 401 UNAUTHORIZED <br />
    **Content:** `{"errors":["Not Authenticated"]}`

* **Sample Call:**

    `curl -X DELETE --Header "Authorization: Bearer {JSONWebToken}"  https://api.domain.com/reservations/8 `
    
