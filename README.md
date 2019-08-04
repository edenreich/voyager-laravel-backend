
# Complete Admin Panel PHP-Laravel-Voyager Application Including IaC Hosted on Digitalocean

This repository provide a kubernetes cluster with access to dockerhub private registry, this cluster is very minimalistic and contains only one node, you may increase it for your own need.
To do so just increase `cluster_node_count` variable.
The `src` directory will be packaged into a docker image and pushed to a dockerhub. 

Do note that the creation of the cluster on digitalocean can take up to 20min.

## Technologies

- Terraform v0.12.6
- Docker Client v18.09.6
- Kubernetes Client (kubectl v1.15.0)
- PHP v7.3.3-fpm on alpine3.8 OS

## Authentication

Before you begin you have to make sure that terraform is authenticated with digitalocean: `export TF_VAR_do_token='[digitalocean-access-token]'`.

## Deploy to Staging

1. From the root directory build and tag a docker image `docker build -t [repository]/[image]:[version] -f ops/docker/app/Dockerfile .`.
2. Push the image to a registry `docker push [repository]/[image]:[version]`.
3. Enter the terraform directory `cd ops/terraform`.
4. Download needed plugins `terraform init`.
5. Create a plan `terraform plan -out terraform.tfplan`.
6. Apply the plan `terraform apply -autoapprove`.

## Deploy to Production

1. From the root directory build and tag a docker image `docker build -t [repository]/[image]:[version] -f ops/docker/app/Dockerfile .`.
2. Push the image to a registry `docker push [repository]/[image]:[version]`.
3. Enter the terraform directory `cd ops/terraform`.
4. Download needed plugins `terraform init`.
5. Switch to production workspace `terraform workspace select production || terraform workspace new production`.
6. Create the plan `terraform plan -out terraform.tfplan`.
7. Apply the plan `terraform apply -autoapprove`.

## Client Access

Assuming you ran one of the above mentioned deployments, a configuration file of the 
cluster was downloaded from the digitalocean provider and you should have an access to the cluster.

To test it, we can issue the following command from the `ops/terraform` directory:

`kubectl --kubeconfig config/[workspace]-kubeconfig.yaml get pods,services`