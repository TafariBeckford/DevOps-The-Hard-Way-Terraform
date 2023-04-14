pipeline {

 agent {
  label 'agent-linux-default'
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
        sh 'terraform init -backend-config="address=https://app.terraform.io" -backend-config="organization=${TF_ORGANIZATION}" -backend-config="workspaces=${TF_WORKSPACE}" ${TF_CONFIG_DIR}'
      }
    }

    stage('Plan') {
      steps {
        sh 'terraform plan -input=false ${TF_CONFIG_DIR}'
      }
    }

    stage('Apply') {
      steps {
        sh 'terraform apply -auto-approve -input=false ${TF_CONFIG_DIR}'
      }
    }
  }
}