pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/MTX77/TetrisC_.git' 
        GIT_CRED_ID = '06fd451d-ef6b-44b7-abf9-dbb40523a4e3'
        GIT_BRANCH = 'master'
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Collect') {
            steps {
                git branch: "${GIT_BRANCH}", credentialsId: "${GIT_CRED_ID}", url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo "Building..."
                sh '''
                docker build -t tetris_builder:latest -f ./Dockerfile .
                docker run --rm --name buildcontainer -v ./artifacts:/dist tetris_builder:latest
                mkdir log
                docker logs buildcontainer > ./log/log_builder
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing..."
                sh 'docker build -t tetris_tester:latest -f ./DockerfileTests .'
            }
        }
    }
}
