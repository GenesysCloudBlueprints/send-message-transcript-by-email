resource "genesyscloud_integration_action" "fetch_external_contact" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  config_response {
    success_template = "$${rawResult}"
  }
  contract_input  = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "type" = {
	  	  	  "description" = "The type of this identifier",
	  	  	  "enum" = [
	  	  	  	  "Phone",
	  	  	  	  "Email",
	  	  	  	  "Cookie",
	  	  	  	  "SocialWhatsapp",
	  	  	  	  "SocialTwitter",
	  	  	  	  "SocialFacebook",
	  	  	  	  "SocialLine"
	  	  	  ],
	  	  	  "type" = "string"
	  	  },
	  	  "value" = {
	  	  	  "description" = " The string value of the identifier. Will vary in syntax by type.",
	  	  	  "type" = "string"
	  	  }
	  },
	  "required" = [
	  	  "type",
	  	  "value"
	  ],
	  "type" = "object"
  })
  contract_output = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "firstName" = {
	  	  	  "type" = "string"
	  	  },
	  	  "id" = {
	  	  	  "type" = "string"
	  	  },
	  	  "lastName" = {
	  	  	  "type" = "string"
	  	  }
	  },
	  "type" = "object"
  })
  secure          = false
  config_request {
    request_template     = "$${input.rawRequest}"
    request_type         = "POST"
    request_url_template = "/api/v2/externalcontacts/identifierlookup"
  }
}