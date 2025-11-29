pipeline {
  agent any

  environment {
    GITHUB_ACCOUNT  = 'michnmi'
    GITHUB_REPO     = 'ansible_internal'
    GITHUB_CREDS_ID = 'jenkins-ansible-lint'
  }

  options {
    skipDefaultCheckout(true)
  }

  stages {
    stage('Checkout') {
      steps {
        script {
          git(
            url: "https://github.com/${env.GITHUB_ACCOUNT}/${env.GITHUB_REPO}.git",
            branch: env.BRANCH_NAME ?: 'master'
          )

          env.COMMIT_SHA = sh(
            script: 'git rev-parse HEAD',
            returnStdout: true
          ).trim()
          echo "Commit SHA: ${env.COMMIT_SHA}"
        }
      }
    }

    stage('Run ansible-lint') {
      steps {
        script {
          githubNotify(
            credentialsId: env.GITHUB_CREDS_ID,
            account:       env.GITHUB_ACCOUNT,
            repo:          env.GITHUB_REPO,
            sha:           env.COMMIT_SHA,
            context:       'ansible-lint',
            status:        'PENDING',
            description:   'Running ansible-lint…'
          )
        }

        sh 'ansible-lint .'
      }
    }
  }

  post {
    success {
      script {
        githubNotify(
          credentialsId: env.GITHUB_CREDS_ID,
          account:       env.GITHUB_ACCOUNT,
          repo:          env.GITHUB_REPO,
          sha:           env.COMMIT_SHA,
          context:       'ansible-lint',
          status:        'SUCCESS',
          description:   'ansible-lint passed'
        )
      }
    }
    failure {
      script {
        githubNotify(
          credentialsId: env.GITHUB_CREDS_ID,
          account:       env.GITHUB_ACCOUNT,
          repo:          env.GITHUB_REPO,
          sha:           env.COMMIT_SHA,
          context:       'ansible-lint',
          status:        'FAILURE',
          description:   'ansible-lint failed'
        )
      }
    }
  }
}
