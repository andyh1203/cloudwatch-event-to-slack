variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cw_event_rule_name" {
  description = "Name of the Cloudwatch event rule"
  type        = string
}

variable "cw_event_rule_description" {
  description = "Description of the Cloudwatch event rule"
  type        = string
}

variable "cw_event_rule_event_pattern" {
  description = "Event pattern of the Cloudwatch event rule"
  default     = null
}

variable "cw_event_rule_schedule_expression" {
  description = "Schedule expression for the Cloudwatch event rule"
  type        = string
  default     = null
}

# variable "lambda_filename" {
#     description = "Filename containing the lambda"
#     type = string
# }

