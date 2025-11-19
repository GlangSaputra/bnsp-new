pipeline {
    agent any

    environment {
        DOCKER_HOST = "unix:///var/run/docker.sock"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
                echo "📥 Code checked out successfully"
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "🐳 Building Docker image using host Docker..."
                # Gunakan host Docker via socket
                docker build -t jenkins-app .
                echo "✅ Docker image built successfully"
                '''
            }
        }

        stage('Deploy to Production') {
            steps {
                sh '''
                echo "🚀 Deploying application..."
                # Stop and remove old container
                docker stop jenkins-container || true
                docker rm jenkins-container || true
                
                # Run new container
                docker run -d -p 8080:80 --name jenkins-container jenkins-app
                echo "✅ Application deployed to http://103.23.199.68:8080"
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "🔍 Verifying deployment..."
                sleep 10
                echo "📊 Checking containers:"
                docker ps
                echo "🌐 Testing website..."
                curl -f http://localhost:8080 && echo "✅ Website is accessible" || echo "⚠️ Website might be starting..."
                '''
            }
        }
    }

    post {
        always {
            echo "🏁 Pipeline execution completed"
        }
        success {
            echo "🎉 SUCCESS: Pipeline executed successfully!"
        }
        failure {
            echo "❌ FAILURE: Pipeline execution failed"
        }
    }
}