@Library('sharedLibrary') _
pipeline {
    agent any
 environment {
        DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
        IMAGE_NAME = 'chandu2311/mvpnode'
        DOCKERFILE_PATH = 'Dockerfile'
        // NEXUS_URL = 'nexusurl'
        // NEXUS_REPO_ID = 'nexusrepo'
        // NEXUS_USERNAME = 'nexususername'
        // NEXUS_PASSWORD = 'nexuspassword'
        // Define artifact information
        PACKAGE_NAME = 'mvp-nodejs'
        VERSION_FILE = 'package.json'

    }
  
 // triggers {
 //    pollSCM('* * * * *') // Enabling being build on Push
 //  }

    stages{
    //   stage('Build and Test') {
    //         steps {
             
    //              script {
    //                   nodejs.installDependency()
    //                   nodejs.test()
    //                   nodejs.build()
                
               
    //              }
    //         }
    //     }

    //   stage('SonarQube analysis') {
    // environment {
    //   SCANNER_HOME = tool 'Sonar-scanner'
    // }
    // steps {
    //   script{
    //         withSonarQubeEnv(credentialsId: 'sonartoken', installationName: 'Sonar') {
    //           sonarqube.sonarscan("Nodejs","nodejs")
    //   }
    //   }


    //    }
  //   }
//}

//         stage('Build') {
//                     steps {
//                         script {
//                             sh "npm run build"
//                           sh 'tar -czvf dist.tar.gz dist'
              
//                         }
//                     }
//                 }

      stage('Deploy to Nexus') {
            steps {
                script {
                   
                  
                    withCredentials([string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'), string(credentialsId: 'nexusrepo', variable: 'NEXUS_REPO_ID'), string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'), string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')]) {


                     // nexus.pushtoNexus(NEXUS_USERNAME,NEXUS_PASSWORD,NEXUS_URL,NEXUS_REPO_ID,PACKAGE_NAME,currentVersion)
                      //sh "curl -v -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} --upload-file dist.tar.gz ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/${currentVersion}/${PACKAGE_NAME}-${currentVersion}.${env.BUILD_ID}.tar.gz"
                    
                    }
                    
                   
                  
                }
            }
        }

      

//         stage('Build and Push Docker Image') {
//                   steps {
//                       script {

                                         
//                           dockerImage = docker.build("${env.IMAGE_NAME}:${env.BUILD_ID}", "-f ${env.DOCKERFILE_PATH} .")
      
                  
//                           docker.withRegistry('https://registry.hub.docker.com', "${env.DOCKER_HUB_CREDENTIALS}") {
                              
//                               dockerImage.push()
//                           }
//                       }
//                   }
//               }
//         stage('OWASP Dependency-Check Vulnerabilities') {
//               steps {
//                 dependencyCheck additionalArguments: ''' 
//                             -o './'
//                             -s './'
//                             -f 'ALL' 
//                             --prettyPrint''', odcInstallation: 'OWASP Dependency-Check Vulnerabilities'
                
//                 dependencyCheckPublisher pattern: 'dependency-check-report.xml'
//               }
//             }
  
          }
        }




