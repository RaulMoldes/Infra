INSTRUCTIONS TO DEPLOY.

1. terraform init

2. terraform apply

3. aws sts get-caller-identity

4. aws eks update-kubeconfig --region <REGION> --name <CLUSTER_NAME> --profile <PROFILE_NAME>
 aws eks update-kubeconfig --region eu-west-1 --name development-eks-cluster --profile RaulMoldes
5.kubectl get pods

KUBECTL COMMANDS

kubectl cluster-info

kubectl logs <pod-name> -n <namespace>

kubectl get pods -n <namespace>

kubectl describe node <node-name>

kubectl logs <pod-name> -n <namespace>

kubectl logs <pod-name> -c <container-name> -n <namespace>

kubectl exec -it <pod-name> -n <namespace> -- /bin/bash

kubectl get deployments -n <namespace>

kubectl describe deployment <deployment-name> -n <namespace>

kubectl set image deployment/<deployment-name> <container-name>=<new-image> -n <namespace>

kubectl scale deployment <deployment-name> --replicas=<number> -n <namespace>

kubectl delete deployment <deployment-name> -n <namespace>

kubectl get svc -n <namespace>

kubectl describe svc <service-name> -n <namespace>

kubectl delete svc <service-name> -n <namespace>

kubectl get namespaces

kubectl create namespace <namespace-name>

kubectl delete namespace <namespace-name>

kubectl get configmaps -n <namespace>

kubectl describe configmap <configmap-name> -n <namespace>

kubectl create configmap <configmap-name> --from-file=<file-path> -n <namespace>

kubectl get secrets -n <namespace>

kubectl describe secret <secret-name> -n <namespace>

kubectl create secret generic <secret-name> --from-file=<file-path> -n <namespace>

kubectl apply -f <file-path>

kubectl delete -f <file-path>

kubectl get events -n <namespace>

kubectl get events --sort-by='.metadata.creationTimestamp' -n <namespace>



