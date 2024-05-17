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
                        dir("terragrunt")
                        {
                            git "https://github.com/IDream-org/idream-aws-iac.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd terragrunt/live/dev ; terragrunt run-all init'
                sh "pwd;cd terragrunt/live/dev ; terragrunt run-all plan"
                
            }
        }
        stage('Apply') {
            steps {
                sh 'pwd;cd terragrunt/live/dev ; terragrunt run-all apply -auto-approve'
            }
        }
    }
  }