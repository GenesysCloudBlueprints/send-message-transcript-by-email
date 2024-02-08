resource "genesyscloud_integration_action" "send_agentless_email" {
  integration_id  = var.integration_id
  name            = var.action_name
  secure          = false
  category        = var.action_category
  contract_input  = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "fromAddress_email" = {
	  	  	  "default" = var.agentless_email_fromAddress,
	  	  	  "description" = "The email address of the sender.",
	  	  	  "type" = "string"
	  	  },
	  	  "fromAddress_name" = {
	  	  	  "default" = "Notifications",
	  	  	  "description" = "The name of the email sender. ",
	  	  	  "type" = "string"
	  	  },
	  	  "htmlBody" = {
	  	  	  "description" = "The Content of the message, in HTML. Links, images and styles are allowed. ",
	  	  	  "type" = "string"
	  	  },
	  	  "replyToAddress_email" = {
	  	  	  "default" = var.agentless_email_replyToAddress,
	  	  	  "description" = "The \"reply to\" email address.",
	  	  	  "type" = "string"
	  	  },
	  	  "replyToAddress_name" = {
	  	  	  "default" = "Info",
	  	  	  "description" = "The \"reply to\" name.",
	  	  	  "type" = "string"
	  	  },
	  	  "subject" = {
	  	  	  "description" = "The email subject.",
	  	  	  "type" = "string"
	  	  },
	  	  "toAddress_email" = {
	  	  	  "description" = "The recipient email address.",
	  	  	  "type" = "string"
	  	  },
	  	  "toAddress_name" = {
	  	  	  "description" = "The recipient name.",
	  	  	  "type" = "string"
	  	  }
	  },
	  "required" = [
	  	  "fromAddress_email",
	  	  "fromAddress_name",
	  	  "toAddress_email",
	  	  "toAddress_name",
	  	  "replyToAddress_email",
	  	  "replyToAddress_name",
	  	  "subject",
	  	  "htmlBody"
	  ],
	  "type" = "object"
  })
  contract_output = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "conversationId" = {
	  	  	  "description" = "The globally unique identifier for the object.",
	  	  	  "type" = "string"
	  	  }
	  },
	  "type" = "object"
  })
  config_request {
    request_template     = "{\n  \"senderType\": \"Outbound\",\n  \"fromAddress\": {\n    \"email\": \"$${input.fromAddress_email}\",\n    \"name\": \"$${input.fromAddress_name}\"\n  },\n  \"toAddresses\": [\n    {\n      \"email\": \"$${input.toAddress_email}\",\n      \"name\": \"$${input.toAddress_name}\"\n    }\n  ],\n  \"replyToAddress\": {\n    \"email\": \"$${input.replyToAddress_email}\",\n    \"name\": \"$${input.replyToAddress_name}\"\n  },\n  \"subject\": \"$${input.subject}\",\n  \"htmlBody\": \"$esc.jsonString($${input.htmlBody})\"\n}"
    request_type         = "POST"
    request_url_template = "/api/v2/conversations/emails/agentless"
  }
  config_response {
    success_template = "{\"conversationId\": $${conversationId}}"
    translation_map = {
      conversationId = "$.conversationId"
    }
    translation_map_defaults = {
      conversationId = "\"\""
    }
  }
}