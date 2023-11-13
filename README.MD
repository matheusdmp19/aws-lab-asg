# Aws Lab - ASG

The aim of this repository is to have a terraform model to upload to an aws auto scalling group that collects memory utilization metrics from the cloud watch agent and use these metrics for memory-based scaling.

## Requirements

- terraform
- access key and secret key of aws exported as environment variable

## Setting up the environment

    terraform init

## Applying terraform

    terraform apply

## Removing the environment

    terraform destroy

## Useful commands

Format .tf files recursively

    terraform fmt --recursive

Validate resource syntaxes in files

    terraform validade

Plan changes before applying

    terraform plan
