# Fitness Tracker
A fitness tracker to track the data of the 3 big lifts in powerlifting!
The goal of this project was to create a web application that utilised two resources/tables and have RESTful routes for at least 1 of these resources.


## ⚡ Try it out
https://fierce-ocean-24208.herokuapp.com/

## How to Use
- Make an account through the login
- start tracking your lifts based on the weight and date on which y ou completed them

## Wireframe

![](https://github.com/kevinvu0606/lift_tracker/blob/master/wireframe.png)

## Technologies Used
- Postgres 
- Ruby 
- Sinatra Framework
- Bcrypt
- Axios
- Chartkick

## Project Aim 
- The aim of this project was to create a web application using the Sinatra Framework with 2 resources/tables being utilized. 
- Of these two resources, one was required to have a full RESTful route with GET, POST, PATCH AND DELETE
- Login/signup functionality was required

## Approach 
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

## Additionals:
- I used an API( chartkick ) for data visulization to display a graph showing growth of 1 rep maxes

## essons Learned:
- better planning for the styling of the pages will lead to less clutter + easier managing of class/id's and less conflicts in name


## Additions to be made
- Email Validation to ensure a valid email is entered when signing up
- Unique Email Validation to ensure a unique email is used
- Redirect user to login page such that if the user attempts to go directly to a page they cant view anything.

## 📬 Contact me
- [LinkedIn](https://www.linkedin.com/in/kevin-vu-06/)
- [E-mail](mailto:kevin.vu06@gmail.com)