# Setup



## Get the ArgoCD credentials and address :

````bash
oc get secret/openshift-gitops-cluster  -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d 
echo ""
oc get route/openshift-gitops-server  -n openshift-gitops -o jsonpath='{"https://"}''{.spec.host}'
echo ""
````
