resource "genesyscloud_integration_action" "get_external_contact_id" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  config_response {
    success_template = "{\"externalContactId_external\": $${successTemplateUtils.firstFromArray(\"$${customerIdArray}\", \"$esc.quote$esc.quote\")}, \"externalContactId_customer\": $${successTemplateUtils.firstFromArray(\"$${externalIdArray}\", \"$esc.quote$esc.quote\")}}"
    translation_map = {
      customerIdArray = "$.participants[?(@.purpose ==\"customer\")].externalContactId"
      externalIdArray = "$.participants[?(@.purpose ==\"external\")].externalContactId"
    }
    translation_map_defaults = {
      customerIdArray = "[\"\"]"
      externalIdArray = "[\"\"]"
    }
  }
  secure         = false
  config_request {
    request_template     = "$${input.rawRequest}"
    request_type         = "GET"
    request_url_template = "/api/v2/conversations/$${input.conversationId}"
  }
  contract_input  = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "conversationId" = {
	  	  	  "type" = "string"
	  	  }
	  },
	  "type" = "object"
  })
  contract_output = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "externalContactId_customer" = {
	  	  	  "type" = "string"
	  	  },
	  	  "externalContactId_external" = {
	  	  	  "type" = "string"
	  	  }
	  },
	  "type" = "object"
  })
}