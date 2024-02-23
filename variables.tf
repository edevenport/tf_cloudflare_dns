variable "cloudflare_token" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type = string
}

variable "records" {
  description = "List of DNS domain records."
  type = list(object({
    hostname   = string
    ip_address = string
    type       = string
    ttl        = optional(string, "60")
    proxied    = optional(bool, false)
  }))
  default = []
}
