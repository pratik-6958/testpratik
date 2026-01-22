pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/pratik-6958/testpratik.git'
            }
        }

        stage('Install') {
            steps {
                sh 'pip install -r requirements.txt'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'python app.py'
            }
        }

        stage('Record Metrics') {
            steps {
                sh 'python monitor.py'
            }
        }
    }
    
    post {
        failure {
            echo "Build failed! Notifying monitoring system."
            sh 'python monitor.py --failure'
        }
    }
}
