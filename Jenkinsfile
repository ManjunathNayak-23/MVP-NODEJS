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


        }
 
 
}
