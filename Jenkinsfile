@Library('sharedLibrary') _
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
                        OUTPUTFILENAME="dist.tar.gz"
                        downloadNexusArtifact.download(OUTPUTFILENAME,NEXUS_USERNAME,NEXUS_PASSWORD,NEXUS_URL,NEXUS_REPO_ID,PACKAGE_NAME,params.VERSION)
                        //sh "curl -v -o dist.tar.gz -u ${NEXUS_USERNAME}:${NEXUS_PASSWORD} ${NEXUS_URL}/repository/${NEXUS_REPO_ID}/${PACKAGE_NAME}/1.0.1/${PACKAGE_NAME}-${params.VERSION}.tar.gz"                    }
                }
            }
        }
        }

        stage("unzip artifact"){
            steps{
                script{
                    sh "tar -xvf dist.tar.gz"



                }
            }
        }

         stage('Stop nginx and remote old version files') {
            steps {
                script {
                     sshPublisher(publishers: [sshPublisherDesc(configName: 'sshtest', transfers: [
                                    sshTransfer(
                                        execCommand: "sudo systemctl stop nginx && sudo rm -rf /var/www/html/*",
                                        execTimeout: 120000
                                    )
                                ])
                    ])
                }
               
                
            }
        }



        stage('Deploy to VM') {
            steps {
                script {
                    // Use SSH or another method to copy and deploy the artifact to the VM
                    sshPublisher(publishers: [sshPublisherDesc(configName: 'sshtest',
                        transfers: [sshTransfer(flatten: false, sourceFiles: "dist/**")])
                    ])
                }
            }
        }

         stage('start nginx') {
            steps {
                script {
                     sshPublisher(publishers: [sshPublisherDesc(configName: 'sshtest', transfers: [
                                    sshTransfer(
                                        execCommand: "sudo cp -rf /home/ubuntu/dist/* /var/www/html/ && rm -rf /home/ubuntu/dist && sudo systemctl start nginx",
                                        execTimeout: 120000
                                    )
                                ])
                    ])
                }
               
                
            }
        }
    }
}
