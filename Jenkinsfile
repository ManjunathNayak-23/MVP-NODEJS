pipeline {
  agent any
 environment {
    PACKAGE_NAME = 'mvp-nodejs-release'
  }
   stages {
     stage('Download artifact from Nexus'){
            steps{
              withCredentials([string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'), string(credentialsId: 'nexusrepo-release', variable: 'NEXUS_REPO_ID'), string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'), string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')]) {
              sh 'curl -v -O -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/1.0.1/${PACKAGE_NAME}-1.0.1.2.tar.gz'
              }
              
            }
     }
       
     // stage('Deploy to VM') {
     //        steps {
     //            // Use SSH or another method to copy and deploy the artifact to the VM
     //            sh 'scp target/your-artifact.jar user@your-vm:/path/on/vm'
     //        }
     //    }
   }
}
