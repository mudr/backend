# IronPics API

API For THE IRON YARD hackathon - mUdr - an uplifting app

## General Rules
User accounts require a username, email, password, avatar, and mood. Email must contain a "@" and "." for successful registration.

### Authorization

All authorized requests unless otherwise mentioned require an "X-Auth-Token" header to be present. Users are assigned an Auth Token during account creation.

### Errors

Any request that fails to be processed will contain an "errors" key in the returned JSON describing the problem.

## Routes

#### POST /sign_up

*This route is for managing registration of new users.*

Params:
* username: string
* email: string
* password: string
* mood: integer
* avatar: attached_file


Returns 201 Created on Success and 422 Unprocessable Entity in case of failure.

**Request**
`...
{
	"username": "Bob",
	"email:" "Bob@bob.bob",
	"password": "password"
	"mood": 1
	"avatar": "attached_file"
}
...`

**Response**
`...
{
  "user": "boingboing",
  "avatar": "amazon S3 url",
  "id": 12,
  "email": "email@email.com",
  "points": 0,
  "mood": 1,
  "auth_token": "authtoken string"
}
...`


#### POST /login

*This route is for logging in created users.*

Params:
* username:string

Returns 200 OK on Success and 401 Unauthorized in case of failure.

**Request**
`...
{
	"username": "Bob"
	"mood": 1
	"password": "password"
}
...`

** Response **
`...
{
  "user": {
    "username": "boingboing",
    "auth_token": "auth token"
  }
}
...`

#### GET index

*This route is for showing all posts. Renders username, title, and post_id in an array.*

Returns 200 OK on Success

#### POST /posts/create

*This route is for creating new posts. Note: only users with a sad mood may make posts.*

**Request**
`...
{
	"title": "Life is hard"
	"content": "I have to do stuff. Don't amke me do stuff"
}
...`

** Response **
`...
{
  "post": "life is hard",
  "post_content": "I have to do stuff. Don't make me do stuff.",
  "post_mood": 1,
  "active": true
}
...`

Returns 200 OK on Success

#### POST /post/:id

*This route is for creating an uplifting comment to cheer up the poster. The best comment can be selected as a Top Comment. Comment selected as Top Comment will give the commentor a point.*

**Request**
`...
{
	"content": "Find the joy in doing stuff"
}
...`

** Response **
`...
{
  "post": "life is hard",
  "post_content": "I have to do stuff. Don't make me do stuff.",
  "post_mood": 1,
  "active": true,
  "point_given": false,
  "comments": [
    {
      "id": 25,
      "content": "Do some jumping jacks!",
      "user_id": 12,
      "post_id": 15,
      "mood_at_time": 1,
      "top_comment": false,
      "bad_comment": false,
      "created_at": "2016-04-17T16:32:54.200Z",
      "updated_at": "2016-04-17T16:32:54.200Z"
    },
    {
      "id": 26,
      "content": "Find the joy in doing stuff",
      "user_id": 12,
      "post_id": 15,
      "mood_at_time": 1,
      "top_comment": false,
      "bad_comment": false,
      "created_at": "2016-04-17T16:33:44.069Z",
      "updated_at": "2016-04-17T16:33:44.069Z"
    }
  ]
}
...`

Returns 200 OK on success.


#### PATCH /comment/:id/choose_top_comment

*This route is to choose the best uplifting comment. Only one comment can be chosen as the top comment. Once a comment is chosen, a point is given to the comment poster, point_given is set to true, and active is set to false.*

Params:
* Comment ID: integer - this comes from the url (:id)

Returns 201 Created on success and 422 Unprocessable Entity on failure.

**Request**
`...
	/comment/26/choose_top_comment
...`

**Response**
`...
{
  "post": "life is hard",
  "post_content": "I have to do stuff. Don't make me do stuff.",
  "post_mood": 1,
  "active": false,
  "point_given": true,
  "comments": [
    {
      "id": 25,
      "content": "Do some jumping jacks!",
      "user_id": 12,
      "post_id": 15,
      "mood_at_time": 1,
      "top_comment": false,
      "bad_comment": false,
      "created_at": "2016-04-17T16:33:14.276Z",
      "updated_at": "2016-04-17T16:33:14.276Z"
    },
    {
      "id": 26,
      "content": "Find the joy in doing stuff",
      "user_id": 12,
      "post_id": 15,
      "mood_at_time": 1,
      "top_comment": true,
      "bad_comment": false,
      "created_at": "2016-04-17T16:33:44.069Z",
      "updated_at": "2016-04-17T16:39:52.912Z"
    }
  ]
}
...`

#### PATCH /comment/:id/choose_bad_comment

*This route is to choose Bad Comments. These are comments that make the user feel worse and will be deleted from the database and the commentor will lose a point. If the user's points drop below -3, the user will become inactive.*

Params:
* Comment ID: integer - this comes from the url (:id)

Returns 202 Accepted on Success and 401 Unauthorized in case of failure.


