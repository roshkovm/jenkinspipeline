pipeline {
    agent any
    stages {
    stage('Preparation') {
     steps {
           git 'https://github.com/roshkovm/jenkinspipeline'
          }
       }
   stage('DockerImageBuild') {
   steps {
         sh 'echo "Build Docker image..."'
        }
   }
    stage('RunBashScript') {
    steps {
            sh 'chmod +x test.sh'
            sh './test.sh'
       }
   }
    stage('Results') {
       steps {
          sh 'ls -l'
       }
    }
  }
}
