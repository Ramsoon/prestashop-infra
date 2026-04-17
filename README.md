# Prestashop DevOps Project

This project sets up a Prestashop e-commerce site on AWS using Terraform, including an EC2 instance with Apache, PHP, and Prestashop installed via user data script.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed (version 1.x)
- [AWS CLI](https://aws.amazon.com/cli/) configured with your AWS credentials
- An S3 bucket named `prestashop-terraform-state-bucket` for state storage
- A DynamoDB table named `terraform-locks` for state locking

## Local Setup Steps

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd prestashop-devops
   ```

2. **Navigate to the Terraform directory:**
   ```
   cd terraform
   ```

3. **Create the backend resources** required for remote state:
   ```
   aws s3 mb s3://prestashop-terraform-state-bucket --region us-east-1
   aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 --region us-east-1
   ```

4. **Initialize Terraform:**
   ```
   terraform init
   ```

5. **Create a terraform.tfvars file** with your database credentials:
   ```
   db_username = "your_db_username"
   db_password = "your_db_password"
   ```

5. **Plan the deployment:**
   ```
   terraform plan
   ```

6. **Apply the changes:**
   ```
   terraform apply
   ```

7. **Access your Prestashop site:** After deployment, get the public IP from the Terraform outputs and visit `http://<public-ip>` to complete the Prestashop installation.

## Notes

- The EC2 instance uses Ubuntu 20.04 AMI.
- Security groups allow SSH (22), HTTP (80), and MySQL (3306) from anywhere (restrict in production).
- The user data script installs Prestashop 8.1.5 automatically.

## CI/CD

This project includes a GitHub Actions workflow for automated deployment on push to main branch.