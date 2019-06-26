# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.6.3

* System dependencies
exclude Windows

* Configuration
none

* Database creation
  - development

  ```bash
  bundle exec rails db:migrate
  ```
  - production at heroku

  ```bash
  heroku run rails db:migrate
  ```

* Database initialization
  - development

  ```bash
  bundle exec rake house_data:import FILE_PATH=db/data/house_data.csv
  bundle exec rake monthly_energy_logs_data:import FILE_PATH=db/data/dataset_50.csv
  ```
  - production at heroku

  ```bash
  heroku run rake house_data:import FILE_PATH=db/data/house_data.csv
  heroku run rake monthly_energy_logs_data:import FILE_PATH=db/data/dataset_50.csv
  ```

* How to run the test suite

 ```bash
 bundle exec rspec spec/
 ```

* Services (job queues, cache servers, search engines, etc.)
none

* Deployment instructions
  - heroku

  ```bash
  cd EnergyDataSimulationChallenge_ROOT_PATH
  heroku create challengeXYOURNAME
  git remote add heroku https://git.heroku.com/challengeXYOURNAME.git
  git subtree push --prefix=challenge3/webapp/YOURNAME heroku master
  ```

* Demo
https://challenge3yukaina.herokuapp.com/
