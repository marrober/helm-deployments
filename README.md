# Setup

Labels for OpenShift Clusters

Hub Cluster :
  local-cluster=true (should be already present)

Managed Clusters : 
  managed-cluster=yes

## Cluster set

Create a clusterset called 'dev-clusters' with all dev-clusters present.

## Get the ArgoCD credentials and address :

Use the information below to view the ArgoCD web UI on both the hub and the managed clusters.
````bash
oc get secret/openshift-gitops-cluster  -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d 
echo ""
oc get route/openshift-gitops-server  -n openshift-gitops -o jsonpath='{"https://"}''{.spec.host}'
echo ""
````


## ArgoCD resource definition

The below definition configures enough resources for the application controller and adds the applicationset controller.

````bash
apiVersion: argoproj.io/v1beta1
kind: ArgoCD
metadata:
  name: openshift-gitops
  namespace: openshift-gitops
spec:
  server:
    resources:
      limits:
        cpu: 4000m
        memory: 1024Mi
      requests:
        cpu: 1000m
        memory: 512Mi
    route:
      enabled: true
  sso:
    dex:
      resources:
        limits:
          cpu: 500m
          memory: 256Mi
        requests:
          cpu: 250m
          memory: 128Mi
      openShiftOAuth: true
    provider: dex
  applicationSet:
    enabled: true
  rbac:
    defaultPolicy: ''
    policy: |
      g, system:cluster-admins, role:admin
    scopes: '[groups]'
  repo:
    resources:
      limits:
        cpu: 1000m
        memory: 1024Mi
      requests:
        cpu: 250m
        memory: 256Mi
  ha:
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 250m
        memory: 128Mi
    enabled: false
  redis:
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 250m
        memory: 128Mi
  controller:
    resources:
      limits:
        cpu: 4000m
        memory: 4048Mi
      requests:
        cpu: 1000m
        memory: 2048Mi
  resourceExclusions: |
    - apiGroups:
      - tekton.dev
      clusters:
      - '*'
      kinds:
      - TaskRun
      - PipelineRun        
````

# Sync the argocd apps on the managed clusters 

## Login to ArgoCD command line 

````bash
argocd login $(oc get route/openshift-gitops-server  -n openshift-gitops -o jsonpath='{.spec.host}') --grpc-web --username admin --password $(oc get secret/openshift-gitops-cluster  -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d)
````

(Not actually needed as the apps will sync on an ArgoCD cycle)

argocd app sync openshift-gitops/cluster-1-pacman-app-01-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-01-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-02-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-02-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-03-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-03-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-04-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-04-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-05-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-05-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-06-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-06-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-07-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-07-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-08-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-08-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-09-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-09-dev-02
argocd app sync openshift-gitops/cluster-1-pacman-app-10-dev-01
argocd app sync openshift-gitops/cluster-1-pacman-app-10-dev-02

### Delete resources on the hub cluster

argocd appset delete -y openshift-gitops/pacman-app-01-dev-01
argocd appset delete -y openshift-gitops/pacman-app-01-dev-02
argocd appset delete -y openshift-gitops/pacman-app-02-dev-01
argocd appset delete -y openshift-gitops/pacman-app-02-dev-02
argocd appset delete -y openshift-gitops/pacman-app-03-dev-01
argocd appset delete -y openshift-gitops/pacman-app-03-dev-02
argocd appset delete -y openshift-gitops/pacman-app-04-dev-01
argocd appset delete -y openshift-gitops/pacman-app-04-dev-02
argocd appset delete -y openshift-gitops/pacman-app-05-dev-01
argocd appset delete -y openshift-gitops/pacman-app-05-dev-02
argocd appset delete -y openshift-gitops/pacman-app-06-dev-01
argocd appset delete -y openshift-gitops/pacman-app-06-dev-02
argocd appset delete -y openshift-gitops/pacman-app-07-dev-01
argocd appset delete -y openshift-gitops/pacman-app-07-dev-02
argocd appset delete -y openshift-gitops/pacman-app-08-dev-01
argocd appset delete -y openshift-gitops/pacman-app-08-dev-02
argocd appset delete -y openshift-gitops/pacman-app-09-dev-01
argocd appset delete -y openshift-gitops/pacman-app-09-dev-02
argocd appset delete -y openshift-gitops/pacman-app-10-dev-01
argocd appset delete -y openshift-gitops/pacman-app-10-dev-02
argocd appset delete -y openshift-gitops/pacman-app-11-dev-01
argocd appset delete -y openshift-gitops/pacman-app-11-dev-02
argocd appset delete -y openshift-gitops/pacman-app-12-dev-01
argocd appset delete -y openshift-gitops/pacman-app-12-dev-02

argocd app delete -y openshift-gitops/application-groups
argocd app delete -y openshift-gitops/cluster-1-pacman-app-01-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-01-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-02-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-02-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-03-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-03-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-04-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-04-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-05-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-05-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-06-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-06-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-07-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-07-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-08-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-08-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-09-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-09-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-10-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-10-dev-02

argocd proj delete pacman-app-01
argocd proj delete pacman-app-02
argocd proj delete pacman-app-03
argocd proj delete pacman-app-04
argocd proj delete pacman-app-05
argocd proj delete pacman-app-06
argocd proj delete pacman-app-07
argocd proj delete pacman-app-08
argocd proj delete pacman-app-09
argocd proj delete pacman-app-10
argocd proj delete root

oc delete policy -n openshift-gitops pacman-app-01-project 
oc delete policy -n openshift-gitops pacman-app-02-project
oc delete policy -n openshift-gitops pacman-app-03-project
oc delete policy -n openshift-gitops pacman-app-04-project
oc delete policy -n openshift-gitops pacman-app-05-project
oc delete policy -n openshift-gitops pacman-app-06-project
oc delete policy -n openshift-gitops pacman-app-07-project
oc delete policy -n openshift-gitops pacman-app-08-project
oc delete policy -n openshift-gitops pacman-app-09-project
oc delete policy -n openshift-gitops pacman-app-10-project 

### Delete resources on the managed cluster

argocd app delete -y openshift-gitops/cluster-1-pacman-app-01-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-01-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-02-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-02-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-03-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-03-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-04-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-04-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-05-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-05-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-06-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-06-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-07-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-07-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-08-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-08-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-09-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-09-dev-02
argocd app delete -y openshift-gitops/cluster-1-pacman-app-10-dev-01
argocd app delete -y openshift-gitops/cluster-1-pacman-app-10-dev-02

oc patch application/cluster-1-pacman-app-01-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-01-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-02-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-02-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-03-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-03-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-04-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-04-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-05-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-05-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-06-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-06-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-07-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-07-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-08-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-08-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-09-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-09-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-10-dev-01 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge
oc patch application/cluster-1-pacman-app-10-dev-02 -n openshift-gitops --patch '{"metadata":{"finalizers": null }}' --type=merge

