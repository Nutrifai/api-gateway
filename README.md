# NutrifAI - API Gateway and Lambda Session Authorizer
This repository includes the code for setting up an HTTP API Gateway and a Lambda function that serves as an authorizer, verifying user authentication and ensuring they have the necessary permissions to access data from the application's backend.

1. **API Gateway REST**: A REST API using AWS API Gateway.
2. **Lambda Session Authorizer**: A Lambda function responsible for authenticating user sessions.

Both modules are deployed using **Terraform** and can be configured locally before deployment to AWS.

## Endpoints

### Login

- **Method**: `POST`
- **Path**: `/login`
- **Description**: Handle the login request.
- **Example Request Body**:
```json
{
"userId": "user",
"password": "12345678"
}
```
- **Example Response Header**:
```json
{
  "Set-Cookie": "sessionId=b23776c9471d38da472920894e85d635; HttpOnly; SameSite=Strict; Path=/; Secure; Max-Age=28800",
  "X-Amzn-Trace-Id": "Root=1-67324a75-ffcb37fd5cdeaed5fdef28a0;Parent=68be737886bfb158;Sampled=0;Lineage=1:76aa7eef:0"
}
```
----
### Register

- **Method**: `POST`
- **Path**: `/register`
- **Description**: Handle the user registration request.
- **Example Request Body**:
```json
{
  "userId": "user",
  "email": "user@gmail.com",
  "password": "12345678",
  "isNutri": true, 
  "profilePicPath": "www.google.com"
}
```
- **Example Response Header**:
```json
{
  "Set-Cookie": "sessionId=c19d3720fc300b0ecf57c70bc71fd24e; HttpOnly; SameSite=Strict; Path=/; Secure; Max-Age=28800",
  "X-Amzn-Trace-Id": "Root=1-67324ad1-bfcb7da9e0380f3f3ed209e9;Parent=627c6157d9f55675;Sampled=0;Lineage=1:76aa7eef:0"
}
```
----
### Logout

- **Method**: `POST`
- **Path**: `/logout`
- **Description**: Handle the user logout request.
- **Example Request Header**:
```json
Cookie:sessionId=1b9ba95110f586136b4a77592a9e9e40
```
- **Example Response Header**:
```json
{
  "Set-Cookie": "sessionId=deleted; HttpOnly; SameSite=Strict; Path=/; Secure; Max-Age=-1",
  "X-Amzn-Trace-Id": "Root=1-67324b15-0cbec37d786536b470b50f36;Parent=1e8d2534f7577182;Sampled=0;Lineage=1:76aa7eef:0"
}
```
----
### Get Diets

- **Method**: `GET`
- **Path**: `/diets`
- **Description**: Retrieve a list of diets linked to the userId
- **Example Request Body**:
```json

```
----
### Get Diets by ID

- **Method**: `GET`
- **Path**: `/diets/{dietId}`
- **Description**: Retrieve a specific diet by its Id.
- **Example Request Body**:
```json

```
----
### Post Diets

- **Method**: `POST`
- **Path**: `/diets`
- **Description**: Generate a new diet linked to the userId
- **Example Request Body**:
```json

```
----
### Get Nutritionists

- **Method**: `GET`
- **Path**: `/nutritionists`
- **Description**: Retrieve a list of nutritionists, all users with the value `is_nutri` as `true`
- **Example Response Body**:
```json
[
  {
    "email": "teste@gmail.com",
    "isNutri": true,
    "userId": "teste",
    "profilePicPath": "www.google.com"
  }
]
```

- **Query String Params**: withAppointment `/nutritionists?withAppointment=true`
- **Example Response Body**:
```json
[
  {
    "email": "teste@gmail.com",
    "isNutri": true,
    "userId": "teste",
    "profilePicPath": "www.google.com",
    "appointments": [
      {
        "patientId": "1",
        "nutriId": "user",
        "appointmentId": "0309d494-26fe-424d-97b3-19ab614a21b2",
        "appointmentDate": "09/11/2024"
      }
    ]
  }
]
```
----
### Book Nutritionist Appointment

- **Method**: `POST`
- **Path**: `/nutritionist/{nutriId}/appointments`
- **Description**: Book an appointment with a nutritionist
- **Example Request Body**:
```json
{
  "appointmentDate": "09/11/2024",
  "patientId": "1"
}
```
- **Example Response Body**:
```json
[
  {
    "patientId": "1",
    "nutriId": "nutriId",
    "appointmentId": "8b2772c4-34cc-4290-9ac2-861d531852d7",
    "appointmentDate": "09/11/2024"
  }
]
```
----
### Get all Nutritionist Appointment

- **Method**: `GET`
- **Path**: `/appointments`
- **Description**: Get all appointments of all nutritionists
- **Example Response Body**:
```json
[
  {
    "patientId": "1",
    "nutriId": "user",
    "appointmentId": "0309d494-26fe-424d-97b3-19ab614a21b2",
    "appointmentDate": "09/11/2024"
  },
  {
    "patientId": "2",
    "nutriId": "user",
    "appointmentId": "8b2772c4-34cc-4290-9ac2-861d531852d7",
    "appointmentDate": "10/11/2024"
  }
]
```
----
### Update an Nutritionist Appointment

- **Method**: `PUT`
- **Path**: `/nutritionists/<nutriId>/appointments/<appointmentId>`
- **Description**: Update an appointment with a nutritionist
- **Example Request Body**:
```json
{
  "appointmentDate": "09/11/2024"
}
```
- **Example Response Body**:
```json
[
  {
    "patientId": "1",
    "nutriId": "user",
    "appointmentId": "0309d494-26fe-424d-97b3-19ab614a21b2",
    "appointmentDate": "09/11/2024"
  }
]
```
----
### Update an Nutritionist Appointment using session data

- **Method**: `PUT`
- **Path**: `/nutritionists/<nutriId>/appointments/<appointmentId>/book`
- **Headers**: `Cookie:sessionId=id`
- **Description**: Update an appointment using session data
- **Example Request Body**:
```json
{}
```
- **Example Response Body**:
```json
[
  {
    "appointmentTime": "15:41:00",
    "patientId": "isa",
    "nutriId": "ana",
    "appointmentId": "7cbd08d9-5c06-417a-976f-afe63a4284bf",
    "appointmentDate": "2024-11-17"
  }
]
```
----
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
