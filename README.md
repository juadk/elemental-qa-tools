# Quickstart examples to deploy Rancher + Elemental

Quickly stand up a Rancher Manager server with Elemental on Digital Ocean.

Intended for experimentation/evaluation ONLY.

**You will be responsible for any and all infrastructure costs incurred by these resources.**
As a result, this repository minimizes costs by standing up the minimum required resources for a given provider.

## Rancher Management Server quickstart

Rancher Management Server Quickstarts are provided for:

### Cloud quickstart

- [**DigitalOcean** (`do`)](./rancher/do)

**You will be responsible for any and all infrastructure costs incurred by these resources.**

Each quickstart will install Rancher on a single-node K3s cluster, then will install the Elemental-operator in Rancher.
This setup provides easy access to the core Rancher functionality while establishing a foundation that can be easily expanded to a full HA Rancher server.

## Requirements - Cloud

- Terraform >=1.0.0
- Credentials for the cloud provider used for the quickstart

### Using cloud quickstarts

To begin with any quickstart, perform the following steps:

1. Clone or download this repository to a local folder
2. Choose a cloud provider and navigate into the provider's folder
3. Copy or rename `terraform.tfvars.example` to `terraform.tfvars` and fill in all required variables
4. Run `terraform init`
5. Run `terraform apply`

When provisioning has finished, terraform will output the URL to connect to the Rancher server.
One Kubernetes configurations will also be generated:
- `kube_config_server.yaml` contains credentials to access the cluster supporting the Rancher server

For more details on each cloud provider, refer to the documentation in their respective folders.

### Remove

When you're finished exploring the Rancher server, use terraform to tear down all resources in the quickstart.

**NOTE: Any resources not provisioned by the quickstart are not guaranteed to be destroyed when tearing down the quickstart.**
Make sure you tear down any resources you provisioned manually before running the destroy command.

Run `terraform destroy -auto-approve` to remove all resources without prompting for confirmation.

This project is mainly base on https://github.com/rancher/quickstart which cannot be modified for QA as it is used and referenced in the official Rancher Documentation.
That's why I see it as a separate project, small things have been added like deploying the elemental-operator, choosing if you want to use stable or devel Rancher version.
