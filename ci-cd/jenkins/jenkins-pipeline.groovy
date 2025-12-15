pipeline {
  agent any
  stages {
    stage('Checkout') { steps { checkout scm } }
    stage('Lint') { steps { sh 'echo Linting...' } }
    stage('Build') { steps { sh 'docker build -t app:latest app/' } }
    stage('Unit Tests') { steps { sh 'docker run --rm app:latest pytest -q' } }
    stage('Security Scan') { steps { sh 'docker run --rm aquasec/trivy:latest image app:latest' } }
    stage('Publish') {
      when { branch 'main' }
      steps { sh 'echo Publish to registry' }
    }
  }
}
