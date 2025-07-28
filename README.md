# Setup

Labels for OpenShift Clusters

Hub Cluster :
  local-cluster=true (should be already present)

Managed Clusters : 
  managed-cluster=yes

## Cluster set

Create a clusterset called 'dev-clusters' with all dev-clusters present.

## Get the ArgoCD credentials and address :

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

argocd login <argocd server url without https://>

(Not actually needed as the apps will sync on an ArgoCD cycle)

argocd app sync openshift-gitops/development-pacman-app-01-dev-01
argocd app sync openshift-gitops/development-pacman-app-01-dev-02
argocd app sync openshift-gitops/development-pacman-app-02-dev-01
argocd app sync openshift-gitops/development-pacman-app-02-dev-02
argocd app sync openshift-gitops/development-pacman-app-03-dev-01
argocd app sync openshift-gitops/development-pacman-app-03-dev-02
argocd app sync openshift-gitops/development-pacman-app-04-dev-01
argocd app sync openshift-gitops/development-pacman-app-04-dev-02
argocd app sync openshift-gitops/development-pacman-app-05-dev-01
argocd app sync openshift-gitops/development-pacman-app-05-dev-02
argocd app sync openshift-gitops/development-pacman-app-06-dev-01
argocd app sync openshift-gitops/development-pacman-app-06-dev-02
argocd app sync openshift-gitops/development-pacman-app-07-dev-01
argocd app sync openshift-gitops/development-pacman-app-07-dev-02
argocd app sync openshift-gitops/development-pacman-app-08-dev-01
argocd app sync openshift-gitops/development-pacman-app-08-dev-02
argocd app sync openshift-gitops/development-pacman-app-09-dev-01
argocd app sync openshift-gitops/development-pacman-app-09-dev-02
argocd app sync openshift-gitops/development-pacman-app-10-dev-01
argocd app sync openshift-gitops/development-pacman-app-10-dev-02
