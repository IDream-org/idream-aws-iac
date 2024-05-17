pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        BRANCH                = GIT_BRANCH.split('/')[1]
    }

    agent  any
    stages {
        stage('Plan') {
            steps {
                sh "pwd;cd environments/${BRANCH} ; terraform init -force-copy"
                sh "pwd;cd environments/${BRANCH} ; terraform plan"
                
            }
        }
        stage('Apply') {
            steps {
                sh "pwd;cd environments/${BRANCH} ; terraform apply -auto-approve"
            }
        }
    }
  }