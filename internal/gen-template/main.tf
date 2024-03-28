locals {
  tls                    = startswith(lower(var.url), "https:")
  slashSplit             = split("/", var.url)
  isIpV6HostWithPort     = length(split("]", local.slashSplit[2])) == 2
  isIpV6NoPort           = local.isIpV6HostWithPort ? false : length(split(":", local.slashSplit[2])) > 2
  address                = local.isIpV6NoPort ? join(local.slashSplit[2], ["[", "]"]) : local.slashSplit[2]
  hostPortSplit          = local.isIpV6HostWithPort || local.isIpV6NoPort ? split("]:", trimprefix(local.address, "[")) : split(":", local.address)
  host                   = trimsuffix(local.hostPortSplit[0], "]")
  port                   = length(local.hostPortSplit) == 2 ? tonumber(local.hostPortSplit[1]) : (local.tls ? 443 : 80)
  path                   = "/${join("/", slice(local.slashSplit, 3, length(local.slashSplit)))}"
  headers_list           = tolist(var.request_headers)
  protected_headers_list = tolist(var.protected_request_headers)
}

resource "solacebroker_msg_vpn_rest_delivery_point" "main" {
  msg_vpn_name             = var.msg_vpn_name
  rest_delivery_point_name = var.rest_delivery_point_name
  enabled                  = var.enabled

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_rest_consumer" "main" {
  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  enabled                  = solacebroker_msg_vpn_rest_delivery_point.main.enabled
  rest_consumer_name       = var.rest_consumer_name != null ? var.rest_consumer_name : "consumer"
  remote_host              = local.host
  remote_port              = local.port
  tls_enabled              = local.tls

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding" "main" {
  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = var.queue_name
  post_request_target      = local.path

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header" "main" {
  count = length(local.headers_list)

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main.queue_binding_name

  header_name  = local.headers_list[count.index].header_name
  header_value = local.headers_list[count.index].header_value
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header" "main" {
  count = length(local.protected_headers_list)

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main.queue_binding_name

  header_name  = local.protected_headers_list[count.index].header_name
  header_value = local.protected_headers_list[count.index].header_value
}
