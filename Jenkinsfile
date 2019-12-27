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
         sh 'chmod +x ./docker_image_build.sh'
         sh './docker_image_build.sh'
        }
   }
   stage('DockerInstanceRun') {
   steps {
         sh 'chmod +x ./docker_instance_run.sh'
         sh './docker_instance_run.sh'
    }
   }
   stage('OldDockerImageClean') {
   steps {
         sh 'chmod +x ./docker_image_clean.sh'
         sh './docker_image_clean.sh'
         }
   }
    stage('Results') {
       steps {
         sh 'chmod +x ./docker_status.sh'
         sh './docker_status.sh'
       }
    }
  }
}
