pipeline {
    options{
           buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
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
		stage('Building and tag docker image'){
               steps {
               echo 'Starting building images'
               sh 'docker build -t omprasaddevops/makemytrip-ms .'
               sh 'docker build -t makemytrip-ms .'
               echo 'completed building images'
              }
        }
        stage('docker image scanning'){
                 steps{
                  echo 'docker images scanning'
                  sh 'java -version'
                  echo 'images scanning started'
                     }
            }
            stage('docker push to docker hub'){
                          steps{
            			  script{
            			  withCredentials([string(credentialsId: 'dockerhubcred', variable: 'dockerhubcred')]){
                          sh 'docker login docker.com. -u ommprasad24@gmail.com -p ${omprasad}'
                          echo “Push Docker Image to DockerHub: In Progress”
                          sh 'docker push omprasaddevops/makemytrip-ms:latest'
                          echo “Push Docker Image to DockerHub : In Progress”
                          sh 'whomi'
            		    }
            		 }
                 }
             }
             stage('Docker Image push to  Amazon ECR'){
                      steps{
                      script{
                      withDockerRegistry([credentialsId:'ecr:ap-south-1:ecr-credentials',url:"https://823776493639.dkr.ecr.ap-south-1.amazonaws.com"]){
                       sh """
                       echo "list of docker images present in local"
                       echo “tagging the dokcer image: In progress”
                       docker tag makemytrip-ms:latest 823776493639.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo/makemytrip-ms:latest
                       echo ”tagging the docker Image: Completed”
                       echo “push docker image to ECR : In progress”
                       docker push part of 823776493639.dkr.ecr.ap-south-1.amazonaws.com/dockerrepo/makemytrip-ms:latest
                       echo “push docker Image to ECR : Completed”
                       """
                     }
                   }
                 }
             }
             stage('upload the docker image to nexus'){
                 steps{
                 scripts{
                 withCredentials([usernamePassword(credentialsId:'nexcred',usernameVariable:'USERNAME',passwordVariable:'PASSWORD')]){
                 sh 'http://15.207.106.202:8081/repository/makemytrip-ms/ -u admin p ${PASSWORD}'
                 echo 'push docker image to nexus: In progress'
                 sh 'docker tag makemytrip-ms 15.207.106.202:8085/makemytrip-ms:latest'
                 sh 'docker push 15.207.106.202:8085/makemytrip-ms'
                 echo 'push docker image to nexus: completed'
                }
             }
         }
     }
     stage('Cont Code Inspection') {
         environment {
             scannerHome = tool 'SonarQubeScanner'
         }
     steps {
             withSonarQubeEnv('sonar-server') {
                 sh "${scannerHome}/bin/sonar-scanner"
                 sh 'mvn sonar:sonar'
             }
     timeout(time: 10, unit: 'MINUTES') {
                 waitForQualityGate abortPipeline: true
         }
     }
    }
   }
}