pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "sindhoorarao310/to-do-app-kubeginners"
        DOCKER_USERNAME = "sindhoorarao310"
        DOCKER_PASSWORD = credentials('DOCKER_SECRET')
        ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
        SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')

    }
    stages {

        stage('Test'){
            steps{
                sh '''
                    /usr/local/bin/aws --version
                    terraform --version
                    kubectl version
                '''
            }
        }
//         stage('Docker') {
//             steps {
//                 sh '''
//                     echo "running the tests ......."
//                     echo "building the docker image ......."
//                     docker build -t "${DOCKER_IMAGE_NAME}" -f ./Dockerfile .
//                     echo "pushing docker image ......."
//                     docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
//                     docker tag "${DOCKER_IMAGE_NAME}" "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
//                     docker push "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
//                     docker push "${DOCKER_IMAGE_NAME}":latest
//                     echo "cleaning up the local images ......."
//                     docker rmi "${DOCKER_IMAGE_NAME}":"$BUILD_NUMBER"
//                     docker rmi "${DOCKER_IMAGE_NAME}":latest
//                 '''
//             }
//         }
//
//         stage('Terraform') {
//             steps {
//                 sh '''
//                  terraform init -auto-approve
//                  terraform plan
//                  terraform apply -auto-approve
//                  /usr/local/bin/aws eks --region us-east-1 update-kubeconfig --name eks-kubeginners
//                 '''
//             }
//         }
//
//         stage('Deploy') {
//             steps {
//                 sh '''
//                     echo "deploying the application ........"
//                     kubectl apply -f kubernetes-deployment.yml
//                     kubectl apply -f kubernetes-service.yml
//                     kubectl get svc eks-kubeginners-service
//                 '''
//             }
//         }
    }
}



