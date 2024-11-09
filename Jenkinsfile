pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "springboot-demo-image-for-pipeline"
        DOCKER_IMAGE_TAG = "latest"
    }

    stages {
        stage('Clone the project') {
            steps {
                script {
                    try {
                        // Clone the project repository
                        git branch: 'master', url: 'https://github.com/arun-ganachari/springboot-demo-pipeline.git'
                    } catch (Exception e) {
                        // Handle the exception (e.g., print error message and fail the build)
                        echo "Error occurred while cloning the repo: ${e.getMessage()}"
                        error "Cloning failed, terminating the pipeline."
                    }
                }
            }
        }

        stage('Build the application') {
            steps {
                script {
                    try {
                        // Build the application using Maven
                        sh 'mvn clean package -DskipTests'
                    } catch (Exception e) {
                        echo "Error during build: ${e.getMessage()}"
                        error "Build failed, terminating the pipeline."
                    }
                }
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    try {
                        // Build Docker image
                        sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                    } catch (Exception e) {
                        echo "Error during Docker image build: ${e.getMessage()}"
                        error "Docker build failed, terminating the pipeline."
                    }
                }
            }
        }

        stage('Run Docker container') {
            steps {
                script {
                    try {
                        // Run Docker container from the built image
                        sh "docker run -d -p 8081:8090 --name ${DOCKER_IMAGE_NAME}_container ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    } catch (Exception e) {
                        echo "Error during Docker container run: ${e.getMessage()}"
                        error "Failed to start Docker container, terminating the pipeline."
                    }
                }
            }
        }

        stage('Test Application') {
            steps {
                script {
                    try {
                        // Test if the application is running (for example, by calling a health check endpoint)
                        sh "curl http://localhost:8081"
                    } catch (Exception e) {
                        echo "Error during application test: ${e.getMessage()}"
                        error "Application health check failed, terminating the pipeline."
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs for more details.'
            // Optionally, send notifications or take other actions on failure
        }
    }
}
