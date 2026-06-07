# 1. 调用你之前那个仓库里的 S3 模块
module "my_bucket" {
  source           = "git::https://github.com/pengchao2022/aws-terraform-modules.git//modules/s3?ref=s3-1.6"
  bucket_name      = "maxwell-presign-url-2027"
  enable_website   = false # 保持私有
}

# 2. 创建 Lambda 执行角色
resource "aws_iam_role" "lambda_exec" {
  name = "s3-presign-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "lambda.amazonaws.com" } }]
  })
}

# 3. 授予 Lambda 读取该 Bucket 的权限
resource "aws_iam_role_policy" "lambda_s3_policy" {
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:GetObject"
      Resource = "${module.my_bucket.bucket_arn}/*"
    }]
  })
}

# 4. 部署 Lambda
resource "aws_lambda_function" "presigner" {
  filename      = "lambda.zip"
  function_name = "s3-presigner"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  # 关键：当 zip 文件内容变化时，Terraform 会自动触发 Lambda 更新
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = { BUCKET_NAME = module.my_bucket.bucket_name }
  }
}

# 5. 创建公开访问 URL
resource "aws_lambda_function_url" "url" {
  function_name      = aws_lambda_function.presigner.function_name
  authorization_type = "NONE"
}