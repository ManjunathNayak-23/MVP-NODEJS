@Library('sharedLibrary') _
pipeline {
  agent any

  environment {
    DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
    IMAGE_NAME = 'chandu2311/mvpnode-release'
    DOCKERFILE_PATH = 'Dockerfile'
    PACKAGE_NAME = 'mvp-nodejs-release'
    VERSION_FILE = 'package.json'
  }
 triggers {
        pollSCM('* * * * *') // Poll SCM every 5 minutes
    }

  
  stages {
    stage('Build and Test') {
      steps {
        script {
          nodejs.installDependency()
          nodejs.test()
          nodejs.build()
        }
      }
    }


    // stage('SonarQube analysis') {
    //   environment {
    //     SCANNER_HOME = tool 'Sonar-scanner'
    //   }
    //   steps {
    //     script {
    //       withSonarQubeEnv(credentialsId: 'sonartoken', installationName: 'Sonar') {
    //         sonarqube.sonarscan("Nodejs-release",
    //           "nodejs-release")
    //       }
    //     }
    //   }
    // }

    stage('Archive Artifact') {
      steps {
        script {

          archive.archiveArtifact()
        }
      }
    }

    stage('Deploy to Nexus') {
      steps {
        script {

          withCredentials([string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'), string(credentialsId: 'nexusrepo-release', variable: 'NEXUS_REPO_ID'), string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'), string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')]) {

            nexus.pushtoNexus(NEXUS_USERNAME, NEXUS_PASSWORD, NEXUS_URL, NEXUS_REPO_ID, PACKAGE_NAME)
          }
        }
      }
    }

    stage('Build and Push Docker Image') {
      steps {
        script {

          dockertask.buildAndPush(env.IMAGE_NAME, env.BUILD_ID, env.DOCKERFILE_PATH, env.DOCKER_HUB_CREDENTIALS)
        }
      }
    }

    // stage('OWASP Dependency-Check Vulnerabilities') {
    //   steps {
    //     script {
    //       dependencyCheckTask.owaspDependencyCheck()
    //     }
    //   }
    // }
  }
}
