# Create the argocd instance using the command : 

````bash
oc apply -k pacman-01/config/
````

## Get the route and secret :

````bash
oc get route/pacman-01-argocd-server  -n pacman-01-argocd -o jsonpath='{"https://"}{.spec.host}{"\n"}'
oc get secret/pacman-01-argocd-cluster -n pacman-01-argocd -o jsonpath='{.data.admin\.password}'| base64 -d 
echo ""
````