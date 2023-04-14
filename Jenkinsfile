pipeline {

 agent {
  label 'agent-linux-slave'
}

  environment {
    TF_IN_AUTOMATION = 'true'
    TF_CLI_CONFIG_FILE = credentials('tf-creds')
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
  }
}