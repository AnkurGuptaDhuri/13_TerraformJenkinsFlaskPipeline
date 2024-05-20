pipeline {
    agent any
    tools{
        terraform 'terraform'
    }
    
    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
    }

    stages {
        stage('Stage1: GitHub Checkout') {
            steps {
                echo 'Checkout GitHub'
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/AnkurGuptaDhuri/13_TerraformJenkinsFlaskPipeline.git']])
            }
        }
        stage('Stage2: Terraform_Init') {
            steps {
                echo 'Stage2: go to the folder and terraform init'
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'Student', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    // some block
                    sh 'cd ./infra && terraform init'
                }
            }
        }
        stage('Stage3: Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'Student', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'cd ./infra && terraform plan'
                        }
                    }    
                }
            }
        }
        stage('Stage4: Terraform Apply') {
            steps {
                 script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'Student', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'cd ./infra && terraform apply -auto-approve'
                        }
                    }    
                }
                
            }
        }
    }
}
