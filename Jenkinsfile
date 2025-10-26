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
                    bat """
                        echo Building Docker Image...
                        docker build -t ${IMAGE_NAME} .
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    bat """
                        echo Stopping existing container if running...
                        docker ps -q -f name=${CONTAINER_NAME} && docker rm -f ${CONTAINER_NAME} || echo No container to remove
                        
                        echo Running new container...
                        docker run -d --name ${CONTAINER_NAME} -p 8081:80 ${IMAGE_NAME}
                    """
                }
            }
        }

        stage('Send Email Notification') {
            steps {
                emailext(
                    subject: "📢 Build Status: ${currentBuild.currentResult}",
                    body: """
                        <h2>Jenkins Pipeline Notification</h2>
                        <p><b>Project:</b> ${env.JOB_NAME}</p>
                        <p><b>Build Number:</b> #${env.BUILD_NUMBER}</p>
                        <p><b>Status:</b> ${currentBuild.currentResult}</p>
                        <p><b>Details:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                    """,
                    mimeType: 'text/html',
                    to: 'srivathsav1010@gmail.com'
                )
            }
        }
    }

    post {
        success {
            emailext(
                subject: "✅ SUCCESS: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: """
                    <h3>✅ Build Successful!</h3>
                    <p>Project: ${JOB_NAME}</p>
                    <p>Build Number: #${BUILD_NUMBER}</p>
                    <p>Visit: <a href="${BUILD_URL}">${BUILD_URL}</a></p>
                """,
                mimeType: 'text/html',
                to: 'srivathsav1010@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "❌ FAILED: ${JOB_NAME} Build #${BUILD_NUMBER}",
                body: """
                    <h3>❌ Build Failed!</h3>
                    <p>Project: ${JOB_NAME}</p>
                    <p>Build Number: #${BUILD_NUMBER}</p>
                    <p>Check Logs: <a href="${BUILD_URL}">${BUILD_URL}</a></p>
                """,
                mimeType: 'text/html',
                to: 'srivathsav1010@gmail.com'
            )
        }
    }
}
