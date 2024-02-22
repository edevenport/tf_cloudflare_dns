# ------------------------------------------------------------------------------
# Providers
# ------------------------------------------------------------------------------
terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 1.7"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

# ------------------------------------------------------------------------------
# Data sources
# ------------------------------------------------------------------------------
data "cloudflare_zone" "domain" {
  name = var.domain_name
}

# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------
resource "cloudflare_record" "ipv4" {
  zone_id         = data.cloudflare_zone.domain.id
  name            = var.hostname
  value           = var.ipv4_address
  ttl             = var.proxied ? 1 : 60
  proxied         = var.proxied ? true : false
  type            = "A"
  allow_overwrite = true
}

resource "cloudflare_record" "ipv6" {
  zone_id         = data.cloudflare_zone.domain.id
  name            = var.hostname
  value           = var.ipv6_address
  ttl             = var.proxied ? 1 : 60
  proxied         = var.proxied ? true : false
  type            = "AAAA"
  allow_overwrite = true
}
