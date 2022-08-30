output "rule_id" {
  value = try(aws_cloudwatch_event_rule.this[0].id, "")
}

output "rule_arn" {
  value = try(aws_cloudwatch_event_rule.this[0].arn, "")
}
