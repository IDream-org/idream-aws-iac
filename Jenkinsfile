pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent  any
    stages {
        stage('Checkout') {
            steps {
                 script{
                        dir("terraform")
                        {
                            git "https://github.com/IDream-org/idream-aws-iac.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terraform/environments/dev ; terraform init'
                sh "pwd;cd terraform/environments/dev ; terraform plan"
                
            }
        }
        stage('Apply') {
            steps {
                sh 'pwd;cd terraform/environments/dev ; terraform apply -auto-approve'
            }
        }
    }
  }