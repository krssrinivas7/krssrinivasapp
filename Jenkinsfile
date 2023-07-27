pipeline{
    agent any
    options {
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')
}

    stages{

        stage('Checkout Code'){
            steps{
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
                bat 'copy "C:\\JENKINSHOME\\workspace\\srinivas-app\\target\\KRS-maven-web-app.war" "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps"\\KRS-maven-web-app.war'
            }
        }
        stage('Upload Artifacts to S3'){
            steps{
            withAWS(credentials: 'Srinivas-AWS', region: 'us-east-1') {
                bat 'aws s3 cp "C:\\JENKINSHOME\\workspace\\srinivas-app\\target\\KRS-maven-web-app.war" s3://warfilerepo'
            }
            }
        }
    }//Stages Closing    
    post {
        success {
            emailext body: 'Success', recipientProviders: [buildUser()], subject: 'Success', to: 'krssrinivas.marolix@gmail.com'
        }
        failure {
            emailext body: 'Failure', recipientProviders: [buildUser()], subject: 'Failure', to: 'krssrinivas.marolix@gmail.com'
        }
    }    
}
