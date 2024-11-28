# Terraform AWS Infrastructure

## High-Level Purpose
This Terraform configuration is designed to:
- Provision an **Amazon EC2 instance**.
- Attach an **EBS volume** for persistent storage.
- Secure the instance using an **AWS Security Group**.
- Optionally deploy these resources into a custom **VPC (Virtual Private Cloud)**.

---

## Detailed Purpose by File

### `ebs_volume.tf`
Defines an **EBS volume resource** (`aws_ebs_volume`) and attaches it to the EC2 instance using an attachment resource (`aws_volume_attachment`).

#### Purpose:
- Provides **persistent block storage** for the EC2 instance.
- Commonly used for:
  - Database storage.
  - File systems.
  - Other stateful applications.

---

### `instance.tf`
Defines an **Amazon EC2 instance** (`aws_instance`).

#### Purpose:
- Deploys a virtual machine where applications or services can run.
- Configurable with:
  - Specific AMIs (Amazon Machine Images).
  - Instance types (e.g., `t2.micro`).
  - Metadata and user data scripts for initialization.

---

### `security_group.tf`
Defines one or more **AWS Security Groups** (`aws_security_group`).

#### Purpose:
- Controls **inbound and outbound traffic** for the EC2 instance.
- Examples:
  - Allow **SSH access** (port 22) for administrative purposes.
  - Open ports for **HTTP/HTTPS** (ports 80 and 443) if hosting a web application.

---

### `variables.tf`
Declares input variables (`variable` blocks) used across the configuration.

#### Purpose:
- Enables **dynamic configuration** by accepting external values, such as:
  - AWS region.
  - Instance type.
  - Volume size.
  - Other resource properties.
- Improves the **reusability** and **readability** of the Terraform code.

---

### `vpc.tf`
Defines a **VPC** (`aws_vpc`) along with supporting resources like subnets, route tables, and gateways.

#### Purpose:
- Creates an **isolated network environment** for the infrastructure.
- Ensures proper networking configurations, including:
  - Public and private subnets.
  - Internet access through gateways or NATs.

---

## Usage Instructions
1. **Initialize Terraform**:  
   Run `terraform init` to initialize the directory and download necessary providers.

2. **Plan the Deployment**:  
   Run `terraform plan` to preview the resources that will be created.

3. **Apply the Configuration**:  
   Run `terraform apply` to provision the resources defined in the `.tf` files.

4. **Variable Configuration**:  
   Ensure you provide values for all required variables, either through:
   - A `terraform.tfvars` file.
   - CLI flags (e.g., `-var`).
   - Environment variables.

5. **Clean Up Resources**:  
   Run `terraform destroy` to remove all resources when they are no longer needed.

---

## Notes
- This setup assumes all `.tf` files are in the same directory.
- Ensure your AWS credentials are properly configured before running Terraform.
- Customize the configuration as needed to fit your specific use case.
