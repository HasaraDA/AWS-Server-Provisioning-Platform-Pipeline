pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION = 'ap-southeast-1'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/HasaraDA/AWS-Server-Provisioning-Platform-Pipeline.git'
            }
        }
        stage('Setup Terraform') {
            steps {
                script {
                    echo "Using terraform.tfvars from the repository."
                }
            }
        }
        stage('Run Terraform') {
            steps {
                script {
                    sh 'terraform init'
                    
                    sh 'terraform validate'
                    
                    sh 'terraform plan'
                    
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Show Outputs') {
            steps {
                script {
                    
                    sh 'terraform output instance_ips'
                }
            }
        }
    }
    post {
        success {
            echo "Servers created successfully."
        }
        failure {
            echo "Server creation failed."
        }
    }
}
