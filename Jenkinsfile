
pipeline {
    agent none
    options {
        buildDiscarder(logRotator(numToKeepStr: '7'))
        skipDefaultCheckout()
    }
    
    stages {
        stage('Тестирование кода пакета WIN') {

            agent { label 'windows' }

            steps {
                checkout scm
                
                script {
                    if( fileExists ('tasks/test.os') ){
                        bat 'chcp 65001 > nul && oscript tasks/test.os'

                        junit allowEmptyResults: true, testResults: 'tests.xml'
                        junit allowEmptyResults: true, testResults: 'bdd-log.xml'
                    }
                    else
                        echo 'no testing task'
                        
                    def scannerHome = tool 'sonar-scanner';
                    withSonarQubeEnv('silverbulleters') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
                
            }

        }

/*        stage('Тестирование кода пакета LINUX') {

            agent { label 'master' }

            steps {
                echo 'under development'
            }

        }
*/

    }
}
