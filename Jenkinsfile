pipeline {
  agent any

  environment {
    AWS_REGION     = 'ap-south-1'
    AWS_ACCOUNT_ID = '766363046630'
    ECR_REPO       = 'devops-dashboard'
    IMAGE_NAME     = 'devops-dashboard'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/2021wa15539-droid/devops-dashboard.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        bat "docker build -t %IMAGE_NAME%:latest -f docker/Dockerfile ."
      }
    }

    stage('Push to ECR') {
      steps {
        withAWS(region: "${AWS_REGION}", credentials: 'aws-creds') {
          bat """
            aws ecr get-login-password --region %AWS_REGION% ^
              | docker login --username AWS --password-stdin %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com

            docker tag %IMAGE_NAME%:latest %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO%:latest
            docker push %AWS_ACCOUNT_ID%.dkr.ecr.%AWS_REGION%.amazonaws.com/%ECR_REPO%:latest
          """
        }
      }
    }

    stage('Deploy to EKS') {
      steps {
        withAWS(region: "${AWS_REGION}", credentials: 'aws-creds') {
          bat """
            aws eks --region %AWS_REGION% update-kubeconfig --name devops-dashboard-cluster

            kubectl apply -f k8s/deployment.yaml
          """
        }
      }
    }
  }
}
