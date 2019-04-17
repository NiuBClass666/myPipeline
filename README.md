# InsightDevopsProject

# One-Click CI/CD Pipeline with Blue/Green Deployment Strategy

One-click to set-up a working CI/CD piepline using Terraform, Jenkins and AWS EC2.

https://docs.google.com/presentation/d/1Y7OJjvAg6_5S8JksSPESXkSyz5NOZU78CV0Ot6lU90w/edit?usp=sharing (#) Presentaion Slides.

<hr/>

## Introduction

Today's developers who use repositories like github always face a problem when they try to integrate and deploy the new change becasue there are always reptitive work and long period of waiting for operation teams' feedback. My project is to build a one-click set-up CI/CD pipeline which does build, test and deployment automatically. 

## Architecture
I have 2 different architectures due to different deployment strategies.

1. watchTower Deployment with 2 seconds downtime (master branch)
I used Terraform to set up and provisioned my AWS EC2 instances with Jenkins and Docker. Jenkins does the most job of the pipeline who automatically detects code change in repo, builds new image and pushed it to a registry like dockerhub. At last, I used a tool called watchTower on web servers to detect if there is a new image pushed to a registry. So if there was one, it would ask docker to re-build the application container.

2. Blue/Green Deployment with 0 downtime. (blueGreen branch)
The first part which involves terraform and jenkins is the same as the first archetecture. The difference is that instead of ussing the tool watchTower, a new job is added to the Jenkins server. Once Jenkins pushes the latest image to a registry, this new job executes some terraform scripts to set up and provision a new group of EC2 instances as green servers. Then we will have a group of web servers which carry the older application (blue) and green web servers which carry the latest application. 
At last, we can re-route the user traffic from blue to green by using AWS route53 weighted routing policy. There will not be any downtime because user will either go to blue or green servers while we are re-routing traffic. Finally all users will go to green servers with the latest application. 


## How to install and get it up and running
For demo purpose, that application repo is fixed. So you can't run it except you have my credentials of github and dockerhub.

However, you can change the application repo to your repo. You need to: 

The web application repo is at https://github.com/LiyuanWang123/InsightDevopsProject where dockerfile and jenkinsfile are 
located.

#### Rebuild jenkins image
1. Git clone this myPipeline repo
2. Go to JenkinsImage folder 
3. Input your AWS access_key, secret_key, region preffered, key pair ID and path to your-keypair.pem in variables.tf. (Demo purpose only, Do not left them there and push to your repo!)
4. Save and use docker (you need install docker first) to do docker image build -t your-dockerhub/your-jenkins-image .
5. Push this image to your jenkins image registry(dockerhub)

#### On your web application repo

1. Get jenkinsfile and dockerfile from the web application repo
2. In Jenkinsfile, in last step section, you need to change the registry(mine is dockerhub) link to your image registry and the credential ID to match the Newly added credential on jenkins server
3. Put jenkinsfile into your web application repo and the dockerfile to your web application repo. 

#### On your Host machine

1. Install terraform
2. Go to the folder where you store this myPipeline repo
3. Change the liyuansdockerhub/jenkins in ./Jenkins/local-exec2.sh to your dockerhub-account/jenkins-image-name which you just built.
4. Input your AWS access_key, secret_key, region preffered, key pair ID and path to your-keypair.pem in variables.tf. (Demo purpose only, Do not left them there and push to your repo!)
5. Change the link in ./Web/local-exec.sh to your web application repo link
6. terraform init
7. terraform apply

#### On jenkins server(once its online, you can find it on http://Your-jenkins-EC2-ip:8080): 
1. Change the repo link to your web application repo in job "autoBuild"'s configuration 
2. Add your credentials for both github and your image registry
3. Switch the credential to yours in job "autoBuild"'s configuration 

4. Now you can find your web application at Green ELB DNS domain and Blue ELB DNS domain. Terminate either one group(blue or green) of EC2 instances. When you commit new code to your web application repo, that group will be built up again with the latest version of your application. Therefore, you can choose either keep or destroy the servers with older version depending on whether the latest ones work properly. Just remember to re-route your user traffic to ELB DNS domain of the group you chose to keep before destroy the other one, so there won't be any downtime.  







<hr/>



## Engineering challenges

1.Automation of Jenkins configuration

2.Terraform Provision EC2 Instances

3.Minimize downtime during deployment

## Trade-offs


## Business Value 

Speed up development cycles, 0 downtime.

## MVP

One-click to set-up a working CI/CD piepline using Terraform, Jenkins and AWS EC2.

test

## Tech Stack

Terraform, Jinkins, AWS EC2, watchTower

## Way to Demo

Run a website with a data science fellow's flask appllication while pushing code and deploying the change to the website.
