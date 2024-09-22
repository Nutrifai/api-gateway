# NutrifAI - API Gateway
This repository includes the code for setting up an HTTP API Gateway and a Lambda function that serves as an authorizer, verifying user authentication and ensuring they have the necessary permissions to access data from the application's backend.

**Environment variables:**

- **AWS_ACCESS_KEY_ID=**AWS access key ID.
- **AWS_SECRET_ACCESS_KEY=**AWS secret access key.

**Deploy:**

```bash
 terraform apply -var-file="./variables/dev.tfvars"
```