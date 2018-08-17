# ZSSN (Zombie Survival Social Network) - REST API

## Documentation

* [Installation](#installation)
* [API Documentation](#api-documentation)
  * [List Survivors](#list-survivors)
  * [Add Survivors](#add-survivors)
  * [Update Survivor Location](#update-survivor-location)
  * [Flag Survivor as Infected](#flag-survivor-as-infected)
  * [Trade Resources](#trade-resources)
* [Reports](#reports)
  * [Percentage of infected survivors](#percentage-of-infected-survivors)
  * [Percentage of non-infected survivors](#percentage-of-non-infected-survivors)
  * [Average Resources By Survivor](#average-resources-by-survivor)
  * [Points lost because of infected survivors](#points-lost-because-of-infected-survivors)
* [Testing with RSpec](#testing-with-rspec)
* [Credits](#credits)

## Installation


1. Clone the project and run the following commands.

	~~~ sh
	$ bundle install
  $ rake db:create
  $ rake db:migrate
	~~~

2. Start the application

	~~~ sh
	$ rails s
	~~~

Application will be runing at [localhost:3000](http://localhost:3000).

## API Documentation

### List Survivors

##### Request

```sh
GET  /survivors`
```

##### Response

```sh
status: 200 Ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
[
    {
        "_id": {
            "$oid": "598c6da62a43161f3eb5bb66"
        },
        "name": "Survivor",
        "age": "25",
        "gender": "male",
        "latitude": "-16.680353",
        "longitude": "-49.256302",
        "inventories": [
            {
                "_id": {
                    "$oid": "598c6da62a43161f3eb5bb67"
                },
                "item": "Water"
                "points": null,
                "quantity": 10,
            },
            {
                "_id": {
                    "$oid": "598c6da62a43161f3eb5bb68"
                },
                "item": "Food"
                "points": null,
                "quantity": 6,
            }
        ]
    }
]
```

### Add Survivors

##### Request

```sh
POST  /survivors`
```

```sh
Parameters:
{
    "survivor":
    {
        "name": "Survivor Test",
        "age": "43",
        "gender": "M",
        "latitude": "89809809809",
        "longitude": "-88983982100",
        "inventories": [
        {
            "item": "Water",
            "quantity": 10

        },
        {
            "item":"Food",
            "quantity": 6

        }]
    }
}
```

##### Response

```sh
status: 201 created
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "_id": {
        "$oid": "5990f7357b6ee2652e9e581a"
    },
    "age": "43",
    "gender": "M",
    "infection_count": 0,
    "last_location": {
        "latitude": "89809809809",
        "longitude": "-88983982100"
    },
    "name": "Survivor Test"
}
```

##### Errors
Status | Error                | Message
------ | ---------------------|--------
422    | Unprocessable Entity |   
409    | Conflict             | survivor need to declare its own resources

### Update Survivor Location

##### Request

```sh
PATCH/PUT /survivors/:id
```

```sh
Parameters:
{
    "survivor":
    {
        "latitude": "-16.6868824",
        "longitude": "-49.2647885"
    }
}
```

##### Response

```sh
status: 204 no_content
```

```sh
Content-Type: "application/json"
```

##### Errors
Status | Error      |
------ | -----------|
404    | Not Found  |

### Flag Survivor as Infected

##### Request

```sh
POST   /survivors/:id/flag_infection
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "message": "Attention! Survivor was reported as infected x time(s)!"
    "message": "Warning! Survivor was reported as infected x time(s)"
}
```

##### Errors
Status | Error      |
------ | -----------|
404    | Not Found  |


### Trade Resources

Survivors can trade items among themselves, respecting a price table.

##### Request

```sh
POST   /trade_resources
```

```sh
Parameters:
{
  "trade": {
    "survivor_1": {
      "id": "5991814f2a43166a43c27b48",
      "resources": [
        {
          "type": "Water",
          "quantity": 1
        },
        {
          "type": "Medication",
          "quantity": 1
        }
      ]
    },
    "survivor_2": {
      "id": "5991814f2a43166a43c27b4b",
      "resources": [
        {
          "type": "Ammunition",
          "quantity": 6
        }
      ]
    }
  }
}
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "message": "Trade successfully completed"
}
```

##### Errors
Status | Error                | Message
------ | ---------------------|--------
404    | Not Found            | Survivor with id xxxxx does not exist
409    | Conflict             | Survivor X is infected
409    | Conflict             | Survivor X doesn't have enough resources
409    | Conflict             | Resources points is not balanced both sides


## Reports

### Percentage of infected survivors

##### Request

```sh
GET   /reports/infected_survivors
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "data": "X%"
}
```

### Percentage of non-infected survivors

##### Request

```sh
GET   /reports/not_infected_survivors
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "data": "X%"
}
```

### Average Resources By Survivor

##### Request

```sh
GET   /reports/resources_by_survivor
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "averages": {
        "water": 5,
        "food": 7,
        "medication": 1.5,
        "ammunition": 0
    }
}
```

### Points lost because of infected survivors

##### Request

```sh
GET   /reports/lost_infected_points
```

##### Response

```sh
status: 200 ok
```

```sh
Content-Type: "application/json"
```

```sh
Body:
{
    "lost_points": 30
}
```
