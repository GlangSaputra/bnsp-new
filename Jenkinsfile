pipeline {
    agent any

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
                echo "🐳 Building Docker image..."
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
                echo "✅ Application deployed successfully"
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "🔍 Verifying deployment..."
                sleep 5
                echo "📊 Container status:"
                docker ps | grep jenkins-container
                echo "🌐 Testing website..."
                curl -f http://localhost:8080 && echo "✅ Website is accessible" || echo "❌ Website check failed"
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
            echo "📍 Access website: http://103.23.199.68:8080"
        }
        failure {
            echo "❌ FAILURE: Pipeline execution failed"
        }
    }
}