pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops_project_image"
        CONTAINER_NAME = "devops_project_container"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/srivathsav1010/Devops_project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t %IMAGE_NAME% ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove old container if running
                    bat "docker ps -q -f name=%CONTAINER_NAME% && docker rm -f %CONTAINER_NAME% || echo No container to remove"
                    // Run a new container
                    bat "docker run -d --name %CONTAINER_NAME% -p 8081:80 %IMAGE_NAME%"
                }
            }
        }

        stage('Send Email Notification') {
            steps {
                emailext(
                    subject: "Build Status: ${currentBuild.currentResult}",
                    body: """Pipeline ${env.JOB_NAME} finished with status: ${currentBuild.currentResult}
Check details here: ${env.BUILD_URL}""",
                    to: 'srivathsav1010@gmail.com'
                )
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ SUCCESS: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: """Build was successful!
Visit: ${BUILD_URL}""",
                to: 'srivathsav1010@gmail.com'
            )
        }
        failure {
            emailext(
                subject: "❌ FAILED: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: """Build failed!
Logs: ${BUILD_URL}""",
                to: 'srivathsav1010@gmail.com'
            )
        }
    }
}
