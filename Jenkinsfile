pipeline {
    agent any

    environment {
        PACKAGE_NAME = 'mvp-nodejs-release'
    }

    parameters {
        string(name: 'VERSION', defaultValue: '1.0', description: 'Enter the version number')
    }

    stages {
        stage('Download artifact from Nexus') {
            steps {
                script {
                
                    
                    withCredentials([
                        string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'),
                        string(credentialsId: 'nexusrepo-release', variable: 'NEXUS_REPO_ID'),
                        string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'),
                        string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')
                    ]) {
                        sh "curl -v -O -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/1.0.1/${PACKAGE_NAME}-${params.VERSION}.tar.gz"                    }
                }
            }
        }

        // Uncomment the following stages after confirming the first stage is working correctly

        // stage('SSH Example') {
        //     steps {
        //         script {
        //             def remoteServer = '35.184.3.159'
        //             def remoteCredentials = 'sshtest'

        //             sshCommand(remote: remoteServer, credentials: remoteCredentials, command: "echo 'Hello, remote world!'")
        //         }
        //     }
        // }

        stage('Deploy to VM') {
            steps {
                script {
                    // Use SSH or another method to copy and deploy the artifact to the VM
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'sshtest',
                        transfers: [sshTransfer(flatten: false, remoteDirectory: './', sourceFiles: "mvp-nodejs-release-${params.VERSION}.tar.gz")])
                    ])
                }
            }
        }
    }
}
