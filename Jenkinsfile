pipeline {
    agent any
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


        }
 
 
}
