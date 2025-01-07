# Hugging Face on AWS SageMaker

This repository contains infrastructure code using Terraform to deploy Hugging Face models on AWS SageMaker, and Docker configurations to build and push the model images to Docker Hub.

## Table of Contents

- [Introduction](#introduction)
- [Directory Structure](#directory-structure)
- [Setup](#setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project aims to deploy a Hugging Face model on AWS SageMaker using custom images stored on Docker Hub. We use Terraform for infrastructure management and Docker to build and manage the Hugging Face model images.

## Directory Structure

aws/: Contains Terraform code for setting up AWS SageMaker infrastructure.

Docker/: Contains the Dockerfile, Python code, and requirements.txt for the Hugging Face model.

## Setup

### Prerequisites

- Docker
- Terraform
- AWS account with the necessary permissions
- Docker Hub account
- GitLab CI/CD setup

### Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Tafehi/Natural-language-processing.git
   cd Natural-language-processing
   ´´´
2. **Set up Terraform**

   ```bash
    cd aws
    terraform init
    terraform plan
    terraform apply
   ´´´

3. **Build and Push Docker Image**
This will be handled by GitLab CI/CD as per the pipeline configuration.