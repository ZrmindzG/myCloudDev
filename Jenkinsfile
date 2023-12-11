pipeline {
    options{
           buildDiscarder(logRotator(numToKeepstr: '5',artifactNumToKeepstr:'5'))
}
agent any

tools{
maven 'maven_3.9.4'
}
    stages {
        stage('Code Compilation') {
            steps {
                echo 'code compilation is progress!'
                sh 'mvn clean'
                echo 'code compilation is suessfully completed!'

            }
        }
        stage('Code QA execution') {
            steps {
                echo 'Junit Testcase is in progress'
                sh 'mvn clean test'
                echo 'junit test case check completed'
            }
        }
        stage('Code Package') {
            steps {
                echo 'Creat WAR artifact'
                sh 'mvn clean test'
                echo 'WAR artifact created successfully'
            }
        }
		stage('Building and tag docker image')
               steps {
               echo ‘Starting building images’
               sh 'docker build -t omprasaddevops/yatra-ms .'
               sh 'docker build -t yatra-ms .'
               echo 'completed building images'
              }

        stage('docker image scanning')
             {
             steps{
             echo 'docker images scanning'
             sh 'java -version'
             echo 'images scanning started'
             }
             }
        stage('docker push to docker hub')
              steps{
			    script{
			 withCredentials([string(credentialsId: 'dockerhubCred', variable: 'dockerhubCred')]){
             sh 'docker login docker.io. -u omprasaddevops -p ${dockerhubCred}'
             echo “Push Docker Image to DockerHub: In Progress”
             sh 'docker push omprasaddevops/makemytrip-ms:latest'
             echo “Push Docker Image to DockerHub : In Progress”
             sh 'whomi'
		    }
		 }
		}
       stage('Docker Image push to  Amazon ECR')
     {
     steps{
       script{
         withDockerRegistry([credentialsId:'ecr:ap-south-1:ecr-credentials',url:"https://823776493639.dkr.ecr.ap-south-1.amazonaws.com"])
		 sh """
		 echo "list of docker images present in local"
		 docker images
         echo “tagging the dokcer image: In progress”
         docker tag makemytrip-ms:latest 823776493639.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo/makemytrip-ms:latest
         echo ”tagging the docker Image: Completed”
         echo “push docker image to ECR : In progress”
         docker push part of 823776493639.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo/makemytrip-ms:latest
         echo “push docker Image to ECR : Completed”
        }
      }
   }
   }
}
}