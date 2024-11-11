pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "springboot-demo-image-for-pipeline"
        DOCKER_IMAGE_TAG = "latest"
        DOCKER_CONTAINER_NAME = "${DOCKER_IMAGE_NAME}_container"
    }

    stages {
        stage('Clone the project') {
            steps {
                script {
                    try {
                        // Clone the project repository
                        git branch: 'master', url: 'https://github.com/arun-ganachari/springboot-demo-pipeline.git'
                    } catch (Exception e) {
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
                        bat 'mvn clean package -DskipTests'
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
                        bat "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
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
                        bat "docker run -d -p 8081:8090 --name ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    } catch (Exception e) {
                        echo "Error during Docker container run: ${e.getMessage()}"
                        error "Failed to start Docker container, terminating the pipeline."
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
            }
        }
}
