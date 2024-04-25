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
                sh '''
                    chmod +x clear.sh
                    ./clear.sh
                '''
            }
        }

        stage('Build') {
            steps {
                echo "Building..."
                sh '''
                docker build -t tetris_builder:latest -f ./Dockerfile .
                docker run --name buildcontainer -v ./artifacts:/dist tetris_builder:latest
                docker logs buildcontainer > ./log/log_builder.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing..."
                sh '''
                docker build -t tetris_tester:latest -f ./DockerfileTests .
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying..."
                withCredentials([usernamePassword(credentialsId: '7377e1bf-6ad3-4aa6-9fa5-16f0c399ea2e', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                }
                script {
                    def appImage = docker.build('matlugowski/tetrisc:latest', '-f ./DockerfileDeploy .')
                    sh 'docker tag matlugowski/tetrisc:latest matlugowski/tetrisc:1.0.0'
                    sh 'docker push matlugowski/tetrisc:1.0.0'
                }
            }
        }
        stage('Archive') {
            steps {
                echo "Archiving..."
                archiveArtifacts artifacts: './log', fingerprint: true
            }
        }
        stage('Publish') {
            steps {
                echo "Publishing..."
                sh '''
                git add ./log
                git commit
                git push origin
                '''
            }
        }
    }
}
