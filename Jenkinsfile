pipeline {
    agent any
    stages {
    stage('Preparation') {
     steps {
           git 'https://github.com/roshkovm/nginx_repo.git'
          }
       }
  stage('DockerImageBuild') {
   steps {
         sh 'echo "Build Docker image..."'
     }
       }
  stage('Results') {
  steps {
       sh 'ls -l'
         }
       }
  }
}