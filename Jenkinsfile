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
        stage('Docker Push') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-creds',
            usernameVariable: 'DOCKER_USER',
            passwordVariable: 'DOCKER_PASS'
        )]) {
            sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker tag flask-app:latest $DOCKER_USER/flask-app:latest
            docker push $DOCKER_USER/flask-app:latest
            '''
        }
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