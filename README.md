
# Ruby Top Score Ranking API

It's an application that provides below features 

1. Create Score of given Player
2. Search the score by player names and dates 
3. Retrieve Player score history which contains stats of score ie top score, average score, etc 
  
## Pre Requirements

Ruby 3.0.0

Rails 6.1.4

Database: Postgres


## Getting Started

1. Clone this project
```bash
git clone https://github.com/Gauravbtc/ruby_top_score_api.git
```
2. Go to the project directory 
```bash 
cd ruby_top_score_api
```
3. Install requires RVM for ruby 3.0.0 

4. Rename sample_databse.yml to database.yml and put your database credentials

5. install gems 
```bash 
bundle install
```

6. Create a database and run migrations
```bash 
rails db:create 
rails db:migrate
```
7. Run Rails Server 
```
rails s
```

## API Document 

[Swagger Doc](http//localhost:3000/api-docs/index.html)

## Run Specs 

```bash
bundle exec rails db:migrate -e test

bundle exec rspec
```

## Project Structure
This application has two models 

i) Player: Contain Player information such as name
 
ii) Score: Contain Player score information
  

- ``` Score.by_players(player_names)``` it will retrieve player score information, player names can be pass in an array 
- ``` Score.before_time(date)``` it will retrive score before specfic date 
- ```Score.after_time(date)``` it will retrive score after specific date


## API
It can be divided into two controllers 

- Score Controller 
  - POST {host}//api/v1/scores for it will create socre of player 
  - GET {host}//api/v1/scores/{id} retrive score information 
  - DELETE {host}//api/v1/scores/{id}  Remove score 
  - GET {host}//api/v1/scores?players=player1&before=2021-06-29T20:18:00Z&after=2021-06-29T20:20:20Z&page=1 
    as a players parameters you can pass palyer names, in before and after paramter you need to pass date and in page yoy need to pass page number based on that score will be retived

 - Player Controller 
   - GET {host}//api/v1/player/{id}/history  you need to pass player id 
      based on that player score history will retrieve it contains the player best score, worst score, and avg score stats along with their entire score history 
      
      
## Swagger Document
![swagger](https://user-images.githubusercontent.com/16643699/123958668-49e02b00-d9e8-11eb-995e-6ee7d04a6a97.png)
