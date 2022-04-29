pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "sindhoorarao310/to-do-app-kubeginners:v2"
        DOCKER_USERNAME = "sindhoorarao310"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')
    }
    stages {
        stage('Docker') {
            steps {
                sh '''
                    echo "running the tests ......."
                    echo "building the docker image ......."
                    docker build -t "${DOCKER_IMAGE_NAME}" -f ./Dockerfile .
                    echo "pushing docker image ......."
                    docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                    docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker push "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker push "${DOCKER_IMAGE_NAME}":latest
                    echo "cleaning up the local images ......."
                    docker rmi "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
                    docker rmi "${DOCKER_IMAGE_NAME}":latest
                '''
            }
        }

        stage('Terraform') {
            steps {
                sh '''
                 terraform init
                 terraform plan
                 terraform apply -auto-approve
                 aws eks --region us-east-1 update-kubeconfig --name eks-kubeginners
                '''
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



