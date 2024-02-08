/*
  Creates the messaging deployment and assigns the flow
*/
resource "genesyscloud_webdeployments_deployment" "Message_Deployment_for_Sending_Copy_of_Transcript_by_Email" {
  name                    = "Message Deployment for Sending Copy of Transcript by Email"
  flow_id                 = var.flowId
  status                  = "Active"
  allow_all_domains       = true
  allowed_domains         = []
  configuration {
    id      = var.configId
    version = var.configVer
  }
}
