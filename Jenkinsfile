pipeline {
    options{
           buildDiscarder(logRotator(numToKeepstr: '5',artifactNumToKeepstr:'5'))
}
agent any

tools{
maven 'maven_3.9.4'

    stages {
        stage('Code Compilation') {
            steps {
                echo 'code compilation is progress'
                sh 'mvn clean'
                echo 'code compilation is suessfully completed'

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
    }
}
}