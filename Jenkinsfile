pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9' 
    }

    environment {
        // Define las variables de entorno
        ARTIFACTORY_NAME = 'libs-snapshot-local'
        ARTIFACTORY_REPO_KEY = 'libs-snapshot-local'
        ARTIFACTORY_URL = 'http://127.0.0.1:8082/artifactory'
    }

    stages {
        /*stage('Checkout') {
            steps {
                git url: 'https://github.com/CtaCorriente.git'
            }
        }*/

        stage('Build and Artifactory Publish') {
            steps {
                script {
                    timeout(time: 20, unit: 'MINUTES') {
                        def server = Artifactory.server(ARTIFACTORY_NAME)
                        def rtMaven = server.newMavenBuild()
                        rtMaven.tool = 'Maven 3.9.9' // Asegúrate de que este nombre coincida con la configuración en Jenkins
                        rtMaven.resolver server: server, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
                        rtMaven.deployer server: server, releaseRepo: ARTIFACTORY_REPO_KEY, snapshotRepo: ARTIFACTORY_REPO_KEY
                        def buildInfo = rtMaven.run goals: 'clean install -Dmaven.test.skip=true', pom: 'pom.xml'
                        server.publishBuildInfo buildInfo
                    }
                }
            }
        }

        stage('Code Analysis') {
            when {
                expression { fileExists('pom.xml') }
            }
            steps {
                // Asegúrate de que tu servidor Jenkins tiene acceso a SonarQube y que el plugin de SonarQube está configurado correctamente
                bat "mvn sonar:sonar"
            }
        }

        stage('Deploy') {
            steps {
                // Agrega aquí tus pasos de despliegue
                echo 'Deploying the Java EE application...'
                // Aquí podrías incluir pasos para desplegar tu aplicación, como scripts de shell o pasos específicos de Jenkins
            }
        }
    }

    post {
        always {
            cleanWs() // Limpia el espacio de trabajo después de la ejecución del pipeline
        }
    }
}

