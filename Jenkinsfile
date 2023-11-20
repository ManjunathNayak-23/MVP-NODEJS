pipeline {
    agent any
 environment {
        DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'chandu2311/mvpnode'
        DOCKERFILE_PATH = 'Dockerfile'
    }
  
 triggers {
    pollSCM('* * * * *') // Enabling being build on Push
  }
    stages{
      stage('Install Dependencies') {
            steps {
                script {
                    sh "npm install"
                }
            }
        }
        // stage('Run Tests') {
        //     steps {
        //         script {
        //             sh "npm test"
        //         }
        //     }
        // }
        stage('Build') {
                    steps {
                        script {
                            sh "npm run build"
                        }
                    }
                }
      

        stage('Build and Push Docker Image') {
                  steps {
                      script {
//withCredentials([string(credentialsId: 'dockerusername', variable: 'username'), string(credentialsId: 'dockerpassword', variable: 'password')]) {

//                          sh "docker build -t ${env.IMAGE_NAME}."
//                          sh "docker login -u ${username} -p ${password}"
// }

                      
                   
                          dockerImage = docker.build("${env.IMAGE_NAME}", "-f ${env.DOCKERFILE_PATH} .")
      
                  
                          docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                              // Push the Docker image to Docker Hub
                              dockerImage.push()
                          }
                      }
                  }
              }
          }
        }
