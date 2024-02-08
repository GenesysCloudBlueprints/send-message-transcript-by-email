resource "genesyscloud_integration_action" "merge_external_contacts" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
#   integration_id = "${genesyscloud_integration.Genesys_Cloud_Data_Actions.id}"
#   name           = "Merge External Contacts"
  secure         = false
  config_request {
    request_template     = "$${input.rawRequest}"
    request_type         = "POST"
    request_url_template = "/api/v2/externalcontacts/merge/contacts"
  }
  config_response {
    success_template = "$${rawResult}"
  }
  contract_input  = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "sourceContactId" = {
	  	  	  "description" = "The ID of the source contact for the merge operation. Must be either an \"ephemeral\" or \"identified\" contact (not \"curated\").",
	  	  	  "type" = "string"
	  	  },
	  	  "targetContactId" = {
	  	  	  "description" = "The ID of the target contact for the merge operation. Only contacts of type \"curated\" may be the target of a merge (not ephemeral or identified).",
	  	  	  "type" = "string"
	  	  }
	  },
	  "required" = [
	  	  "sourceContactId",
	  	  "targetContactId"
	  ],
	  "type" = "object"
  })
#   category        = "Send Message Transcript by Email Data Actions"
  contract_output = jsonencode({
	  "additionalProperties" = true,
	  "properties" = {
	  	  "id" = {
	  	  	  "type" = "string"
	  	  }
	  },
	  "type" = "object"
  })
}