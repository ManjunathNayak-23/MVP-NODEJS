pipeline {
  agent any
 environment {
    PACKAGE_NAME = 'mvp-nodejs-release'
  }
  parameters {

        string(name: 'VERSION', defaultValue: '1.0', description: 'Enter the version number')
    }
  
   stages {
     stage('Download artifact from Nexus'){
            steps{
              cleanWs()
              def extractedVersion = ${params.VERSION} =~ /^(\d+\.\d+\.\d+)/
              def mainVersion = extractedVersion ? extractedVersion[0][0] : null
              withCredentials([string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'), string(credentialsId: 'nexusrepo-release', variable: 'NEXUS_REPO_ID'), string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'), string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')]) {
              sh 'curl -v -O -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/${mainVersion}/${PACKAGE_NAME}-${params.VERSION}.tar.gz'

              }
              
            }
     }
     
stage('SSH Example') {
            steps {
                script {
                    def remoteServer = '35.184.3.159'
                    def remoteCredentials = 'sshtest'

                    sshCommand(remote: remoteServer,
                               credentials: remoteCredentials,
                               command: "echo 'Hello, remote world!'")
                }
            }
        }


       
     stage('Deploy to VM') {
            steps {
                // Use SSH or another method to copy and deploy the artifact to the VM
               sshPublisher(publishers: [sshPublisherDesc(configName: 'dummy-server',
                    transfers: [ sshTransfer(flatten: false,
                                 remoteDirectory: './',
                                 sourceFiles: 'mvp-nodejs-release-1.0.1.2.tar.gz'
                    )])
                  ])
                   
            }
        }
   }
   
}
