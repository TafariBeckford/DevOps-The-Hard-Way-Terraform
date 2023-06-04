pipeline {

 agent {
  label 'linux-agent'
}
 
  tools {
    terraform 'terraform'
 }

 environment {
    TF_IN_AUTOMATION = 'true'
    TF_CLI_CONFIG_FILE = credentials('tf-creds')
    AWS_ACCOUNT_ID="764450536500"
    AWS_DEFAULT_REGION="us-east-1" 
    URL = "https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
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
        sh 'terraform plan -no-color '
      }
       }
    }

    stage('Apply') {
      steps {
        dir('terraform'){
        sh 'terraform apply -auto-approve -no-color'
      }
       }
    }

    stage('Deploy'){
     when{
          branch 'ecr'
        }
     steps{
         dir('app'){
        script{
            withDockerRegistry(credentialsId: 'ecr:us-east-1:aws-creds', url: 'https://764450536500.dkr.ecr.us-east-1.amazonaws.com') {
                
             def myImage = docker.build('devops-the-hard-way-repo')
             myImage.push('latest')
}
        } 
         
     }
     
     }
      
    }

  }
}