pipeline {
agent any
environment {
AWS_ACCOUNT_ID="590907222558"
AWS_DEFAULT_REGION="us-east-1"
IMAGE_REPO_NAME="mnt"
IMAGE_TAG="latest"
IMAGE_VER="29.0.1"
REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
}

stages {

stage('Checkout') {
steps {
 checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '7a98831a-b0e9-4bcc-b384-96810b7870b3', url: 'git@github.com:dhimalu/mantisbt.git']])
}
}

stage('Logging into AWS ECR') {
steps {
script {
sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
}

}
}

stage('Building image'){
steps {
script {
         if (env.BRANCH_NAME == 'master') {
                        echo 'Hello from main branch'
						dockerImage = docker.build "jrv:latest"
						dockerImage = docker.build "jrv:$BUILD_NUMBER"
                    }  else if (env.BRANCH_NAME == 'Dev') {
                        sh "echo 'Hello from ${env.BRANCH_NAME} branch!'"
						dockerImage = docker.build "dev:latest"
						dockerImage = docker.build dev + ":$BUILD_NUMBER"
                    }
					else 
					{
					echo 'this is Stagning Branch'
					dockerImage = docker.build "mnt:latest"
					dockerImage = docker.build mnt + ":$BUILD_NUMBER"
					}
}
}
}

stage('Pushing to ECR') {
steps{
script {
 if (env.BRANCH_NAME == 'master'){
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/jrv:latest"
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/jrv:$BUILD_NUMBER"
}
else if (env.BRANCH_NAME == 'Dev') {
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/dev:latest"
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/jrv:$BUILD_NUMBER"
}
else{
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/mnt:latest"
sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/jrv:$BUILD_NUMBER"
}
}
}
}

}
}
