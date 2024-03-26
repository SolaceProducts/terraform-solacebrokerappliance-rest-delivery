provider "solacebroker" {
  username       = "admin"
  password       = "admin"
  url            = "http://localhost:8080"
  skip_api_check = true
}

resource "solacebroker_msg_vpn_queue" "myqueue" {
  msg_vpn_name = "default"
  queue_name   = "rdp_queue"
  permission   = "consume"
}

module "testrdp" {
  source = "../.."
  # version = ""

  msg_vpn_name             = "default"
  queue_name               = solacebroker_msg_vpn_queue.myqueue.queue_name
  url                      = "https://example.com"
  rest_delivery_point_name = "my_rdp"
  enabled                  = false
  client_profile_name      = "default"
  request_headers = [
    {
      header_name  = "header1"
      header_value = "$${uuid()}"
    },
    {
      header_name  = "header2"
      header_value = "value2"
    }
  ]
  protected_request_headers = [
    {
      header_name  = "protected_header1"
      header_value = "protected_value1"
    },
    {
      header_name  = "protected_header2"
      header_value = "protected_value2"
    }
  ]
}

output "rdp" {
  value = module.testrdp.rest_delivery_point
}

output "consumer" {
  value     = module.testrdp.rest_consumer
  sensitive = true
}

output "queue_binding" {
  value = module.testrdp.queue_binding
}

output "request_headers" {
  value = module.testrdp.request_headers
}

output "protected_request_headers" {
  value     = module.testrdp.protected_request_headers
  sensitive = true
}

module "testrdp2" {
  source = "../../internal/gen-template"
  # version = ""

  msg_vpn_name              = "default"
  queue_name                = solacebroker_msg_vpn_queue.myqueue.queue_name
  url                       = "HTTP://[2001:db8:3333:4444:5555:6666:7777:8888]:12345/$${msgId()}"
  rest_delivery_point_name  = "my_rdp2"
  request_headers           = module.testrdp.request_headers
  protected_request_headers = module.testrdp.protected_request_headers
}