# AWS EC2 Deployment with Terraform and Jenkins

This project demonstrates how to automatically deploy EC2 instances on AWS using Terraform, with the infrastructure as code stored in a Git repository. The deployment process is automated through a Jenkins pipeline.

## Project Overview

This setup consists of the following:

1. **Terraform Configuration**: The infrastructure for creating EC2 instances on AWS is defined in `main.tf`. The configuration uses variables from `terraform.tfvars` and `variables.tf` to set up the EC2 instances.
   
2. **Jenkins Pipeline**: The Jenkins pipeline automates the entire process:
   - Clones the repository.
   - Sets up Terraform configurations.
   - Runs Terraform commands to validate, plan, and apply the infrastructure.
   - Outputs the public IP addresses of the created instances.

## Files

### 1. `main.tf`
This file contains the Terraform configuration to deploy EC2 instances based on the specifications in `terraform.tfvars`. It includes the following:

- **AWS provider**: Configures the AWS region as `ap-southeast-1`.
- **AWS Instance**: Creates EC2 instances from the `servers` variable, which is passed from `terraform.tfvars`.
- **Lifecycle**: Prevents the destruction of the instances and ignores certain changes to avoid unintended re-deployments.
- **Output**: Displays the public IP addresses of the created EC2 instances.

### 2. `terraform.tfvars`
This file contains the configuration for the EC2 instances, including:

- **name**: The instance name.
- **instance_type**: The type of EC2 instance (e.g., `t2.micro`).
- **ami_id**: The AMI ID used for the instance.
- **security_group_id**: The security group to apply to the instance.
- **key_name**: The SSH key pair to use for instance access.
- **vpc_id**: The VPC ID in which to deploy the instance.
- **subnet_id**: The subnet ID to place the instance in.
- **assign_public_ip**: Whether to assign a public IP to the instance.

### 3. `variables.tf`
Defines the `servers` variable, which specifies the configuration for each EC2 instance. The variable is a list of objects, each representing an EC2 instance configuration.

### 4. Jenkins Pipeline (`Jenkinsfile`)
The Jenkins pipeline automates the deployment process:

- **Clone Repo**: Clones the repository containing the Terraform configuration.
- **Setup Terraform**: Sets up the necessary Terraform files, ensuring `terraform.tfvars` is used.
- **Run Terraform**: Runs the Terraform commands:
  - `terraform init`: Initializes the Terraform environment.
  - `terraform validate`: Validates the configuration.
  - `terraform plan`: Previews the infrastructure changes.
  - `terraform apply`: Applies the changes to create the resources.
- **Show Outputs**: Displays the public IP addresses of the instances.

## Prerequisites

Before running the pipeline, ensure the following:

- **AWS Credentials**: Configure AWS credentials (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) for Jenkins.
- **Terraform**: Install Terraform on the Jenkins agent.
- **Jenkins**: Set up Jenkins with the necessary plugins (e.g., Git, Pipeline) and configure the repository with the correct credentials.
- **AWS Account**: Ensure you have an active AWS account with sufficient permissions to create EC2 instances.

## Setup

### 1. Configure AWS Credentials in Jenkins

Ensure that AWS credentials are configured in Jenkins:

- Go to Jenkins > Manage Jenkins > Manage Credentials.
- Add your AWS credentials (`aws-access-key-id` and `aws-secret-access-key`) for access to AWS resources.

### 2. Configure Git Credentials in Jenkins

Configure your Git credentials in Jenkins to allow cloning from the repository:

- Go to Jenkins > Manage Jenkins > Manage Credentials.
- Add your Git credentials (`git-token`).

### 3. Set Up the Git Repository

Ensure that the Terraform configuration is stored in a Git repository. The repository should contain the following files:

- `main.tf`
- `terraform.tfvars`
- `variables.tf`
- `Jenkinsfile`

### 4. Create the Jenkins Pipeline Job

Create a new Jenkins Pipeline job that will execute the deployment:

- In Jenkins, create a new pipeline job.
- In the pipeline configuration, set the repository URL (e.g., `https://github.com/HasaraDA/AWS-Jenkins-Direct-Build-Pipeline.git`).
- Add the Git credentials (`git-token`) to access the repository.
- Configure the pipeline to use the `Jenkinsfile` located in the repository.

## Usage

1. **Trigger the Jenkins Pipeline**: After configuring the pipeline, trigger it manually or automatically (e.g., using webhooks or cron jobs).
2. **Monitor the Pipeline Execution**: The pipeline will:
   - Clone the repository.
   - Set up the Terraform environment.
   - Run `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply`.
3. **Review Output**: Once the pipeline is successful, the public IP addresses of the deployed EC2 instances will be displayed in the Jenkins logs.

## Example Output

```
instance_ips = {
  "server1" = "34.240.99.18"
}
```



## Cleanup

The EC2 instances created by this Terraform configuration are protected from destruction due to the `prevent_destroy` lifecycle rule in the Terraform configuration. This ensures that instances cannot be accidentally destroyed during `terraform destroy`.

To remove the instances manually, you can either:

1. **Manually Modify the Lifecycle**:
   - Update the `main.tf` file to remove the `prevent_destroy` lifecycle block from the `aws_instance` resource.
   - Run `terraform apply` to apply the changes.
   - After applying the changes, you can run `terraform destroy` to destroy the instances.

2. **Delete the Instances Manually**:
   - Alternatively, you can manually terminate the EC2 instances through the AWS Management Console or use the AWS CLI to terminate them.

To update the lifecycle and destroy the resources, follow these steps:

1. **Edit the Terraform Configuration**:
   - Remove or comment out the `prevent_destroy` block in the `main.tf` file.

2. **Apply Changes**:
   - Run the following Terraform command to apply the updated configuration:
   
     ```bash
     terraform apply -auto-approve
     ```

3. **Destroy Resources**:
   - Once the `prevent_destroy` configuration is removed, you can run:

     ```bash
     terraform destroy -auto-approve
     ```

This will allow the EC2 instances to be destroyed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.