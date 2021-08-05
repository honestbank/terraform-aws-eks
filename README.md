# Terraform AWS EKS

This script build an AWS EKS cluster, comprising of:

    * 3 EKS nodes inside a private subnet
    * AWS IAM roles connected for admin users
    * Load balancer set up to faciliate external/internal access (kubectl)

## Required Inputs

This code is presented as a module, and requires the following inputs:

    * Name: Name to be allocated to the EKS cluster
    * Kubernetes Version: Version of K8s to install
    * VPC ID: AWS VPC id for a VPC to install EKS into
    * Private Subnets: A list of strings, comprising of AWS subnet Ids, used to install the EKS cluster
    * EKS Min Capacity: Min number of nodes the cluster can scale in to
    * EKS Desired Capacity: How many nodes should be running during normal operations
    * EKS Max Capacity: Max number of nodes the cluster can scale out to
    * EKS Instance Type: EC2 instance type to install K8s onto
    * Map Users: A Map used by EKS (as a ConfigMap) to allocated users to roles

## Cavaet

As this is a standalone module, it makes no effort to install or prepare a VPC. A VPC must be allocated for the tests to run. A dedicated test VPC has been set up and is the `$ run.sh` script connects to that to build.
