variable "client_id" {
  type        = string
  description = "The OAuth (Client Credentails) Client ID to be used by Data Actions"
}

variable "client_secret" {
  type        = string
  description = "The OAuth (Client Credentails) Client Secret to be used by Data Actions"
}

variable "agentless_email_fromAddress" {
  type        = string
  description = "The email adddress on behalf of which to send agentless emails. e.g. 'info@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}

variable "agentless_email_replyToAddress" {
  type        = string
  description = "The email adddress on behalf of which to use for replies to agentless emails. e.g. 'inquiries@campaigns.myemaildomain.com'. Note: you must have a previously configured Campaign/Agentless email domain."
}

variable "initial_target_customer_email" {
  type        = string
  description = "The first time that a message conversation is started it will be from an ephemeral contact (e.g new browser cookie so Genesys Cloud will not know who the message is from), so we will use this email address to send a copy of the message transcript."
}

variable "external_contact_first_name" {
  type        = string
  description = "The first name for the external contact associated with the message conversation to which the transcript should be sent."
}

variable "external_contact_last_name" {
  type        = string
  description = "The last name for the external contact associated with the message conversation to which the transcript should be sent."
}

variable "external_contact_personal_email" {
  type        = string
  description = "The email address for the external contact associated with the message conversation to which the transcript should be sent."
}