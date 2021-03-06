# User REST API (Level 2) - Language Agnostic

Create a small REST API to handle users.

Limits:

- This challenge should take **max 3-5 hours** to complete.
- You have **max 3 days** to submit your code.

# Requirements:

1. Create an HTTP server that listens on `:9001`.

1. Create a `POST /users` route that creates a user (signup).

   Example request:

   ```bash
   curl -X POST -H 'Content-Type: application/json' -d '<JSON payload below>' http://localhost:9001/users
   ```

   ```js
   {
     "email": "ace@base.se", // required, email format
     "password": "open1234" // required, min 8 chars
   }
   ```

   **NOTE: Fields should be validated as per the comments above!**

   Example response:

   ```js
   {
     "id": 1000,
     "email": "ace@base.se",
     "created_at": "2020-09-15T19:56:10+09:00",
     "updated_at": null
   }
   ```

1. Create a `POST /login` route that performs a user login (verifies a user's password) and returns an access token.

   The token is an MD5 hash of some random value, e.g. `418638191e2b6c1d5ae24b471062dc03`.

   The token should be stored in the database in the same table as the user.

   Example request:

   ```bash
   curl -X POST -H 'Content-Type: application/json' -d '<JSON payload below>' http://localhost:9001/login
   ```

   ```js
   {
     "email": "ace@base.se", // required, email format
     "password": "open1234" // required, min 8 chars
   }
   ```

   **NOTE: Fields should be validated as per the comments above!**

   Example response:

   ```js
   {
     "token": "418638191e2b6c1d5ae24b471062dc03"
   }
   ```

1. Create a `GET /secret` route that returns a secret string to a logged in user.

   The token must be passed as this HTTP header: `Authorization: Bearer <token>`

   The secret string is always this value: `All your base are belong to us`

   Example request:

   ```bash
   curl -X GET \
     -H 'Content-Type: application/json' \
     -H 'Authorization: Bearer <token>' \
     http://localhost:9001/secret`
   ```

   Example response:

   ```js
   {
     "user_id": 1000, // User id of token owner!
     "secret": "All your base are belong to us"
   }
   ```

   Example error response:

   Calling this endpoint without a token (or a bad token) should return the following error:

   ```js
   {
     "error":  "token invalid"
   }
   ```

1. Create a `PATCH /users/{id}` route updates user with id `{id}`.

   A user should be able to update one or more fields in a single call.

   Example request:

   ```bash
   curl -X PATCH \
     -H 'Content-Type: application/json' \
     -d '<JSON payload below>' \
     http://localhost:9001/users/1000`
   ```

   ```js
   {
     "email": "base@base.se", // optional, email format
     "password": "close1234" // optional, min 8 chars
   }
   ```

   **NOTE: Fields are optional but should still be validated if present as per the comments.**

   Example response:

   ```js
   {
     "id": 1000,
     "email": "base@base.se",
     "created_at": "2020-09-15T19:56:10+09:00",
     "updated_at": "2020-09-15T20:00:30+09:00" // Set with each update!
   }
   ```

1. Your server must accept the following ENV vars:

   ```bash
   HOST=:9001        # bind to port 9001 on all IPs.
   DB_HOST=localhost # connect to postgres on this host
   DB_USER=postgres  # postgres user
   DB_PASS=example   # postgres password
   DB_NAME=userapi   # database schema name
   ```

1. Validation errors should be returned as with follows:

   Example error response:

   ```js
   {
     "error": "validation error: age" // Age not between 18-130
   }
   ```

1. Store users and tokens in PostgreSQL.

   Use the provided `docker-compose.yml` to start a local Postgres server (v11).

   Create a database named `userapi`.

   Create a table as follows:

   ```sql
   CREATE TABLE users (
     id BIGSERIAL PRIMARY KEY,
     ...
   )
   ```

   It's up to you to decide what data types to use.

   **NOTE: Remember to create indexes on the columns that should have them!**

1. Create a `Dockerfile` that builds your server.

   We've provided an example `Dockerfile` for you to draw inspiration from.

   Note that your build _must be reproducable_ by us.

   **We will build and run your API server as follows:**

   1. Uncomment the lines in `docker-compose.yml`
   1. Run `docker-compose build`
   1. Run `docker-compose up`
   1. Run our internal automated test suite against your server which should now be listening on `:9001`

1. You can use _any_ of the following languages to implement your API server:

   - Golang
   - JavaScript / TypeScript
   - Ruby
   - Python
   - Java
   - Scala
   - C#
   - C++
   - PHP
   - Rust

# Bonus Points! (If you want to impress us and have time to spare!)

You will score extra points for the following things:

1. `PATCH /users/{id}` should be restricted to logged in users (i.e. require a token same as the `GET /secret` route) and should only allow a user to update their own account!

1. `POST /login` should return a token _that expires after 3 seconds_.

   Calling an endpoint with an expired token should return the following error:

   ```js
   {
     "error":  "token expired"
   }
   ```

1. Write a nice e2e test suite!

# Important Notes

- Be sure to drop and recreate your entire database _each time you start your API server_.

- The password must be _stored securely_ following industry best practices.

- Avoid using an ORM library or framework if possible.

- You're _not required_ to provide tests, but if you do you'll definitely score extra points.

# How To Submit Your Code

1. Create a feature branch named `challenge` and submit your code as a PR.

   You can still make changes to your code after you've submitted your PR, but generally our reviewers will be going through your submission within hours.

# Grading & What To Expect

1. We will grade you on code clarity, naming, structure, program size and correctness.

   Our own internal reference solution is written in Golang and addresses all points (including bonus points) in about 420 LOC total. This includes comments, good formatting, spacing etc.

   Please try to keep your submission as small as possible and remember to stay true to the principles of _KISS_ and _YAGNI_!

   **IMPORTANT: For this challange you will only be informed if you pass or not. We will NOT provide any additional feedback, so please do not ask for it!**

   **Good Luck >:)**
