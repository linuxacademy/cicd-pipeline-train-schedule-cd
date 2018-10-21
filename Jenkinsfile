pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('DeployToStaging') {
            
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsID: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]){
                    sshPublisher(
                        failOnError: true, 
                        continueOnError: false,
                        publishers: [
                            sshPublishersDesc(
                                configName: 'staging'
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"                                    
                                ],
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'dist/trainSchedule.zip',
                                        removePrefix: 'dist/',
                                        remoteDirectory: '/tmp',
                                        execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/train-schedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
                                        )
                                    ]
                                )
                            ]
                        )
                }
		    
            }
        }
		
		stage('DeployToProduction') {
            
            when {
                branch 'master'
            }
            steps {
			    input 'Does staging environment looks OK?'
				milestone(1)
                withCredentials([usernamePassword(credentialsID: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]){
                    sshPublisher(
                        failOnError: true,
                        continueOnError: false,
                        publishers: [
                            sshPublishersDesc(
                                configName: 'production'
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"                                    
                                ],
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'dist/trainSchedule.zip',
                                        removePrefix: 'dist/',
                                        remoteDirectory: '/tmp',
                                        execCommand: 'sudo /usr/bin/systemctl stop train-schedule && rm -rf /opt/train-schedule/* && unzip /tmp/train-schedule.zip -d /opt/train-schedule && sudo /usr/bin/systemctl start train-schedule'
                                        )
                                    ]
                                )
                            ]
                        )
                }
            }
        }
                                 
             
        }
            
    }
