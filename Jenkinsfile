pipeline {
    agent any
 environment {
        DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'chandu2311/mvpnode'
        DOCKERFILE_PATH = 'Dockerfile'


    NEXUS_URL = 'http://34.172.247.216:8081'
        NEXUS_REPO_ID = 'mvpnodejs'
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
      // stage('Install Dependencies') {
      //       steps {
      //           script {
      //               sh "npm install"
      //           }
      //       }
      //   }
      //   stage('Run Tests') {
      //       steps {
      //           script {
      //               sh "npm test"
      //           }
      //       }
      //   }
      //   stage('Build') {
      //               steps {
      //                   script {
      //                       sh "npm run build"
      //                     sh 'tar -czvf dist.tar.gz dist'
              
      //                   }
      //               }
      //           }

      // stage('Deploy to Nexus') {
      //       steps {
      //           script {
      //               def currentVersion = readVersion()

      //               // Deploy to Nexus
      //               sh "curl -v -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} --upload-file dist.tar.gz ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/${currentVersion}/${PACKAGE_NAME}-${currentVersion}.${env.BUILD_ID}.tar.gz"

      //               echo "Artifact deployed to Nexus with version ${currentVersion}"
      //           }
      //       }
      //   }

      

      //   stage('Build and Push Docker Image') {
      //             steps {
      //                 script {

                                         
      //                     dockerImage = docker.build("${env.IMAGE_NAME}:${env.BUILD_ID}", "-f ${env.DOCKERFILE_PATH} .")
      
                  
      //                     docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                              
      //                         dockerImage.push()
      //                     }
      //                 }
      //             }
      //         }
stage('OWASP Dependency-Check Vulnerabilities') {
      steps {
        dependencyCheck additionalArguments: ''' 
                    -o './'
                    -s './'
                    -f 'ALL' 
                    --prettyPrint''', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
        
        dependencyCheckPublisher pattern: 'dependency-check-report.xml'
      }
    }



// }




// }
        
          }
        }

def readVersion() {
    def packageJson = readJSON file: VERSION_FILE
    def version = packageJson.version
    echo "Current version: ${version}"
    return version
}

