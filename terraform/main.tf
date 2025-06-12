provider"aws"{
region = "us-east-1"
}
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_identity_verification_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "lambda_logging_policy" {
  name = "lambda_logging"
  role = aws_iam_role.lambda_exec_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
resource "aws_lambda_function" "identity_verification_lambda" {
  function_name = "identity_verification_lambda"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_function.handler"
  runtime       = "python3.9"
  filename      = "${path.module}/../lambda/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/lambda_function.zip")
}
