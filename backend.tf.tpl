terraform {
  backend "s3" {
    bucket         = ${ bucket }
    key            = "global/s3/terraform.tfstate"
    region         = ${ region }
    dynamodb_table = ${ dynamodb_table }
    encrypt        = true
  }
}