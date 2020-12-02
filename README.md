# kubernetes-curl-job

Kubernetes Job to execute a curl request against a protected API and post execution status to a Slack channel

## Cron In Your Cluster

Technologies change, infrastructure and codebases change, but cron has been basically the same since its initial release from almost 50 years ago in in 1975! Modern cron is mostly done with Vixie cron, first created in 1987.

For most teams, cron jobs are useful for periodic and recurring tasks, like batch emails or running backups. They also support more fine-tuned scheduling to run tasks at a specific time, such as every Sunday night to trigger a script to email people about their upcoming week.

For those that have migrated to Kubernetes, a new iteration of cron is now available. With this option, we can manage cron tasks within our existing running clusters with infrastructure-as-code on our side. Plus, we can utilize containers to have clean installs and stable program environments embedded in immutable Docker images.

>Cron + K8s + Immutable Images = Happy Cron Jobs

## How Kubernetes Cron is this better than regular cron?
Suppose you don’t want to run this once a month anymore, but rather every minute. All you need to change is the schedule property to `*/1 * * * *` to make the job run every minute directly from your Kubernetes dashboard.

## How to deploy this cron job

* First take a look in the job definition file *kubernetes-curl-job.yaml* and provide your own configurations or adapt the script according to your own needs.

* Deploy a config-map with the content of the script

```
kubectl create configmap kubernetes-curl-job-script --from-file=kubernetes-curl-job.sh
```

* Deploy the cron-job
```
kubectl apply -f kubernetes-curl-job.yaml
```

> You can also change the execution frequency by changing the cron expression
