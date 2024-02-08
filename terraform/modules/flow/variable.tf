variable "workflow_name" {
  description = "The flow name to assign to the workflow in Architect"
}

variable "common_module_name" {
  description = "The flow name to assign to the common module flow in Architect"
}

variable "inbound_message_flow_name" {
  description = "The flow name to assign to the common module flow in Architect"
}

variable "fromAddress_email" {
  description = "The email adddress on behalf of which to send agentless emails. e.g. 'info@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}

variable "replyToAddress_email" {
  description = "The email adddress on behalf of which to use for replies to agentless emails. e.g. 'inquiries@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}

variable "initial_target_customer_email" {
  description = "The first time that a message conversation is started it will be from an ephemeral contact (e.g new browser cookie so Genesys Cloud will not know who the message is from), so we will use this email address to send a copy of the message transcript."
}

variable "data_action_category" {
  type        = string
  description = "The Data Action that is to be used in the flow."
}

variable "send_agentless_email" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "get_message_transcript" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "fetch_external_contact" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "get_external_contact_id" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}

variable "merge_external_contacts" {
  type        = string
  description = "The Data Action name that is to be used in the flow."
}