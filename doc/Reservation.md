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
 Create a reservation in database
 
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

    curl --Header "Authorization: Bearer {JsonWEBToken}" https://api.domain.com/reservations -X POST -d 'host=demoarshost@gmail.com' -d 'guest=demoarsguest@gmail.com' -d 'house_id=2'`
 
 
