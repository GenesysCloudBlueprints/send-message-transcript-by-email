output "workflow_id" {
  value = "${genesyscloud_flow.Send_Message_Transcript_to_Customer_by_Email.id}"
}

output "common_module_flow_id" {
  value = "${genesyscloud_flow.Resolve_Contact.id}"
}

output "inbound_message_flow_id" {
  value = "${genesyscloud_flow.Message_Conversation_with_Transcript_Sent_by_Email.id}"
}