output "presign_api_url" {
  description = "The URL to trigger the Lambda for presigned URL generation"
  value       = aws_lambda_function_url.url.function_url
}