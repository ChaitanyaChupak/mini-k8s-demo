pipeline {

    agent any  // Run on any available Jenkins node

    environment {
        REPO_URL = "git@github.com:ChaitanyaChupak/mini-k8s-demo.git"
        WORKDIR = "${WORKSPACE}/mini-k8s-demo"
        VENV_PATH = "${WORKSPACE}/venv"
        DOCKER_IMAGE = "mini-k8s-demo:latest"
        K8S_NAMESPACE = "mini-demo"
    }

    stages {

        stage('Clone Repository') {
            steps {
                cleanWs()  // Clean workspace before building
                
                sh """ 
                echo "🚀 Cloning repository..."
                if [ -d "$WORKDIR" ]; then
                    rm -rf "$WORKDIR"
                fi
                git clone $REPO_URL "$WORKDIR"
                echo "✅ Repository cloned successfully!"
                ls -la "$WORKDIR"
                """
            }
        }

        stage('Setup Python Environment') {
            steps {
                sh """
                echo "🐍 Setting up Python environment..."
                python3 -m venv "$VENV_PATH"
                . "$VENV_PATH/bin/activate"
                pip install --upgrade pip build pytest
                echo "✅ Python environment setup complete!"
                """
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo '🐳 Building Docker Image...'
                    sh """
                    cd mini-k8s-demo/app
                    docker build -t ${DOCKER_IMAGE} .
                    """
                    echo "✅ Docker Image built: ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                echo "📌 Deploying to Kubernetes..."
                kubectl config use-context minikube  # Ensure Minikube is used
                kubectl apply -f "$WORKDIR/k8s/namespace.yaml"
                kubectl apply -f "$WORKDIR/k8s/configmap.yaml"
                kubectl apply -f "$WORKDIR/k8s/deployment.yaml"
                kubectl apply -f "$WORKDIR/k8s/service.yaml"

                echo "⏳ Waiting for deployment to complete..."
                kubectl -n $K8S_NAMESPACE rollout status deployment/flask-app
                echo "✅ Deployment successful!"
                """
            }
        }
    }

    post {
        success {
            echo '🎉 ✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
