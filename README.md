# Terraform AWS EKS

This Terraform Component module build an AWS EKS cluster:

    * EKS worker nodes inside a private subnet
    * AWS IAM roles connected for admin users
    * Load balancer set up to faciliate external/internal access (kubectl)

For detailed input and output variable information see the [core module readme](/eks/README.md).

## Caveats

As this is a standalone module, it makes no effort to install or prepare a VPC. A VPC must be allocated for the tests to run. A dedicated test VPC has been set up and is the `$ run.sh` script connects to that to build.
