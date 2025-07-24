oc delete application.argoproj.io/application-groups
oc delete application.argoproj.io/management-policies
oc delete application.argoproj.io/root

oc delete  application.argoproj.io/app-group-01  
oc delete  application.argoproj.io/app-group-02

oc delete applicationset/pacman-app-01-dev-01   
oc delete applicationset/pacman-app-01-dev-02  
oc delete applicationset/pacman-app-02-dev-01 
oc delete applicationset/pacman-app-02-dev-02 
oc delete applicationset/pacman-app-03-dev-01  
oc delete applicationset/pacman-app-03-dev-02
oc delete applicationset/pacman-app-04-dev-01 
oc delete applicationset/pacman-app-04-dev-02
oc delete applicationset/pacman-app-05-dev-01 
oc delete applicationset/pacman-app-05-dev-02 
oc delete applicationset/pacman-app-06-dev-01  
oc delete applicationset/pacman-app-06-dev-02 
oc delete applicationset/pacman-app-07-dev-01  
oc delete applicationset/pacman-app-07-dev-02  
oc delete applicationset pacman-app-08-dev-01  
oc delete applicationset pacman-app-08-dev-02  
oc delete applicationset pacman-app-09-dev-01   
oc delete applicationset pacman-app-09-dev-02  
oc delete applicationset pacman-app-10-dev-01   
oc delete applicationset pacman-app-10-dev-02   

oc delete policy/pacman-app-01-project
oc delete policy/pacman-app-02-project
oc delete policy/pacman-app-03-project
oc delete policy/pacman-app-04-project
oc delete policy/pacman-app-05-project
oc delete policy/pacman-app-06-project
oc delete policy/pacman-app-07-project
oc delete policy/pacman-app-08-project
oc delete policy/pacman-app-09-project
oc delete policy/pacman-app-10-project

oc delete appproject/pacman-app-01
oc delete appproject/pacman-app-02
oc delete appproject/pacman-app-03
oc delete appproject/pacman-app-04
oc delete appproject/pacman-app-05
oc delete appproject/pacman-app-06
oc delete appproject/pacman-app-07
oc delete appproject/pacman-app-08
oc delete appproject/pacman-app-09
oc delete appproject/pacman-app-10
oc delete appproject/root

oc delete project/pacman-app-01-dev-01
oc delete project/pacman-app-01-dev-02
oc delete project/pacman-app-02-dev-01
oc delete project/pacman-app-02-dev-02
oc delete project/pacman-app-03-dev-01
oc delete project/pacman-app-03-dev-02
oc delete project/pacman-app-04-dev-01
oc delete project/pacman-app-04-dev-02
oc delete project/pacman-app-05-dev-01
oc delete project/pacman-app-05-dev-02
oc delete project/pacman-app-06-dev-01
oc delete project/pacman-app-06-dev-02
oc delete project/pacman-app-07-dev-01
oc delete project/pacman-app-07-dev-02
oc delete project/pacman-app-08-dev-01
oc delete project/pacman-app-08-dev-02
oc delete project/pacman-app-09-dev-01
oc delete project/pacman-app-09-dev-02
oc delete project/pacman-app-10-dev-01
oc delete project/pacman-app-10-dev-02
oc delete project/root

oc delete policy/admin-cluster-role -n rhacm-policies
oc delete policy/hub-resources -n rhacm-policies
oc delete policy/managed-cluster-role -n rhacm-policies
oc delete policy/managed-clusterset-bindings -n rhacm-policies
oc delete policy/ocm-placement-resources -n rhacm-policies
oc delete policy/target-resources -n rhacm-policies
