/*
  Create a Data Action integration
*/
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Send Message Transcript by Email Data Actions"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

/*
  Create a Get Message Transcript from Recording Data Action
*/
module "get_message_transcript_data_action" {
  source             = "./modules/actions/get-message-transcript-from-recording"
  action_name        = "Get Message Transcript from Recording"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*
  Create a Get External Contact Id for Customer Participant v2 Data Action
*/
module "get_external_contact_id_data_action" {
  source             = "./modules/actions/get-external-contact-id"
  action_name        = "Get External Contact Id for Customer Participant v2"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*
  Create a Fetch External Contact by Identifier Data Action
*/
module "fetch_external_contact_data_action" {
  source             = "./modules/actions/fetch-external-contact-by-identifier"
  action_name        = "Fetch External Contact by Identifier"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*
  Create a Merge External Contacts Data Action
*/
module "merge_external_contacts_data_action" {
  source             = "./modules/actions/merge-external-contacts"
  action_name        = "Merge External Contacts"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
  depends_on         = [module.data_action]
}

/*
  Create a Send Agentless Email (HTML) Data Action
*/
module "send_agentless_email_data_action" {
  source                          = "./modules/actions/send-agentless-email"
  action_name                     = "Send Agentless Email (HTML)"
  action_category                 = "${module.data_action.integration_name}"
  integration_id                  = "${module.data_action.integration_id}"
  agentless_email_fromAddress     = var.agentless_email_fromAddress
  agentless_email_replyToAddress  = var.agentless_email_replyToAddress
  depends_on                      = [module.data_action]
}

/*   
   Configures the architect flow
*/
module "archy_flow" {
  source                        = "./modules/flow"
  workflow_name                 = "Send Message Transcript to Customer by Email"
  common_module_name            = "Resolve Contact"
  inbound_message_flow_name     = "Message Conversation with Transcript Sent by Email"
  fromAddress_email             = var.agentless_email_fromAddress
  replyToAddress_email          = var.agentless_email_replyToAddress
  data_action_category          = module.data_action.integration_name
  send_agentless_email          = module.send_agentless_email_data_action.action_name
  get_message_transcript        = module.get_message_transcript_data_action.action_name
  fetch_external_contact        = module.fetch_external_contact_data_action.action_name
  get_external_contact_id       = module.get_external_contact_id_data_action.action_name
  merge_external_contacts       = module.merge_external_contacts_data_action.action_name
  initial_target_customer_email = var.initial_target_customer_email

  depends_on        = [
    module.data_action, 
    module.get_message_transcript_data_action, 
    module.get_external_contact_id_data_action, 
    module.fetch_external_contact_data_action, 
    module.merge_external_contacts_data_action,
    module.send_agentless_email_data_action
  ]
}

/*   
   Configures the process automation trigger
*/
resource "genesyscloud_processautomation_trigger" "Send_Message_Transcript_to_Customer" {
  name           = "Send Message Transcript to Customer"
  description    = "Runs when a message conversation closes."
  topic_name     = "v2.detail.events.conversation.{id}.customer.end"
  enabled        = true
  match_criteria = "[{\"jsonPath\":\"mediaType\",\"operator\":\"Equal\",\"value\":\"MESSAGE\"}]"
  target {
    id   = module.archy_flow.workflow_id
    type = "Workflow"
  }
  depends_on     = [module.archy_flow]
}

/*   
   Configures the external contact
*/
resource "genesyscloud_externalcontacts_contact" "contact" {
  first_name      = var.external_contact_first_name
  last_name       = var.external_contact_last_name
  personal_email  = var.external_contact_personal_email
}

/*   
   Configures the web deployment configuration
*/
module "web_config" {
  source      = "./modules/webdeployments_configuration"
}

/*   
   Configures the web deployment
*/
module "web_deploy" {
  source      = "./modules/webdeployments_deployment"
  flowId      = module.archy_flow.inbound_message_flow_id
  configId    = module.web_config.config_id
  configVer   = module.web_config.config_ver
}




