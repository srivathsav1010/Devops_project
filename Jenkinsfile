pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops_project_image"
        CONTAINER_NAME = "devops_project_container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker rm -f ${CONTAINER_NAME} || true'
                    sh 'docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}'
                }
            }
        }

        stage('Send Email Notification') {
            steps {
                emailext(
                    subject: "Build Status: ${currentBuild.currentResult}",
                    body: "Pipeline ${env.JOB_NAME} finished with status: ${currentBuild.currentResult}\nCheck details here: ${env.BUILD_URL}",
                    to: 'srivathsav1010@gmail.com'
                )
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ SUCCESS: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: "Build was successful!\nVisit: ${BUILD_URL}",
                to: 'srivathsav1010@gmail.com'
            )
        }
        failure {
            emailext(
                subject: "❌ FAILED: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: "Build failed!\nLogs: ${BUILD_URL}",
                to: 'srivathsav1010@gmail.com'
            )
        }
    }
}
