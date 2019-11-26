# README

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

# Setup Commands
1. Clone Git repo
2. Run following commands inside project folder to start up the docker container.
```
docker-compose build
docker-compose up
```
3. Open a 2nd terminal and run the following commands to create and migrate the DB.
```
  docker-compose run web rake db:create
  docker-compose run web rails db:migrate
```
4. Seed DB
```

```

pw wolfgang
chmod 700 RoyalTundraWolfpack.pem
ssh -i RoyalTundraWolfpack.pem RoyalTundraWolfpack@ec2.cs291.com


# AWS Deployment Instruction
1. Download .pem file into local directory. (Do not put into push this .pem file to GitHub)
2. SSH into the EC2 instance.
```
ssh -i RoyalTundraWolfpack.pem RoyalTundraWolfpack@ec2.cs291.com
```
	- if get permission issues with .pem file, run
		```
		chmod 700 RoyalTundraWolfpack.pem
		```
3. Clone GitHub repo into EB instance via HTTPS and cd into that directory.
```
git clone https://github.com/scalableinternetservices/RoyalTundraWolfpack.git
cd PROJECTNAME
``` 
4. Configure EB instance - do once for each copy of repo.
```
eb init --keyname $(whoami) \
  --platform "64bit Amazon Linux 2018.03 v2.11.0 running Ruby 2.6 (Puma)" \
  --region us-west-2 PROJECTNAME
```
5. Create deployment (~10 min to deploy).
```
eb create --envvars SECRET_KEY_BASE=BADSECRET \
  -db.engine postgres -db.i db.t3.micro -db.user u \
  -i t3.micro --single YOURNAME
```
6. Verify deployment - make sure status is READY and health is GREEN
```
eb status
```
7. Check out deployed app at CNAME given in eb status output.
8. To update application, run
```
eb deploy
```
9. To view logs
```
eb logs | less -R
```
10. To SSH into app server
```
eb ssh -i "ssh -i ~/$(whoami).pem"
```
11. To cleanup
```
eb terminate
```


# Tsung Instance Setup Commands
1. Log into ec2 instance and run tsung script. If permission issues, run chmod first.
```
chmod 700 launch_instance.sh
./launch_instance.sh
```
	- A dashboard URL will be given that you cannot access until you start tsung.
2. SSH into the tsung ec2 instance.
```
ssh -i ~/RoyalTundraWolfpack.pem ec2-user@IP_ADDRESS 
```
	- IP_ADDRESS should be given when "./launch_instance.sh" is ran
	- You can also run the ssh command given.
3. Edit the simple.xml file with whatever tsung commands you want to test.
4. Start tsung with the following command
```
tsung -kf simple.xml start
```
	- You will now be able to access the dashboard URL given in the output of running ./launch_instance from step 1.
5. To save new tsung logs to local directory (which you should since tsung will delete the files if you terminate the instance), run the following from the root local directory of the Git repo (same level as .pem file).
```
rsync -auv -e "ssh -i RoyalTundraWolfpack.pem" ec2-user@54.245.191.171:.tsung/log/* tsung_logs/
```
	- To update your logs, just re-run the command to copy over any updated logs.
	- Rename the log directories after tsung logs the run
