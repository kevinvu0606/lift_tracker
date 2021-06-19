Live Website: https://fierce-ocean-24208.herokuapp.com/

** Project Aim **
- The aim of this project was to create a web application using the Sinatra Framework with 2 resources/tables being utilized. 
- Of these two resources, one was required to have a full RESTful route with GET, POST, PATCH AND DELETE
- Login/signup functionality was required

** Approach **
I created a web application that tracked metrics for lifts based on user input
- Users would be required to signup/login before using the website
  - user information ( login, first name, surname) would be stored into a Postgres Table
  - user passwords are encrypted/validated via the Ruby Gem Bcrypt
- once logged in the user could select which lift details they wanted more information on
  - based on their session id, they will only be able to view their own lift details
- this would take them to the individual page ( e.g Deadlift )
- Each lift has its own page/table
  - The lifts are recorded here so that we have the full RESTful routes
  - the user can view all records, edit a record, add a record or delete a record

Additionals:
- I used an API( chartkick ) for data visulization to display a graph showing growth of 1 rep maxes

Lessons Learned:
- better planning for the styling of the pages will lead to less clutter + easier managing of class/id's


Functionality not yet implemented:
- Email Validation to ensure a valid email is entered when signing up
- Unique Email Validation to ensure a unique email is used
- Redirect user to login page such that if the user attempts to go directly to a page they cant view anything.