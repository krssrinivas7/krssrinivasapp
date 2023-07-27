def SendSlackNotifications(buildStatus = 'SUCCESS') {
    // build status of null means successful
    buildStatus = buildStatus ?: 'SUCCESS'

    // Default values
    def colorName = 'RED'
    def colorCode = '#FF0000'
    def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
    def summary = "${subject} (${env.BUILD_URL})"

    // Override default values based on build status
    if (buildStatus == 'STARTED') {
        colorName = 'YELLOW'
        colorCode = '#FFFF00'
    } else if (buildStatus == 'SUCCESS') {
        colorName = 'GREEN'
        colorCode = '#00FF00'
    } else {
        colorName = 'RED'
        colorCode = '#FF0000'
    }

    // Return a map with color and summary
    return [color: colorCode, message: summary]
}
pipeline{
    agent any
    options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
}

    stages{

        stage('Checkout Code'){
            steps{
                script {
                    def notification = SendSlackNotifications('STARTED')
                    slackSend color: notification.color, message: notification.message, tokenCredentialId: 'bd7c8a19-0508-4d9d-bf45-fa2fd3f03244'
                }
                git branch: 'main', credentialsId: 'Srinivas-Git', url: 'https://github.com/krssrinivas7/krssrinivasapp.git'
            }
        }
        stage('Build'){
            steps{
                bat "$M2_HOME/bin/mvn clean package"
            }
        }
        stage('Deploy'){
            steps{
                bat 'copy "C:\\JENKINSHOME\\workspace\\Multi-Branch_QA\\target\\KRS-maven-web-app.war" "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps"\\KRS-maven-web-app.war'
            }
        }
        /*
        stage('Upload Artifacts to S3'){
            steps{
            withAWS(credentials: 'Srinivas-AWS', region: 'us-east-1') {
                bat 'aws s3 cp "C:\\JENKINSHOME\\workspace\\srinivas-app\\target\\KRS-maven-web-app.war" s3://warfilerepo'
            }
            }
        }
       */ 
    }//Stages Closing    
    post {
        success {
            script {
                def notification = SendSlackNotifications(currentBuild.result)
                slackSend color: notification.color, message: notification.message, tokenCredentialId: 'bd7c8a19-0508-4d9d-bf45-fa2fd3f03244'
            }
        }
        failure {
            script {
                def notification = SendSlackNotifications(currentBuild.result)
                slackSend color: notification.color, message: notification.message, tokenCredentialId: 'bd7c8a19-0508-4d9d-bf45-fa2fd3f03244'
            }
        }
    }
}
