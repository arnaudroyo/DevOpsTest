pipeline {
    agent any

    environment {
        IMAGE_NAME = 'my_dockerhub_username/devopstest' // docker image name
        REPO_URL = 'https://github.com/arnaudroyo/DevOpsTest.git' // GitHub url
        VPS_HOST = 'my_vps_ip_address' // VPS IP
        VPS_USER = 'my_vps_user' // SSH username
    }

    triggers {
        cron('H/5 * * * *') // check for git update every 5mn 
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "${REPO_URL}"
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        docker.image("${IMAGE_NAME}").push('latest')
                    }
                }
            }
        }

        stage('Deploy to VPS') {
            steps {
                sshagent(['vps_ssh_credentials']) { // credentials SSH
                    // Connection to VPS et update/restart container
                    sh """
                    ssh -o StrictHostKeyChecking=no ${VPS_USER}@${VPS_HOST} << EOF
                    docker pull ${IMAGE_NAME}:latest
                    docker stop devopstest || true
                    docker rm devopstest || true
                    docker run -d --name devopstest -p 80:8080 ${IMAGE_NAME}:latest
                    EOF
                    """
                }
            }
        }
    }

    post {
        always {
            sh 'docker rmi ${IMAGE_NAME} || true'
        }
    }
}
