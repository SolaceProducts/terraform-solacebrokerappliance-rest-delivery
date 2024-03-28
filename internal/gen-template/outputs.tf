# Output variable definitions

output "rest_delivery_point" {
  value = try(solacebroker_msg_vpn_rest_delivery_point.main, null)
}

output "rest_consumer" {
  value     = try(solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main, null)
  sensitive = true
}

output "queue_binding" {
  value = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding.main, null)
}

output "request_headers" {
  value = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header.main, null)
}

output "protected_request_headers" {
  value     = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header.main, null)
  sensitive = true
}
