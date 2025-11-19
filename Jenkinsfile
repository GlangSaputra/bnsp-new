pipeline {
    agent any

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
                echo "🧹 Workspace cleaned"
            }
        }
        
        stage('Checkout Code') {
            steps {
                checkout([$class: 'GitSCM',
                  branches: [[name: '*/main']],
                  userRemoteConfigs: [[url: 'https://github.com/GlangSaputra/bnsp-new.git']]
                ])
                echo "📥 Code checkout completed"
                
                // List files to verify
                sh 'ls -la'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "🐳 Building Docker image..."
                docker build -t jenkins-app .
                echo "✅ Docker image built"
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                echo "🚀 Deploying application..."
                docker stop jenkins-container || true
                docker rm jenkins-container || true
                docker run -d -p 8080:80 --name jenkins-container jenkins-app
                echo "✅ Application deployed"
                '''
            }
        }
    }
    
    post {
        always {
            echo "🏁 Pipeline completed"
        }
    }
}
