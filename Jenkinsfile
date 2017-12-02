node {
    def app
    def project = 'project-5135657072435335305'
    def appName = 'sakib-dev-ops-demo'
    def imageTag = "gcr.io/${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        /* app = docker.build("sakib-dev-ops-demo") */
        app = docker.build("${imageTag}")


        /* sh("docker build -t ${imageTag} .") */
        /* sh 'sudo docker build -t sakib-dev-ops-demo .'*/


    }


    stage('Test image') {

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
      /*  docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
        *  app.push("${env.BUILD_NUMBER}")
        *  app.push("latest")

        } */
        sh("gcloud docker -- push ${imageTag}")
    }
}
