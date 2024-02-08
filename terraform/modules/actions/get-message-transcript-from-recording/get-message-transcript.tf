resource "genesyscloud_integration_action" "get_message_transcript" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
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
	  	  "messages" = {
	  	  	  "items" = {
	  	  	  	  "type" = "string"
	  	  	  },
	  	  	  "type" = "array"
	  	  },
	  	  "purposes" = {
	  	  	  "items" = {
	  	  	  	  "type" = "string"
	  	  	  },
	  	  	  "type" = "array"
	  	  }
	  },
	  "type" = "object"
  })
  config_response {
    translation_map_defaults = {
      messageTexts = "[]"
      purposes     = "[]"
    }
    success_template = "{\"messages\": $${messageTexts}, \"purposes\": $${purposes}}"
    translation_map = {
      messageTexts = "$[0].messagingTranscript[?(@.messageText)].messageText"
      purposes     = "$[0].messagingTranscript[?(@.messageText)].purpose"
    }
  }
  secure = false
  config_request {
    request_template     = "$${input.rawRequest}"
    request_type         = "GET"
    request_url_template = "/api/v2/conversations/$${input.conversationId}/recordings"
  }
}