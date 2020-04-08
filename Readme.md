#### Readme.md

Please follow the next steps to setup the app:

1. Clone the repo in your local machine
2. In the project directory run: `bundle install` to install all gems
3. Run: `rake create_tables` to create all the tables
4. Run: `rake populate_days` to fill days table
5. Run: `rackup -Ilib config.ru` to start the Rack server


Please follow the next steps to setup the tests:

1. Clone the repo in your local machine
2. In the project directory run: `bundle install` to install all gems
3. Run: `rake create_test_tables` to create all the tables
4. Run: `rspec` to run all specs


###API Endpoints

##Movies

`GET /api/movies`

Params: `day` a day of the week.

Example:

GET `localhost:9292/api/movies?day=friday`

Response:
```
  [
      {
          "id": 1,
          "title": "Rambo",
          "description": "abc",
          "image_url": "rambo 3",
          "day": "friday"
      },
      {
          "id": 2,
          "title": "Avatar",
          "description": "fiction",
          "image_url": "avatar",
          "day": "friday"
      }
  ]
```



`POST /api/movies`

Params:
  - title:String (mandatory)
  - description:String (mandatory)
  - image_url:String (optional)
  - days:Array (mandatory)

Example:

POST `localhost:9292/api/movies`

Params
```
  {
    "title": "Rambo",
    "description": "action",
    "image_url": "rambo",
    "days": ["monday", "friday"]
  }
```

Response:
Status: `201`
```
  {
    "id": 1,
    "title": "Rambo",
    "description": "action",
    "image_url": "rambo",
    "days": [
      "monday",
      "friday"
    ]
  }
```


##Reservations

`POST /api/reservations`

Params:
  - movie_id:Integer (mandatory)
  - date:String (mandatory)

Example:

POST `localhost:9292/api/reservations`

Params:
```
  {
    "movie_id": 2,
    "date": "2020-04-10"
  }

```

Response:
```
  {
      "message": "Your reservation has been created successfully.",
      "movie_name": "Avatar"
  }
```


`GET /api/reservations`

Params: `day` a day of the week.

Example:

GET `localhost:9292/api/movies?day=friday`

Response:
```
  [
      {
          "id": 1,
          "title": "Rambo",
          "description": "abc",
          "image_url": "rambo 3",
          "day": "friday"
      },
      {
          "id": 2,
          "title": "Avatar",
          "description": "fiction",
          "image_url": "avatar",
          "day": "friday"
      }
  ]
```
