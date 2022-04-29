pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "sindhoorarao310/to-do-app-kubeginners"
        DOCKER_USERNAME = "sindhoorarao310"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')
        //ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
       // SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')

    }
    stages {

        stage('Docker') {
            steps {
                sh '''
                    echo "running the tests ......."
                '''
            }
        }

        stage('Terraform') {
            steps {
                sh '''
                 terraform init -force-copy
                 terraform plan
                 terraform apply -auto-approve
                 '''
                 withAws(credentialsId: 'AWS',defaultRegion: 'us-east-1') {
                 sh '''
                 /usr/local/bin/aws eks --region us-east-1 update-kubeconfig --name eks-kubeginners
                '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    echo "deploying the application ........"
                    kubectl apply -f kubernetes-deployment.yml
                    kubectl apply -f kubernetes-service.yml
                    kubectl get svc eks-kubeginners-service
                '''
            }
        }
    }
}



