# Input variable definitions

# Required variables

variable "msg_vpn_name" {
  description = "The name of the Message VPN"
  type        = string
}

variable "url" {
  description = "The URL that the messages should be delivered to. The path portion of the URL may contain substitution expressions"
  type        = string
  validation {
    condition     = can(regex("https?://.*", lower(var.url)))
    error_message = "The URL must be a valid URL"
  }
}

variable "rest_delivery_point_name" {
  description = "The name of the REST Delivery Point"
  type        = string
}

variable "queue_name" {
  description = "The name of the queue to bind to. The REST Delivery Point must have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to #rdp/<rdp-name> or the queue’s permissions for non-owner clients must be set to at least `consume` level access"
  type        = string
}

# Optional variables

variable "enabled" {
  description = "Enable or disable the REST Delivery Point and the underlying REST Consumer"
  type        = bool
  default     = true
}

variable "rest_consumer_name" {
  description = "The name of the REST Consumer"
  type        = string
  default     = null
}

#AutoAddAttributes

variable "request_headers" {
  description = "Request headers to be added to the HTTP request"
  type = set(object({
    header_name  = string
    header_value = optional(string)
  }))
  default = []
}

variable "protected_request_headers" {
  description = "Request headers to be added to the HTTP request"
  type = set(object({
    header_name  = string
    header_value = optional(string)
  }))
  default   = []
  sensitive = true
}
