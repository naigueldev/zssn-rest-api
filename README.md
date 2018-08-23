# ZSSN (Zombie Survival Social Network) - REST API

## Install

Before the installation, make sure to have the Ruby 2.3.1 installed.
After that, for the application install, download it and run the following commands:

```
gem install bundle
bundle install
rails db:create
rails db:migrate
```

Then, run `rails s`, and it will be available at http://localhost:3000

-------------------------------------------------------------------------

## API Documentation

* **POST /survivors**

```
HEADERS
Content-Type: application/json

Example Request
{
  "name":"Naiguel",
  "age":"28",
  "gender":"M",
  "latitude":"-29.6874904,",
  "longitude":"-53.8099161",
  "inventories_attributes":
  [
  {
    "item":"Water",
    "quantity":1
    },
    {
      "item":"Medication",
      "quantity":1
    }
    ]
  }
  ```
  ##### Example Response:

  ```
  201 Created
  {
    "id": 64,
    "name": "Naiguel",
    "age": 28,
    "gender": "M",
    "latitude": -29.6874904,
    "longitude": -53.8099161,
    "is_infected": false,
    "contamination_count": 0,
    "inventories": [
    {
      "item": "Water",
      "quantity": 1,
      "points": 4
      },
      {
        "item": "Medication",
        "quantity": 1,
        "points": 2
      }
      ]
    }

    ```

    * **GET /survivors**

    ##### Example Response:

    ```
    200 OK
    [
    {
      "id": 64,
      "name": "Naiguel",
      "age": 28,
      "gender": "M",
      "latitude": -29.6874904,
      "longitude": -53.8099161,
      "is_infected": false,
      "contamination_count": 0,
      "inventories": [
      {
        "item": "Water",
        "quantity": 1,
        "points": 4
        },
        {
          "item": "Medication",
          "quantity": 1,
          "points": 2
        }
        ]
      }
      ]

      ```

      * **PUT /survivors/64**

      ##### Example Request:

      ```
      HEADERS
      Content-Type: application/json

      {
        "survivor":
        {
          "latitude": "-28.2827842",
          "longitude": "-52.3685962,"
        }
      }

      ```

      ##### Example Response:

      ```
      204 No Content

      ```

      * **POST /survivors/64/report_infection**

      ##### Example Response:

      ```
      200 OK

      {
        "message": "Survivor reported as infected 1 times"
      }

      ```

      * **POST /trade**

      ##### Example Request:

      ```
      HEADERS
      Content-Type: application/json

      BODY

      {
        "trade": {
          "survivor_one": {
            "id": 66,
            "inventories": [
            {
              "item": "Food",
              "quantity": 1
              },
              {
                "item": "Medication",
                "quantity": 1
              }
              ]
              },
              "survivor_two": {
                "id": 67,
                "inventories": [
                {
                  "item": "Water",
                  "quantity": 1
                  },
                  {
                    "item": "Ammunition",
                    "quantity": 1
                  }
                  ]
                }
              }
            }

            ```


            #### Example Response:

            ```
            200 Ok
            Content-Type: "application/json"

            {
              "message": "Trade successfully completed"
            }
            ```

            ##### Errors

            Error | Description
            ----- | ------------
            404   | Survivor with id [id] cannot be found in the system
            409   | Survivor with id= (id) Name=(name) is infected!
            409   | Survivor with id= (id) doesn't have enough item=(item)
            400   | Both sides of the trade should offer the same amount of points

            * **GET reports/infected**
            Percentage of infected survivors.

            ```
            Content-Type: "application/json"
            ```

            #### Example Response:

            ```
            200 Ok
            Content-Type: "application/json"

            {
              "percentage": "11.11%"
            }
            ```

            * **GET reports/non-infected**
            Percentage of non-infected survivors.

            ```
            Content-Type: "application/json"
            ```

            #### Example Response:

            ```
            200 Ok
            Content-Type: "application/json"

            {
              "percentage": "88.89%"
            }
            ```

            * **GET reports/inventories**
            Percentage of non-infected survivors.

            ```
            Content-Type: "application/json"
            ```

            #### Example Response:

            ```
            200 Ok
            Content-Type: "application/json"

            {
              "water": 0.875,
              "food": 0.25,
              "medication": 0.875,
              "ammunition": 0.625
            }
            ```

            * **GET reports/points**
            Percentage of non-infected survivors.

            ```
            Content-Type: "application/json"
            ```

            #### Example Response:

            ```
            200 OK
            Content-Type: "application/json"

            {
              "lostPoints": 6
            }
            ```


            ## Testing with RSpec

            To execute the tests just run the tests with RSpec.

            Execute all tests

            ~~~ sh
            $ bundle exec rspec
            ~~~
