def SCAN_REPOSITORY=""
def SMART_CHECK_SERVER=""
def AWS_REGION=""
def GIT_REPO=""
def GIT_CREDENTIALS=""
def DSSC_CREDENTIALS=""
def REPO_CREDENTIALS=""
def SCAN_REGISTRY=""
def BRANCH_NAME = "master"

node {
 
    cleanWs()
    stage "Checkout Code"
    sh "echo $SCAN_REPOSITORY"
    sh "printenv"
    
    checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: BRANCH_NAME]], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: '.']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: GIT_CREDENTIALS, url: GIT_REPO]]]

    stage "Build Image"
    
    sh "docker build -t $SCAN_REPOSITORY ."
    sh "printenv"
    stage "Send to Repository"
    sh "eval \$(aws ecr get-login --no-include-email --region $AWS_REGION | sed 's|https://||')"
    sh "docker tag $SCAN_REPOSITORY:latest $SCAN_REGISTRY/$SCAN_REPOSITORY:$BUILD_ID"
    sh "docker push $SCAN_REGISTRY/$SCAN_REPOSITORY:$BUILD_ID"
 
 

    stage "Smart Check"

     def SCAN_IMAGE="$SCAN_REGISTRY/$SCAN_REPOSITORY:$BUILD_ID"
     sh "echo $SCAN_IMAGE"


    withCredentials([
        usernamePassword([
            credentialsId: DSSC_CREDENTIALS,
            usernameVariable: "DSSC_USER",
            passwordVariable: "DSSC_PASSWORD",
        ])
    ]){
        withCredentials([
            usernamePassword([
                credentialsId: REPO_CREDENTIALS,
            usernameVariable: "REGISTRY_USER",
            passwordVariable: "REGISTRY_PASSWORD",
            ])
        ]){
            smartcheckScan([
                imageName: SCAN_IMAGE,
                smartcheckHost: SMART_CHECK_SERVER,
                smartcheckUser: DSSC_USER,
                smartcheckPassword: DSSC_PASSWORD,
                insecureSkipTLSVerify: true,
                findingsThreshold: new groovy.json.JsonBuilder([
                    "malware": 1,
                    "vulnerabilities": [
                        "critical": 1,
                        "high": 1,
                    ],
                    "contents": [
                        "critical": 1,
                        "high": 1,
                    ]
                ]).toString(),
                imagePullAuth: new groovy.json.JsonBuilder([
                    username: REGISTRY_USER,
                    password: REGISTRY_PASSWORD,
                ]).toString(),
            ])
        }
    }
    sh "cat "
    stage "Certify Release"
    sh "docker tag $SCAN_REPOSITORY:latest $SCAN_REGISTRY/$SCAN_REPOSITORY:$BRANCH_NAME"
    stage "Deploy to Production"

    sh "docker push $SCAN_REGISTRY/$SCAN_REPOSITORY:$BRANCH_NAME"
}
