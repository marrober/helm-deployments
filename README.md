# Setup



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