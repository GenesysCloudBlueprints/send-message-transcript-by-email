variable "action_name" {
  type        = string
  description = "Name to associate with action"
}

variable "action_category" {
  type        = string
  description = "Action category to associate with action"
}

variable "integration_id" {
  type        = string
  description = "ID of the integration this action is associated with"
}

variable "agentless_email_fromAddress" {
  type        = string
  description = "The email adddress on behalf of which to send agentless emails. e.g. 'info@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}

variable "agentless_email_replyToAddress" {
  type        = string
  description = "The email adddress on behalf of which to use for replies to agentless emails. e.g. 'inquiries@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}