pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "sindhoorarao310/to-do-app-kubeginners"
        DOCKER_USERNAME = "sindhoorarao310"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')

    }
    stages {

        stage('Docker') {
            steps {
                sh '''
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
                 withAWS(profile:'966185979698_Admin-Account-Access') {
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



