# InsightDevopsProject

# One-Click CI/CD Pipeline

One-click to set-up a working CI/CD piepline using Terraform, Jenkins and AWS EC2.

[Link](#) Presentaion Slides.

<hr/>

## How to install and get it up and running
1. Install terraform
2. Git clone this repo
3. Input your AWS access_key, secret_key, region preffered, key pair ID and path to your-keypair.pem in variables.tf. (Demo purpose only, Do not left them there and push to your repo!)
4. terraform init
5. terraform apply
6. Now you can find the web application at http://Your-web-EC2-ip:8000 and jenkins server at http://Your-jenkins-EC2-ip:8080


The web application repo is at https://github.com/LiyuanWang123/InsightDevopsProject where dockerfile and jenkinsfile are located.


For demo purpose, that repo is fixed. However, if you want to change the repo to your repo, you need to change the repo link to your repo in job "autoBuild"'s configuration on jenkins server, then add your credentials for both github and your image registry. Also in Jenkinsfile, you need to change the registry(mine is dockerhub) link to your image registry and the credential ID to match the Newly added on jenkins server and finally put jenkinsfile into your repo and copy paste the dockerfile to your repo. Then you can try git push new change of your application and see the pipeline performance. 



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
