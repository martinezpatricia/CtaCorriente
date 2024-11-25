pipeline {
    agent any

    tools {
        maven 'Maven 3.9.9' 
    }

    environment {
        ARTIFACTORY_NAME = 'art1'  // Este es el ID de la configuración Artifactory en Jenkins
        ARTIFACTORY_REPO_KEY = 'libs-snapshot'
        ARTIFACTORY_URL = 'http://192.168.153.1:8082/artifactory'
        ARTIFACTORY_CREDENTIALS = 'art1'  // Referencia al ID de las credenciales Artifactory en Jenkins
    }

    stages {
        stage('Build and Artifactory Publish') {
            steps {
                script {
                    timeout(time: 20, unit: 'MINUTES') {
                        // Conexión a Artifactory usando el ID de las credenciales configuradas
                        def server = Artifactory.server(ARTIFACTORY_NAME)

                        // Si el ID de Artifactory está correctamente configurado en Jenkins, se autentica automáticamente
                        server.credentialsId = ARTIFACTORY_CREDENTIALS // Usar las credenciales de Artifactory

                        def rtMaven = server.newMavenBuild()
                        rtMaven.tool = 'Maven 3.9.9' 
                        rtMaven.resolver server: server, releaseRepo: 'libs-release', snapshotRepo: 'libs-snapshot'
                        rtMaven.deployer server: server, releaseRepo: ARTIFACTORY_REPO_KEY, snapshotRepo: ARTIFACTORY_REPO_KEY

                        def buildInfo = rtMaven.run goals: 'clean install -Dmaven.test.skip=true', pom: 'pom.xml'
                        server.publishBuildInfo buildInfo
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Limpiar el espacio de trabajo después de la ejecución
        }
    }
}
