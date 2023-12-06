@Library('sharedLibrary') _
pipeline {
  agent any

  environment {
    targetBranch = 'develop'
     gitUserEmail = 'manjunathnayak2311@gmail.com'
    gitUserName = 'ManjunathNayak-23'
    githubRepoUrl = 'https://github.com/ManjunathNayak-23/MVP-NODEJS.git'
    githubrepoPath='ManjunathNayak-23/MVP-NODEJS.git'
    githubToken = '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' // Replace with your GitHub personal access token
  }

  stages {
    stage("autocascade") {
      steps {

        script {
          cleanWs()

          def commitId = env.commitId
          echo "commitid from pr is " + env.commitId
          echo "repositoryname from pr is " + env.repoName

          echo "targeted branch " + env.ref
          targetCommitId = env.commitId
          targetRepo = env.repoName
          ref = env.ref
          triggeredBranch = ref.split('/')[2.. - 1].join('/')
          echo "${triggeredBranch}"
          requiredBranchRegExpr = "release-*"
          if (triggeredBranch =~ requiredBranchRegExpr) {

            def Targetbranch = 'develop'
            echo "Targetbranch is $Targetbranch"

            sh "git clone ${githubRepoUrl}"
            sh "cd ${targetRepo} && git pull"
            sh "cd ${targetRepo} && git branch"
            sh "cd ${targetRepo} && git checkout ${Targetbranch}"
            def status = sh(script: "cd ${targetRepo} && git cherry-pick -m 1 ${targetCommitId} --allow-empty", returnStatus: true)
            echo "status is" + status

            if (status == 0) {
              cherrypicstatus = "success"
              sh "cd ${targetRepo} && git push https://${gitUserName}:${githubToken}@github.com/${githubrepoPath}"
            } else {

              cherrypicstatus = "failed"
            }
            echo "$cherrypicstatus"
            sh "cd ${targetRepo} && git status"

          } else {
            echo "this execution is not triggered for release branch"
          }

        }
      }

    }
  }
}
