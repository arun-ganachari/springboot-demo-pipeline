node {
  stage("Clone the project") {
    git branch: 'master', url: 'https://github.com/arun-ganachari/springboot-demo-pipeline.git'
  }

  stage("Compilation") {
    sh "mvn clean install -DskipTests"
  }

  stage("Tests and Deployment") {
    stage("Runing unit tests") {
      sh "mvn test -Punit"
    }
    stage("Deployment") {
      sh 'nohup mvn spring-boot:run &'
    }
  }
}
