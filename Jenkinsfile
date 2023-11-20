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
        stage('Run Tests') {
            steps {
                script {
                    sh "npm test"
                }
            }
        }
        stage('Build') {
                    steps {
                        script {
                            sh "npm run build"
                        }
                    }
                }

      stage('Push Artifact') {
                    steps {
                        script {
                          sh "echo 'AzureDevopsPAT'"
                          sh "AzureDevopsPAT"
                            sh "echo 'AzureDevopsPAT' | az devops login --organization https://dev.azure.com/manjunathnayak/"
                            sh "az artifacts universal publish --organization https://dev.azure.com/manjunathnayak/ --project= Node-MVP --scope project --feed MVP-NODEJS-dev --name Node-mvp-dev --version 0.0.1 --description "Welcome to Universal Packages" --path /var/lib/jenkins/workspace/Nodejs-pipeline_develop/dist/"
                        }
                    }
                }
      

        stage('Build and Push Docker Image') {
                  steps {
                      script {

                                         
                          dockerImage = docker.build("${env.IMAGE_NAME}:${env.BUILD_ID}", "-f ${env.DOCKERFILE_PATH} .")
      
                  
                          docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                              
                              dockerImage.push()
                          }
                      }
                  }
              }

        
          }
        }
