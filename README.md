
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

