pipeline {

 agent {
  label 'agent-linux-slave'
}
 
  tools {
    terraform 'terraform'
 }

  environment {
    TF_IN_AUTOMATION = 'true'
    TF_CLI_CONFIG_FILE = credentials('tf-creds')
    DOCKER_REGISTRY = "764450536500.dkr.ecr.us-east-1.amazonaws.com"
    DOCKER_REPO_NAME = "devops-the-hard-way-repo"
    DOCKER_IMAGE_TAG = "latest"
  }

  stages {
    stage('Checkout') {
      steps {
       checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/TafariBeckford/DevOps-The-Hard-Way-Terraform.git']])
      }
    }
    stage('Initialize') {
      steps {
        dir('terraform'){
        sh 'terraform init -no-color'
        }
      }
    }

    stage('Plan') {
      steps {
        dir('terraform'){
        sh 'terraform plan -no-color -input=false'
      }
       }
    }

    stage('Apply') {
      steps {
        dir('terraform'){
        sh 'terraform apply -auto-approve -no-color -input=false'
      }
       }
    }
      stage('Build Docker Image') {
         when{
          branch 'ecr'
        }
      steps {
        dir('app'){
         sh 'docker build -t $DOCKER_REGISTRY/$DOCKER_REPO_NAME:$DOCKER_IMAGE_TAG .'
      }
       }
    }
    
      stage('Push Docker Image') {
        when{
          branch 'ecr'
        }
      steps {
        dir('app'){
         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                    sh "aws ecr get-login-password | docker login --username AWS --password-stdin $DOCKER_REGISTRY"
                    sh "docker push $DOCKER_REGISTRY/$DOCKER_REPO_NAME:$DOCKER_IMAGE_TAG"
      }
       }
    }

  }
}
}
