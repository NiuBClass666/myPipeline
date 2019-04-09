# InsightDevopsProject

# One-Click CI/CD Pipeline

One-click to set-up a working CI/CD piepline using Terraform, Jenkins and AWS EC2.

https://docs.google.com/presentation/d/1Y7OJjvAg6_5S8JksSPESXkSyz5NOZU78CV0Ot6lU90w/edit?usp=sharing (#) Presentaion Slides.

<hr/>

## How to install and get it up and running
For demo purpose, that application repo is fixed. So you can't run it except you have my credentials of github and dockerhub.

However, you can change the application repo to your repo. You need to: 

#### On your repo

The web application repo is at https://github.com/LiyuanWang123/InsightDevopsProject where dockerfile and jenkinsfile are located.

1. Get jenkinsfile and dockerfile from the repo
2. In Jenkinsfile, in last step, you need to change the registry(mine is dockerhub) link to your image registry and the credential ID to match the Newly added credential on jenkins server
3. Put jenkinsfile into your repo and the dockerfile to your repo. 

#### On your Host machine 

1. Install terraform
2. Git clone this repo
3. Input your AWS access_key, secret_key, region preffered, key pair ID and path to your-keypair.pem in variables.tf. (Demo purpose only, Do not left them there and push to your repo!)
4. Change the link in ./Web/local-exec.sh to your repo link
5. terraform init
6. terraform apply

#### On jenkins server(once its online, you can find it on http://Your-jenkins-EC2-ip:8080): 
1. Change the repo link to your repo in job "autoBuild"'s configuration 
2. Add your credentials for both github and your image registry
3. Switch the credential to yours in job "autoBuild"'s configuration 

4. Now you can find the web application at your ELB DNS domain(Find on aws console>EC2>Load Balancer) which can automatically update itself when you commit code to your web application repo.








<hr/>

## Introduction

Today's developers who use repositories like github always face a problem when they try to integrate and deploy the new change becasue there are always reptitive work and long period of waiting for operation teams' feedback. My project is to build a one-click set-up CI/CD pipeline which does build, test and deployment automatically. 

## Architecture

I use Terraform to set up and provision my AWS EC2 instances with Jenkins and Docker. Jenkins does the most job of the pipeline who automatically detect code change in repo, build new image and send it to a registry like dockerhub. At last, I use watchTower on web servers to detect if there is new image pushed to registry, so if it found a new image, it would ask docker to re-build the application container.

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
