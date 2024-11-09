node {
  stage("Clone the project") {
    git branch: 'master', url: 'https://github.com/arun-ganachari/springboot-demo-pipeline.git'
  }

  stage("Compilation") {
    // Use bat instead of sh for Windows
    bat 'mvnw.cmd clean install -DskipTests'
  }

  stage("Tests and Deployment") {
    stage("Running unit tests") {
      // Use bat for Windows
      bat 'mvnw.cmd test -Punit'
    }
    stage("Deployment") {
      // Use bat for Windows, run in background using start /B
      bat 'start /B mvnw.cmd spring-boot:run'
    }
  }
}
