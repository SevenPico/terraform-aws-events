## ----------------------------------------------------------------------------
##  Copyright 2023 SevenPico, Inc.
##
##  Licensed under the Apache License, Version 2.0 (the "License");
##  you may not use this file except in compliance with the License.
##  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
##  Unless required by applicable law or agreed to in writing, software
##  distributed under the License is distributed on an "AS IS" BASIS,
##  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
##  See the License for the specific language governing permissions and
##  limitations under the License.
## ----------------------------------------------------------------------------

## ----------------------------------------------------------------------------
##  ./cloudwatch-event/event.tf
##  This file contains code written by SevenPico, Inc.
## ----------------------------------------------------------------------------

resource "aws_cloudwatch_event_rule" "this" {
  count = module.context.enabled ? 1 : 0

  name                = module.context.id
  name_prefix         = null # don't use
  schedule_expression = var.schedule_expression
  event_pattern       = var.event_pattern
  description         = var.description
  is_enabled          = true
  tags                = module.context.tags

  # TODO
  role_arn       = null
  event_bus_name = null
}

resource "aws_cloudwatch_event_target" "this" {
  count = module.context.enabled ? 1 : 0

  rule = aws_cloudwatch_event_rule.this[0].name
  arn  = var.target_arn

  dynamic "input_transformer" {
    for_each = toset(var.transformer == null ? [] : [1])

    content {
      input_template = var.transformer.template
      input_paths    = var.transformer.paths
    }
  }
}
