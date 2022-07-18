# lab02_dev_sqs_lambda
#--------------------------------------------------------------
# This terraform template deploys a main SQS queue which will 
# trigger a Lambda function.
#--------------------------------------------------------------


# Creates lambda function
resource "aws_lambda_function" "lambda_pdp_test" {
  filename         = "${path.module}/lambda/lambda_pdp_test/target/lambda.zip"
  function_name    = "lambda_pdp_test"
  description      = "A description of my functionA"
  role             =  aws_iam_role.lambda_role.arn
  handler          = "com.mydeveloperplanet.myawslambdajavaplanet.LambdaJava::handleRequest"
  runtime          = "java11"
  #source_code_hash = filebase64sha256("pdp_poc.zip")
# source_code_hash = data.archive_file.demo_lambda_zip.output_base64sha256
  depends_on       = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

/*s3_bucket = "my-bucket-name"
  s3_key    = "my-function.zip"

  environment {
    variables = {
      "foo" = "bar"
    }
  }

  timeout     = 60
  memory_size = 512*/
}




# Creates lambda IAM role.

resource "aws_iam_role" "lambda_role" {
name   = "Spacelift_Test_Lambda_Function_Role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

# Add IAM Policy
resource "aws_iam_policy" "iam_policy_for_lambda" {
 
 name         = "aws_iam_policy_for_terraform_aws_lambda_role"
 path         = "/"
 description  = "AWS IAM Policy for managing aws lambda role"
 policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

# Attaches the policy to the IAM role
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
 role        = aws_iam_role.lambda_role.name
 policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
}



# Creates the CloudWatch Log group which will contain the Lambda logs
resource "aws_cloudwatch_log_group" "example" {
  name = "/aws/lambda/${aws_lambda_function.lambda_pdp_test.function_name}"
}

