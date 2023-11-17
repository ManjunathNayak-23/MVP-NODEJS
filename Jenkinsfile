pipeline {
	agent any
 triggers {
    pollSCM('* * * * *') // Enabling being build on Push
  }
    stages{
	    stage("Hello World"){
		    steps{
			    sh 'npm install'	
        }
	    }

        }
 
 
}
