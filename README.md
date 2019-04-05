# InsightDevopsProject

# One-Click CI/CD Pipeline

One-click to set-up a working CI/CD piepline using Terraform, Jenkins and AWS EC2.

[Link](#) Presentaion Slides.

<hr/>

## How to install and get it up and running
For demo purpose, that application repo is fixed. So you can't run it except you have my credentials of github and dockerhub.

However, you can change the application repo to your repo. You need to: 
#### On jenkins server: 
1. Change the repo link to your repo in job "autoBuild"'s configuration 
2. Add your credentials for both github and your image registry
3. Switch the credential to yours in job "autoBuild"'s configuration 
#### On your repo

The web application repo is at https://github.com/LiyuanWang123/InsightDevopsProject where dockerfile and jenkinsfile are located.

1. Get jenkinsfile and dockerfile from the repo
2. In Jenkinsfile, in last step, you need to change the registry(mine is dockerhub) link to your image registry and the credential ID to match the Newly added credential on jenkins server
3. Put jenkinsfile into your repo and the dockerfile to your repo. 

Then you can follow the instructions below:  

1. Install terraform
2. Git clone this repo
3. Input your AWS access_key, secret_key, region preffered, key pair ID and path to your-keypair.pem in variables.tf. (Demo purpose only, Do not left them there and push to your repo!)
4. terraform init
5. terraform apply
6. Now you can find the web application at http://Your-web-EC2-ip:8000 and jenkins server at http://Your-jenkins-EC2-ip:8080








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

Terraform, Jinkins, AWS EC2

## Way to Demo

Run a website with a video playing while pushing code and deploying the change to the website.
