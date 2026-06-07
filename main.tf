# call the s3 bucket module
module "my_bucket" {
  source           = "git::https://github.com/pengchao2022/aws-terraform-modules.git//modules/s3?ref=s3-1.6"
  bucket_name      = "maxwell-presign-url-2027"
  enable_website   = false # keep is private and block public
}

# create lambda role
resource "aws_iam_role" "lambda_exec" {
  name = "s3-presign-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "lambda.amazonaws.com" } }]
  })
}

# give lambda the access to this pre-sign bucket
resource "aws_iam_role_policy" "lambda_s3_policy" {
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:GetObject"
      Resource = "${module.my_bucket.bucket_arn}/*"
    },
    {
        # if bucket is encrypted then need decrypt
        Effect   = "Allow"
        Action   = ["kms:Decrypt"]
        Resource = "*" 
      }
    ]
  })
}

# 4. 部署 Lambda
resource "aws_lambda_function" "presigner" {
  filename      = "lambda.zip"
  function_name = "s3-presigner-v2"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  # lambda will update when zip file code changed 
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = { BUCKET_NAME = module.my_bucket.bucket_name }
  }
}

# create pre-signed URL 
resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.presigner.function_name
  authorization_type = "NONE"
}