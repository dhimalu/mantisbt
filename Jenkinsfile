node {
  stage('Checkout') {
  checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: '7a98831a-b0e9-4bcc-b384-96810b7870b3', url: 'git@github.com:dhimalu/mantisbt.git']])
}
    stage('Build') {
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
	
	stage('Logging into AWS ECR')  {
        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 590907222558.dkr.ecr.us-east-1.amazonaws.com"
    }
  
	stage('Pushing to ECR')  {
         if (env.BRANCH_NAME == 'master'){
docker.withRegistry('https://590907222558.dkr.ecr.us-east-1.amazonaws.com/'){
//sh "docker push 590907222558.dkr.ecr.us-east-1.amazonaws.com/jrv:$BUILD_NUMBER"
        docker.image('jrv').push('latest')
		docker.image('jrv').push("$BUILD_NUMBER")
		}
}
else if (env.BRANCH_NAME == 'Dev') {
docker.withRegistry('https://590907222558.dkr.ecr.us-east-1.amazonaws.com/'){ 
docker.image('dev').push('latest')
docker.images('dev').push("$BUILD_NUMBER")
}
}
else{
docker.withRegistry('https://590907222558.dkr.ecr.us-east-1.amazonaws.com/'){ 
docker.image('mnt').push('latest')
docker.image('mnt').push("$BUILD_NUMBER")
}
}
    }
	
}
