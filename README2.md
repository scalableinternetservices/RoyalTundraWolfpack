# README

# Setup Commands
```
docker-compose build
docker-compose up

In 2nd  terminal: 
  docker-compose run web rake db:create
  docker-compose run web rails db:migrate
```

pw wolfgang

chmod 700 RoyalTundraWolfpack.pem
ssh -i RoyalTundraWolfpack.pem RoyalTundraWolfpack@ec2.cs291.com

# Tsung Instance Setup Commands
```
./launch_instance.sh
ssh -i ~/RoyalTundraWolfpack.pem ec2-user@IP_ADDRESS 
```
IP_ADDRESS should be given when "./launch_instance.sh" is ran

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
