# Terraform AWS EC2 Instance with Security Group

## Purpose
This Terraform configuration provisions an **AWS EC2 instance** with the following features:
- An EC2 instance running on **Amazon Linux** (or compatible) with a specified **AMI**.
- A **Security Group** allowing HTTP traffic on port **8080**.
- A basic **user data script** to serve a simple "Hello, World" HTML page over HTTP.
- Outputs the **public IP** of the EC2 instance.

---

## Resources Created

1. **AWS Security Group** (`aws_security_group`)
   - Name: `terraform-example-instance`
   - Allows inbound **HTTP traffic on port 8080** from any IP (`0.0.0.0/0`).
   - Allows all **outbound traffic** (`protocol: -1`).

2. **AWS EC2 Instance** (`aws_instance`)
   - Instance Type: `t2.micro`.
   - AMI: `ami-0866a3c8686eaeeba` (ensure this AMI is valid for your region).
   - A **user data script** that:
     - Creates an `index.html` file with "Hello, World".
     - Starts a basic HTTP server using **busybox** on port **8080**.
   - A **Security Group** (`terraform-example-instance`) is assigned to the instance.

3. **Output**:
   - The **public IP** of the EC2 instance is outputted after creation.

---

## Variables
- **Region**: The AWS region where resources will be deployed is hardcoded to `us-east-1`.
- **AMI**: The AMI ID is specified for the instance, make sure it is a valid and available AMI for your region.
- **Key Name**: `sarav_server` - Ensure you have uploaded the appropriate key pair in AWS.

---

## Usage Instructions

1. **Initialize Terraform**:
   Run `terraform init` to initialize the working directory and download required providers.

2. **Plan the Deployment**:
   Run `terraform plan` to preview the changes Terraform will make to your infrastructure.

3. **Apply the Configuration**:
   Run `terraform apply` to apply the changes and create the resources. Terraform will ask for confirmation before proceeding.

4. **Access the Instance**:
   Once the resources are created, Terraform will output the **public IP** address of the EC2 instance. You can access the instance’s HTTP server by navigating to `http://<public_ip>:8080` in your browser.

5. **Clean Up Resources**:
   Run `terraform destroy` to destroy all resources when they are no longer needed.

---

## Notes

- **Security**: The Security Group in this configuration allows traffic from all IP addresses (`0.0.0.0/0`) on port 8080. In a production environment, restrict this to specific IPs or ranges for better security.
- **Key Pair**: Ensure the `sarav_server` key pair is already uploaded to your AWS account in the correct region.
- **AMI**: Replace the `ami-0866a3c8686eaeeba` with a valid AMI for your region if needed.

---

## Example Output

After running `terraform apply`, you will see an output like the following:

```text
public_ip = "XX.XX.XX.XX"
