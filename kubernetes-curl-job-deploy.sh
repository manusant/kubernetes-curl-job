#! /bin/sh

# Create config for kubernetes-curl-job.sh script
kubectl create configmap kubernetes-curl-job-script --from-file=kubernetes-curl-job.sh

# Apply Job
kubectl apply -f kubernetes-curl-job.yaml
