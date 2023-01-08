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
stage('Branching'){
steps{
script{
         if (env.BRANCH_NAME == 'master') {
                        echo 'Hello from main Dev Branch'
                    }  else if (env.BRANCH_NAME == 'Dev') {
                        sh "echo 'Hello from ${env.BRANCH_NAME} branch!'"
                    }
					else 
					{
					echo 'this is Stagning Branch'
					}
}
}
}


}
}