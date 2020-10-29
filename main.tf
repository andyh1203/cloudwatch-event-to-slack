terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                = var.cw_event_rule_name
  description         = var.cw_event_rule_description
  event_pattern       = jsonencode(var.cw_event_rule_event_pattern)
  schedule_expression = var.cw_event_rule_schedule_expression
}

# resource "aws_cloudwatch_event_target" "check_foo_every_one_minute" {
#   rule      = aws_cloudwatch_event_rule.event_rule.name
#   target_id = "lambda-post-cw-event-to-slack"
#   arn       = aws_lambda_function.lambda.arn
# }

# resource "aws_lambda_permission" "allow_execution_from_cloudwatch" {
#   statement_id  = "AllowExecutionFromCloudWatch"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.lambda.function_name
# }

# resource "aws_iam_role" "iam_for_lambda" {
#   name               = "iam_for_lambda"
#   assume_role_policy = <<-EOF
#         {
#         "Version": "2012-10-17",
#         "Statement": [
#             {
#             "Action": "sts:AssumeRole",
#             "Principal": {
#                 "Service": "lambda.amazonaws.com"
#             },
#             "Effect": "Allow",
#             "Sid": ""
#             }
#         ]
#     }
#     EOF
# }

resource "aws_lambda_function" "post_to_slack" {
  filename         = var.lambda_filename
  function_name    = var.lambda_function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.lambda_handler
  runtime          = "python3.7"
  source_code_hash = filebase64sha256(var.lambda_filename)
  environment {
    variables = {
      SLACK_API_TOKEN = var.slack_webhook_url
    }
  }
}
