### Deploy Jenkins Docker Image

##### 1. Run AWS EC2 Instance with assigned EIP

##### 2. Create GitHub Repo Webhook
- Open Github URL:&nbsp; _https://github.com/roshkovm/jenkinspipeline_
- Go to:   _**Settings - Webhooks**_
- Add Webhook URL: &nbsp;_http://x.x.x.x:8080/github-webhook/_

Where, <br>
__x.x.x.x__ - IP address Jenkins Server

##### 3. Run Jenkins Docker Instance on EC2:
```
# docker run -d -it -p 8080:8080 -p 50000:50000 -u 0 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock 4oh4/jenkins-docker
```

##### 4. Check automatically created Docker Volume
```
# docker volume ls
DRIVER              VOLUME NAME
local               jenkins_home
# cd /var/lib/docker/volumes
# ls -l
jenkins_home
```

##### 5. Connect to Jenkins Server:
http://x.x.x.x:8080
```
# cat /var/lib/docker/volumes/jenkins_home/_data/secrets/initialAdminPassword
xxxxxxxxxxxxx
```
__NOTE__:<br>
Put hash in Jenkins login page. Go over Jenkins Menu and Install suggested modules and create new user.

##### 6. Restart Jenkins Docker instance (check, that configuration data is saved)
```
# docker ps
# docker stop instance-id
# docker rm instance-id
# docker run -d -it -p 8080:8080 -p 50000:50000 -u 0 -v jenkins_home:/var/jenkins_home -v /var/run/ docker.sock:/var/run/docker.sock 4oh4/jenkins-docker
```
##### 7. Create Jenkins Simple Pipeline Job
_**Build Triggers**_<br>
_[x] GitHub hook trigger for GITScm polling_ <br>
_**Pipeline**_<br>
_Definition Pipeline script from SCM_ <br>
_**SCM - GIT**_<br>
_**Repository URL**: https://github.com/roshkovm/jenkinspipeline_<br>
_**Credentials**: xxxxxxxx_ <br>
_**Script Path**: Jenkinsfile_ <br>

__Note:__<br>
Example __Jenkinsfile__:<br>

```groovy
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
```
