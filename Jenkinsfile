node {
  stage("Clone the project") {
    git branch: 'master', url: 'https://github.com/arun-ganachari/springboot-demo-pipeline.git'
  }

  stage("Compilation") {
    // sh "mvn clean install -DskipTests"
     bat 'mvn clean install -DskipTests'
  }

  stage("Tests and Deployment") {
    stage("Runing unit tests") {
      // sh "mvn test -Punit"
      bat 'mvn test -Punit'
    }
    stage("Deployment") {
      // sh 'nohup mvn spring-boot:run &'
      // bat 'start /B mvn spring-boot:run'
      
      //works
      // bat 'mvn spring-boot:run'
      // sleep(time: 30, unit: 'SECONDS')
      // bat 'curl http://localhost:8081/hello'

      // bat 'start /B mvn spring-boot:run'

      powershell '''
        Start-Process "mvn" -ArgumentList "spring-boot:run" -NoNewWindow -WindowStyle Hidden
      '''

      // Sleep for a few seconds to ensure the app has started
      sleep(time: 30, unit: 'SECONDS')
    }
  }
}
