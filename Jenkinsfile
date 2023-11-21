pipeline {
    agent any
 environment {
        DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'chandu2311/mvpnode'
        DOCKERFILE_PATH = 'Dockerfile'


    NEXUS_URL = 'http://34.172.247.216:8081/repository/mvp-nodejs/'
        NEXUS_REPO_ID = 'mvp-nodejs'
        NEXUS_USERNAME = 'admin'
        NEXUS_PASSWORD = 'admin'

        // Define artifact information
        PACKAGE_NAME = 'mvp-nodejs'
        VERSION_FILE = 'package.json'
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
      //   stage('Run Tests') {
      //       steps {
      //           script {
      //               sh "npm test"
      //           }
      //       }
      //   }
        stage('Build') {
                    steps {
                        script {
                            sh "npm run build"
                           def currentVersion = readVersion()
                    def newVersion = incrementVersion(currentVersion)
                    writeVersion(newVersion)
                        }
                    }
                }

      stage('Deploy to Nexus') {
            steps {
                script {
                    def currentVersion = readVersion()

                    // Deploy to Nexus
                    sh "curl -v -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} --upload-file dist/${PACKAGE_NAME}-${currentVersion}.tgz ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/${currentVersion}/${PACKAGE_NAME}-${currentVersion}.tgz"

                    echo "Artifact deployed to Nexus with version ${currentVersion}"
                }
            }
        }

//       stage('Push Artifact') {
//                     steps {
//                         script {
//                            withCredentials([string(credentialsId: 'AzureDevopsPAT', variable: 'AzureDevopsPAT')]) {
                            
//                                sh "echo ${AzureDevopsPAT} | az devops login --organization https://dev.azure.com/manjunathnayak/"
//                            //def currentVersion = sh(script: "az artifacts universal show-version --feed https://dev.azure.com/manjunathnayak --name node-mvp-dev --version '*' --query '[0].versions[0]' -o tsv", returnStdout: true).trim()

// def artifactVersion = sh(script: 'az artifacts package show --feed https://dev.azure.com/manjunathnaya --name node-mvp-dev --version "*" --query version --output tsv', returnStdout: true).trim()

//                              sh "echo ${artifactVersion}"
//                              sh "echo $artifactVersion "

//                             //sh "echo ${AzureDevopsPAT} | az devops login --organization https://dev.azure.com/manjunathnayak/"
//                             //sh "az artifacts universal publish --organization 'https://dev.azure.com/manjunathnayak/' --project='Node-MVP' --scope 'project' --feed 'MVP-NODEJS-dev' --name 'node-mvp-dev' --version 0.0.2 --description 'Welcome to Universal Packages' --path /var/lib/jenkins/workspace/Nodejs-pipeline_develop/dist/"
//                            }
//                         }
//                     }
//                 }
      

        // stage('Build and Push Docker Image') {
        //           steps {
        //               script {

                                         
        //                   dockerImage = docker.build("${env.IMAGE_NAME}:${env.BUILD_ID}", "-f ${env.DOCKERFILE_PATH} .")
      
                  
        //                   docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                              
        //                       dockerImage.push()
        //                   }
        //               }
        //           }
        //       }

        
          }
        }

def readVersion() {
    def packageJson = readJSON file: VERSION_FILE
    def version = packageJson.version
    echo "Current version: ${version}"
    return version
}

def writeVersion(newVersion) {
    script {
        // Update package.json with the new version
        sh "npm version ${newVersion} --no-git-tag-version"
    }
    echo "Version updated to: ${newVersion}"
}

def incrementVersion(version) {
    def parts = version.tokenize('.')
    def lastPart = parts[-1] as int
    parts[-1] = (lastPart + 1).toString()
    return parts.join('.')
}
