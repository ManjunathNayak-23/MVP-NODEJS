@Library('sharedLibrary') _
pipeline {
  agent any
  environment {
    DOCKER_HUB_CREDENTIALS = 'dockercred' // Replace with your Docker Hub credentials ID
    IMAGE_NAME = 'chandu2311/mvpnode'
    DOCKERFILE_PATH = 'Dockerfile'
    PACKAGE_NAME = 'mvp-nodejs'
    VERSION_FILE = 'package.json'
    ARTIFACT_VERSION=''
  }

  stages {
    stage('Build and Test') {
      steps {

        script {
          nodejs.installDependency()
          nodejs.build()
          nodejs.test()
        }
      }
    }

    stage('SonarQube analysis') {
      environment {
        SCANNER_HOME = tool 'Sonar-scanner'
      }
      steps {
        script {
          withSonarQubeEnv(credentialsId: 'sonartoken', installationName: 'Sonar') {
            sonarqube.sonarscan("Nodejs",
              "nodejs")
          }
        }
      }
    }
    //     stage('OWASP Dependency-Check Vulnerabilities') {
    //   steps {
    //     script {
    //       dependencyCheckTask.owaspDependencyCheck()
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

          withCredentials([string(credentialsId: 'nexusurl', variable: 'NEXUS_URL'), string(credentialsId: 'nexusrepo', variable: 'NEXUS_REPO_ID'), string(credentialsId: 'nexuspassword', variable: 'NEXUS_PASSWORD'), string(credentialsId: 'nexususername', variable: 'NEXUS_USERNAME')]) {

           ARTIFACT_VERSION=nexus.pushtoNexus(NEXUS_USERNAME, NEXUS_PASSWORD, NEXUS_URL, NEXUS_REPO_ID, PACKAGE_NAME)
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
     stage('Trigger Downstream Pipeline') {
            steps {
                script {
                    // Trigger the downstream pipeline (Pipeline B) only if the build is stable or successful
                    if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
                        build job: 'AutoDeployToDev', parameters: [string(name: 'buildID', value: ARTIFACT_VERSION)]
                    } else {
                        echo 'Skipping downstream pipeline due to unsuccessful upstream build.'
                    }
                }
            }
        }


  }
}
