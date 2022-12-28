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
 checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '7a98831a-b0e9-4bcc-b384-96810b7870b3', url: 'git@github.com:dhimalu/mantisbt.git']]])
}
}


// Building Docker images
stage('Building image') {
steps{
script {
echo "${IMAGE_VER}"
dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_VER}"
}
}
}

stage('Logging into AWS ECR') {
steps {
script {
sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
}

}
}

// Uploading Docker images into AWS ECR
stage('Pushing to ECR') {
steps{
script {
echo "${IMAGE_VER}"
sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_VER} ${REPOSITORY_URI}:$IMAGE_VER"
sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_VER}"
}
}
}
}
}