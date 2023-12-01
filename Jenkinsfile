@Library('sharedLibrary') _
pipeline {
    agent any

    environment {
        PACKAGE_NAME = 'mvp-nodejs-release'
        OUTPUTFILENAME="dist.tar.gz"
        SSHCONFIGNAME='sshtest'
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
                        
                        downloadNexusArtifact.download(OUTPUTFILENAME,NEXUS_USERNAME,NEXUS_PASSWORD,NEXUS_URL,NEXUS_REPO_ID,PACKAGE_NAME,params.VERSION)
                }
            }
        }
        }

        stage("unzip artifact"){
            steps{
                script{
                    sh "tar -xvf ${OUTPUTFILENAME}"



                }
            }
        }

         stage('Stop nginx and remote old version files') {
            steps {
                script {
                    stopAndRemoveFiles.stopRemove(SSHCONFIGNAME)

                
                }
               
                
            }
        }



        stage('Deploy to VM') {
            steps {
                script {
                 
                   deployToVM.startDeploy(SSHCONFIGNAME)
                }
            }
        }

         stage('start nginx') {
            steps {
                script {
                     startNginx.startService(SSHCONFIGNAME)
                }
               
                
            }
        }
    }
}
