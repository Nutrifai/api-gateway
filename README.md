# NutrifAI - API Gateway and Lambda Session Authorizer
This repository includes the code for setting up an HTTP API Gateway and a Lambda function that serves as an authorizer, verifying user authentication and ensuring they have the necessary permissions to access data from the application's backend.

1. **API Gateway REST**: A REST API using AWS API Gateway.
2. **Lambda Session Authorizer**: A Lambda function responsible for authenticating user sessions.

Both modules are deployed using **Terraform** and can be configured locally before deployment to AWS.

## Requirements

To use this project, ensure you have the following installed:
- [Terraform](https://www.terraform.io/downloads)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions

Ensure that your AWS credentials are configured correctly using `aws configure`

### API Gateway Module (`modules/api_gateway/`)
This module creates a REST API in API Gateway.

### Lambda Session Authorizer Module (`modules/lambda_authorizer/`)
This module creates a Lambda function to handle user session authorization.

## Instructions to Deploy Locally

### 1. Clone the repository
```bash
git clone https://github.com/Nutrifai/api-gateway.git
cd infra
```

### 2. Initialize Terraform
Before running any commands, initialize Terraform in the project directory.
```bash
terraform init
```

### 3. Plan the Deployment
Generate and review an execution plan to understand the resources that will be created or updated.
```bash
terraform plan
```

### 4. Apply the Configuration
To deploy the resources to AWS, run:
```bash
terraform apply -auto-approve
```

### Outputs
After deploying the infrastructure, Terraform will output useful information such as the API Gateway URL and Lambda function ARN. You can customize these outputs in the `outputs.tf` files.
