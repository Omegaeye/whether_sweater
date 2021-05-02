# Whether-Sweater
  * Whether-Sweater: This app will allow users to see the current weather as well as the forecasted weather at the destination.

  https://github.com/Omegaeye/whether_sweater

## Authors

- **Khoa Nguyen**   
        
  * <img src="https://user-images.githubusercontent.com/46826902/114424033-fb538b00-9b74-11eb-884d-429d4ad4132d.png"> - https://github.com/Omegaeye
  * <img src="https://user-images.githubusercontent.com/46826902/114425392-43bf7880-9b76-11eb-811a-d3255ced4b3b.png"> 

## Table of Contents

  - [Getting Started](#getting-started)
  - [API End Points](#api-end-points)
  - [Runing the tests](#running-the-tests)
  - [Method Highlights/Tests](#method-highlights/tests)
  - [Running the tests](#running-the-tests)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

### GemFile/Dependency

 <img src="https://user-images.githubusercontent.com/46826902/116293329-ffc29b00-a753-11eb-8034-37b456906e41.png" width="75%" height="50%">
hi

### Prerequisites

What things you need to install the software and how to install them

* rails

```
gem install rails --version 5.2.4.3
```

### Installing

    1. Clone Repo
    2. Register for api key at:
        - https://openweathermap.org/api
        - https://developer.mapquest.com/
        - https://www.flickr.com/services/api/
    3. Install gem packages: 'bundle install'
    4. Setup and migrate the database: `rails db:{create migrate}`
    5. Put your api keys into application.yml

## API End Points
  To access the API end points, type in rails server then copy and paste the end points into the Postman/browser with the values.

    * Search for developer salaries in urban area: http://localhost:3000/api/v1/salaries?destination={{city_name,state}}
    
    * Search for weather forecast in a city and state: http://localhost:3000/api/v1/forecast?location={{city_name,state}}
    
    * Search for an image of a given city and state: http://localhost:3000/api/v1/backgrounds?location={{city_name,state}}
    
    * Search for distance, time, and weather for a road trip: http://localhost:3000/api/v1/road_trip
        - To search open up postman and set up your post to the following image:

 <img src="https://user-images.githubusercontent.com/46826902/116298175-5a122a80-a759-11eb-84fa-356afae88997.png">

        - expect response

 <img src="https://user-images.githubusercontent.com/46826902/116298793-2257b280-a75a-11eb-8cea-25ed1c0e0d9d.png">

### Creating a user and authenticate
    To create a user 
        * post http://localhost:3000/api/v1/users with valid attributes and headers

   <img src="https://user-images.githubusercontent.com/46826902/116296159-1c140700-a757-11eb-9895-cf3c825b25f5.png" width="75%" height="50%">

        * expect response

   <img src="https://user-images.githubusercontent.com/46826902/116296936-06eba800-a758-11eb-935d-fbf5d3318217.png">

    To authenticate user

        * post http://localhost:3000/api/v1/sessions with valid attributes and headers

   <img src="https://user-images.githubusercontent.com/46826902/116297368-6ea1f300-a758-11eb-8374-b8624fa8a275.png" width="75%" height="50%">

        * expect response

   <img src="https://user-images.githubusercontent.com/46826902/116297523-95f8c000-a758-11eb-98e1-05cbbb63c305.png">

## Method Highlights/Tests

### Authenticating with api keys 
  * Created a polymorphic api_keys table that can authenticate tokens/api keys
    -   Implemented ActiveSupport::Concern to help support the functionality of the controller 
    -   Screening params and return the array to the user

        <img src="https://user-images.githubusercontent.com/46826902/116299439-f1c44880-a75a-11eb-8b69-0ee267b9cb50.png" width="75%" height="50%">
### Methods to return errors
  * Utilizing methods to generate error JSON to return to user.

  <img src="https://user-images.githubusercontent.com/46826902/116300147-c9891980-a75b-11eb-9dd9-ccd4d22b51ec.png" width="75%" height="50%">

### Testing this Method
  * Authenticate User
     - Happy Path

        <img src="https://user-images.githubusercontent.com/46826902/116300580-487e5200-a75c-11eb-8736-d40deacb4460.png" width="75%" height="50%">

     - Sad Path

     <img src="https://user-images.githubusercontent.com/46826902/116300924-b296f700-a75c-11eb-8bc5-f7fe6e8d77b3.png" width="75%" height="50%">

     - Edge Case

     <img src="https://user-images.githubusercontent.com/46826902/116301044-d5291000-a75c-11eb-9175-251fe216c060.png" width="75%" height="50%">



## Running the tests

In order to run all tests and see coverage run:

  ```
  bundle exec rspec
  ```

## Built With

  - Ruby/Rails
  - HTML
  - API

## License

  - Me and me only

## Acknowledgments

  - My 2011 BE cohorts that helped me out a lot.
