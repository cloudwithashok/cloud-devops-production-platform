pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Source code checkout stage'
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t flask-app:latest ./app'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploy stage'
            }
        }
    }
}