pipeline {

 agent {
  label 'agent-linux-slave'
}

  environment {
    TF_API_TOKEN = credentials('terraform-api-token')
    TF_ORGANIZATION = 'tafari'
    TF_WORKSPACE = 'DevOps-The-Hard-Way-ArgoCD'
    TF_CONFIG_DIR = './terraform'
  }

  stages {
    stage('Checkout') {
      steps {
       checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/TafariBeckford/DevOps-The-Hard-Way-Terraform.git']])
      }
    }
    stage('Initialize') {
      steps {
        dir('terraform'){
        sh 'terraform init'
        }
      }
    }

    stage('Plan') {
      steps {
        dir('terraform'){
        sh 'terraform plan -input=false'
      }
       }
    }

    stage('Apply') {
      steps {
        dir('terraform'){
        sh 'terraform apply -auto-approve -input=false'
      }
       }
    }
  }
}