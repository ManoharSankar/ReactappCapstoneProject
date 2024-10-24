pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('DOCKER_USERNAME') 
        DOCKERHUB_PASS = credentials('DOCKER_PASS')
        BRANCH_NAME="${env.GIT_BRANCH}"
 
    }

    stages {
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh './build.sh ${BRANCH_NAME}'
                }
            }
        }
        
        stage('Deploy Application') {
            steps {
                script {
                    sh './deploy.sh ${BRANCH_NAME}'
                }
            }
        }
        stage('Monitor Health') {
            steps {
                script {
                    echo "Health check initiated for branch ${env.BRANCH_NAME}"
                    // Add Prometheus/Grafana monitoring steps here if necessary of reactapp
                }
            }
        }
    }
    post {
        always {
            // Clean workspace after the build, regardless of the result
            cleanWs()
        }
        success {
            mail to: 'manoharsankar93@gmail.com',
                 subject: "Build Successful: ${env.JOB_NAME}",
                 body: "The build ${env.BUILD_NUMBER} was successful!"
        }
        failure {
            mail to: 'manoharsankar93@gmail.com',
                 subject: "Build Failed: ${env.JOB_NAME}",
                 body: "The build ${env.BUILD_NUMBER} failed. Please check the logs."
        }
    }
}

