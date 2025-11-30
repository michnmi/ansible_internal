pipeline {
  agent any

  environment {
    GITHUB_ACCOUNT  = 'michnmi'
    GITHUB_REPO     = 'ansible_internal'
    GITHUB_CREDS_ID = 'jenkins-ansible-lint'
  }

  options {
    // In multibranch this just stops the implicit checkout,
    // we'll do an explicit 'checkout scm' ourselves.
    skipDefaultCheckout(true)
  }

  stages {
    stage('Checkout') {
      steps {
        // Use the exact SCM config that Multibranch figured out
        checkout scm

        script {
          // Capture the actual commit we just checked out
          env.COMMIT_SHA = sh(
            script: 'git rev-parse HEAD',
            returnStdout: true
          ).trim()

          echo "Building branch ${env.BRANCH_NAME} at commit ${env.COMMIT_SHA}"
        }
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

        sh 'ansible-lint */*'
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

