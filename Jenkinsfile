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
               sh 'docker build -t omprasaddevops/yatra-ms .'
               sh 'docker build -t yatra-ms .'
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
            			  withCredentials([string(credentialsId: 'dockerhubCred', variable: 'dockerhubCred')]){
                          sh 'docker login docker.io. -u omprasaddevops -p ${dockerhubCred}'
                          echo “Push Docker Image to DockerHub: In Progress”
                          sh 'docker push omprasaddevops/makemytrip-ms:latest'
                          echo “Push Docker Image to DockerHub : In Progress”
                          sh 'whomi'
            		    }
            		 }
                 }
             }
        }
  }

