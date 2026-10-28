# AWS Infrastructure Provisioning with Terraform

## Project Overview

This project demonstrates the use of Terraform to provision and configure AWS infrastructure for hosting a simple Apache web server. It was built as a hands-on project to develop practical skills in Cloud Engineering, Infrastructure as Code (IaC), AWS networking, and infrastructure management.

## Architecture and Resources

The infrastructure was provisioned in the AWS Africa (Cape Town) region (`af-south-1`).

The project includes:

- **Amazon VPC:** Provides an isolated virtual network.
- **Subnet:** Hosts the network interface and web server within the VPC.
- **Internet Gateway:** Enables internet connectivity through the VPC's routing configuration.
- **Route Table and Association:** Configures routing through the Internet Gateway.
- **Security Group:** Controls inbound and outbound network traffic.
- **Network Interface:** Provides network connectivity for the EC2 instance.
- **Elastic IP:** Provides a static public IPv4 address for accessing the server.
- **Amazon EC2:** Hosts the web server.
- **Apache HTTP Server:** Serves a simple HTML page.

## Tools and Technologies

- Amazon Web Services (AWS)
- Terraform
- Git and GitHub
- Apache HTTP Server
- Linux and Bash

## Project Structure

```text
terraform-aws-infrastructure/
├── .gitignore
├── .terraform.lock.hcl
├── README.md
└── main.tf
```

### File Descriptions

- **`.gitignore`** — Specifies files and directories Git should ignore.
- **`.terraform.lock.hcl`** — Records the selected Terraform provider versions and checksums.
- **`README.md`** — Documents the project, architecture, implementation, and lessons learned.
- **`main.tf`** — Contains the Terraform configuration used to provision the AWS infrastructure.

## What I Did

1. Configured the AWS provider and Terraform resources.
2. Created a VPC and subnet.
3. Configured an Internet Gateway, route table, and route table association.
4. Set up security group rules and a network interface.
5. Provisioned an EC2 instance and associated an Elastic IP.
6. Used a startup script to install and start Apache.
7. Tested access to the web server through a browser.
8. Used Git and GitHub for version control.
9. Destroyed the Terraform-managed infrastructure after testing to avoid unnecessary ongoing resource costs.

## What I Learned

- How Terraform manages AWS infrastructure as code.
- How AWS networking components work together.
- How security group rules affect connectivity.
- How to deploy a basic web server on EC2.
- How to troubleshoot infrastructure and connectivity issues.
- Why infrastructure cleanup is an important part of cloud resource management.

## Cleanup

The Terraform-managed infrastructure was destroyed after testing. The project code remains available for review and future development.

## Security Notes

- Never commit AWS access keys, secret keys, private keys, or other credentials.
- Avoid committing Terraform state files or sensitive variable files.
- Restrict inbound access to only the IP addresses and ports required for your use case.
- Review AWS billing and resource usage after completing cloud experiments.

## Future Improvements

- Add an architecture diagram.
- Improve security rules and document design decisions.
- Explore automated validation and deployment workflows.
- Add screenshots demonstrating the successful deployment.

## Author

Cloud Engineering and DevOps learner building practical experience with AWS and Terraform.