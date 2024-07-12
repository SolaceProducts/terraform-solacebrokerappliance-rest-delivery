# Copyright 2024 Solace Corporation. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Output variable definitions

output "rest_delivery_point" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point.main, null)
  description = "A REST Delivery Point manages delivery of messages from queues to a named list of REST Consumers"
}

output "rest_consumer" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main, null)
  sensitive   = true
  description = "REST Consumer objects establish HTTP connectivity to REST consumer applications who wish to receive messages from a broker"
}

output "queue_binding" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding.main, null)
  description = "A Queue Binding for a REST Delivery Point attracts messages to be delivered to REST consumers. If the queue does not exist it can be created subsequently, and once the queue is operational the broker performs the queue binding. Removing the queue binding does not delete the queue itself. Similarly, removing the queue does not remove the queue binding, which fails until the queue is recreated or the queue binding is deleted"
}

output "request_headers" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header.main, null)
  description = "A request header to be added to the HTTP request"
}

output "protected_request_headers" {
  value       = try(solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header.main, null)
  sensitive   = true
  description = "A protected request header to be added to the HTTP request. Unlike a non-protected request header, the header value cannot be displayed after it is set"
}

