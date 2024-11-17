resource "aws_api_gateway_rest_api" "nutrifai_api" {
  name        = "NutrifAI App API"
  description = "API defining the operations available in the NutrifAI App"
}

# LOGIN
resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_rest_api.nutrifai_api.root_resource_id
  path_part   = "login"
}

resource "aws_api_gateway_method" "login_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "login_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.login_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-login/invocations"
}

# REGISTER
resource "aws_api_gateway_resource" "register" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_rest_api.nutrifai_api.root_resource_id
  path_part   = "register"
}

resource "aws_api_gateway_method" "register_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.register.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "register_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.register.id
  http_method             = aws_api_gateway_method.register_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-login/invocations"
}

# LOGOUT
resource "aws_api_gateway_resource" "logout" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_rest_api.nutrifai_api.root_resource_id
  path_part   = "logout"
}

resource "aws_api_gateway_method" "logout_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.logout.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "logout_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.logout.id
  http_method             = aws_api_gateway_method.logout_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-login/invocations"
}

# GET DIET /diets
resource "aws_api_gateway_resource" "get_diets" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_rest_api.nutrifai_api.root_resource_id
  path_part   = "diets"
}

resource "aws_api_gateway_method" "get_diets_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.get_diets.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_diets_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.get_diets.id
  http_method             = aws_api_gateway_method.get_diets_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-diet-generator/invocations"
}

# GET DIET /diets/{dietId}
resource "aws_api_gateway_resource" "get_diet_id" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_resource.get_diets.id
  path_part   = "{dietId}"
}

resource "aws_api_gateway_method" "get_diets_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.get_diet_id.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_diets_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.get_diet_id.id
  http_method             = aws_api_gateway_method.get_diets_id_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-diet-generator/invocations"
}

# POST DIET /diets
resource "aws_api_gateway_method" "generate_diets_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.get_diets.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "generate_diets_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.get_diets.id
  http_method             = aws_api_gateway_method.generate_diets_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-diet-generator/invocations"
}

# LIST NUTRITIONIST /nutritionists
resource "aws_api_gateway_resource" "nutritionists" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_rest_api.nutrifai_api.root_resource_id
  path_part   = "nutritionists"
}

resource "aws_api_gateway_method" "nutritionists_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.nutritionists.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "nutritionists_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.nutritionists.id
  http_method             = aws_api_gateway_method.nutritionists_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-nutritionist/invocations"
}

# UPDATE appointments /nutritionists/<nutriId>/appointments/<appointmentId>
resource "aws_api_gateway_resource" "nutri_id" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_resource.nutritionists.id
  path_part   = "{nutriId}"
}

# BOOK NUTRITIONIST /nutritionists/<nutriId>/appointments
resource "aws_api_gateway_resource" "nutri_appointments" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_resource.nutri_id.id
  path_part   = "appointments"
}

resource "aws_api_gateway_method" "appointments_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.nutri_appointments.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "appointments_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.nutri_appointments.id
  http_method             = aws_api_gateway_method.appointments_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-nutritionist/invocations"
}

resource "aws_api_gateway_resource" "nutri_appointments_id" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_resource.nutri_appointments.id
  path_part   = "{appointmentsId}"
}

resource "aws_api_gateway_method" "update_nutri_appointments_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.nutri_appointments_id.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "update_appointments_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.nutri_appointments_id.id
  http_method             = aws_api_gateway_method.update_nutri_appointments_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-nutritionist/invocations"
}

# PUT /nutritionists/<nutriId>/appointments/<appointmentId>/book
resource "aws_api_gateway_resource" "nutri_appointments_book" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id
  parent_id   = aws_api_gateway_resource.nutri_appointments_id.id
  path_part   = "book"
}

resource "aws_api_gateway_method" "nutri_appointments_book_method" {
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id   = aws_api_gateway_resource.nutri_appointments_book.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "nutri_appointments_book_integration" {
  rest_api_id             = aws_api_gateway_rest_api.nutrifai_api.id
  resource_id             = aws_api_gateway_resource.nutri_appointments_book.id
  http_method             = aws_api_gateway_method.nutri_appointments_book_method.http_method
  credentials             = aws_iam_role.execution_role.arn
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:sa-east-1:${data.aws_caller_identity.current.account_id}:function:lambda-nutritionist/invocations"
}

# AUTHORIZER
resource "aws_api_gateway_authorizer" "session_authorizer" {
  name                   = "session-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.nutrifai_api.id
  authorizer_uri         = var.lambda_authorizer_invoke_arn
  authorizer_credentials = aws_iam_role.execution_role.arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.nutrifai_api.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.login.id,
      aws_api_gateway_method.login_method.id,
      aws_api_gateway_integration.login_integration.id,
      aws_api_gateway_resource.logout.id,
      aws_api_gateway_method.logout_method.id,
      aws_api_gateway_integration.logout_integration.id,
      aws_api_gateway_resource.register.id,
      aws_api_gateway_method.register_method.id,
      aws_api_gateway_integration.register_integration.id,
      aws_api_gateway_resource.get_diets.id,
      aws_api_gateway_method.get_diets_method.id,
      aws_api_gateway_integration.get_diets_integration.id,
      aws_api_gateway_resource.get_diet_id.id,
      aws_api_gateway_method.get_diets_id_method.id,
      aws_api_gateway_integration.get_diets_id_integration.id,
      aws_api_gateway_resource.nutritionists.id,
      aws_api_gateway_method.nutritionists_method.id,
      aws_api_gateway_integration.nutritionists_integration.id,
      aws_api_gateway_resource.nutri_id.id,
      aws_api_gateway_resource.nutri_appointments.id,
      aws_api_gateway_method.appointments_method.id,
      aws_api_gateway_integration.appointments_integration.id,
      aws_api_gateway_resource.nutri_appointments_id.id,
      aws_api_gateway_method.update_nutri_appointments_method.id,
      aws_api_gateway_integration.update_appointments_integration.id,
      aws_api_gateway_resource.nutri_appointments_id.id,
      aws_api_gateway_method.update_nutri_appointments_method.id,
      aws_api_gateway_integration.update_appointments_integration.id,
      aws_api_gateway_resource.nutri_appointments_id.id,
      aws_api_gateway_method.update_nutri_appointments_method.id,
      aws_api_gateway_integration.update_appointments_integration.id,
      aws_api_gateway_resource.nutri_appointments_id.id,
      aws_api_gateway_method.update_nutri_appointments_method.id,
      aws_api_gateway_integration.update_appointments_integration.id,
      aws_api_gateway_resource.nutri_appointments_book.id,
      aws_api_gateway_method.nutri_appointments_book_method.id,
      aws_api_gateway_integration.nutri_appointments_book_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.nutrifai_api.id
  stage_name    = "api"
}