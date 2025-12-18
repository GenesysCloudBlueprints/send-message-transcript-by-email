resource "genesyscloud_flow" "Send_Message_Transcript_to_Customer_by_Email" {
  filepath          = "${path.module}/send-message-transcript-to-customer-by-email.yaml"
  file_content_hash = filesha256("${path.module}/send-message-transcript-to-customer-by-email.yaml")
  substitutions = {
    workflow_name           = var.workflow_name
    fromAddress_email       = var.fromAddress_email
    replyToAddress_email    = var.replyToAddress_email
    data_action_category    = var.data_action_category
    send_agentless_email    = var.send_agentless_email
    get_message_transcript  = var.get_message_transcript
    common_module_name      = var.common_module_name
  }
  depends_on = [ genesyscloud_flow.Resolve_Contact ]
}

resource "genesyscloud_flow" "Resolve_Contact" {
  filepath          = "${path.module}/resolve-contact.yaml"
  file_content_hash = filesha256("${path.module}/resolve-contact.yaml")
  substitutions = {
    common_module_name      = var.common_module_name
    data_action_category    = var.data_action_category
    fetch_external_contact  = var.fetch_external_contact
    get_external_contact_id = var.get_external_contact_id
    merge_external_contacts = var.merge_external_contacts
  }
}

resource "genesyscloud_flow" "Message_Conversation_with_Transcript_Sent_by_Email" {
  filepath          = "${path.module}/message-conv-with-transcript.yaml"
  file_content_hash = filesha256("${path.module}/message-conv-with-transcript.yaml")
  substitutions = {
    inbound_message_flow_name = var.inbound_message_flow_name
    testTargetEmail           = var.initial_target_customer_email
  }
}