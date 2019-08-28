def SCAN_REPOSITORY="trendsh-uno-grapefruit"
def SMART_CHECK_SERVER="dssc.brycehawk.com"
def AWS_REGION="ap-southeast-1"
def GIT_REPO="https://github.com/ds-amea/monaco-grapefruit"
def GIT_CREDENTIALS="jenkinsPW"
def DSSC_CREDENTIALS="smart_check_jaws_world"
def REPO_CREDENTIALS="aws_eks_username"
def SCAN_REGISTRY="650143975734.dkr.ecr.ap-southeast-1.amazonaws.com"
def S3_PATH="s3://monacode/monaco-grapefruit"
def MALWARE_THRESHOLD=0
def VULNERABILITY_THRESHOLD=0
def CONTENT_THRESHOLD=0
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
    stage "Send to S3"


    sh "aws s3 sync . $S3_PATH"
 

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
                    "malware": MALWARE_THRESHOLD,
                    "vulnerabilities": [
                        "critical": VULNERABILITY_THRESHOLD,
                        "high": VULNERABILITY_THRESHOLD,
                    ],
                    "contents": [
                        "critical": CONTENT_THRESHOLD,
                        "high": CONTENT_THRESHOLD,
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
