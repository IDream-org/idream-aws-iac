pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent  any
    stages {
        stage('Plan') {
            steps {
                sh "pwd;cd environments/${BRANCH_NAME} ; terraform init -force-copy"
                sh "pwd;cd environments/${BRANCH_NAME} ; terraform plan"
                
            }
        }
        stage('Apply') {
            steps {
                sh "pwd;cd environments/${BRANCH_NAME} ; terraform apply -auto-approve"
            }
        }
    }
  }