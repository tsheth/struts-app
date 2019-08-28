* Run Powershell as Admin
`aws eks update-kubeconfig --name alpaca --region=ap-southeast-1`
* Get Kubectl Context
`kubectl create serviceaccount --namespace kube-system tiller`
* Create Tiller
`kubectl create clusterrolebinding tiller-cluster-role --clusterrole=cluster-admin --serviceaccount=kube-system:tiller`
`helm init --service-account tiller`
* Run Install
`helm install --set auth.userName=bryce --set auth.password=xgen-no-virus5! --set auth.masterPassword=xgen-no-virus5! --set activationCode=KEY --name deepsecurity-smartcheck https://github.com/deep-security/smartcheck-helm/archive/master.tar.gz`
* Get IP and Login via HTTPS
`kubectl get svc proxy -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'`
* Add Registry, Filter by Lab Name