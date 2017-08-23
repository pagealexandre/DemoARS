# DemoARS

## Introduction

RESTful API implementing an ARS booking scenario.

## Features
- Authentication system : JSON Web Token and Oauth 2.0 (Google)
- Cron jobs running in the background for set and remove expired reservation. Using `Whenever` gem
- To notify participants about the state of the context (reservation cancelled, created etc...), an email service, [Mailgun](https://www.mailgun.com) has been implemented
- Unitary tests made to verify controllers and model behavior using `spec` and `capybara` gem . You can launch the entire suit using `bundle exec rspec spec/`
- Fake entity for test are created using `FactoryGirl` and `Faker` gem

## Documentation

### Authentication

* The API implement a token based authentication system. (JWT + OAuth 2.0) See [Authentication doc](https://github.com/pagealexandre/DemoARS/blob/master/doc/Authentication.md) to log in.

## Reservations
* You can retrieve, update, remove reservation and more. See [Reservation routes](https://github.com/pagealexandre/DemoARS/blob/master/doc/Reservation.md)

## Choreography

![ARS Scenario](https://github.com/pagealexandre/DemoARS/blob/master/choreography/SecureARSReservationScenario.png)
