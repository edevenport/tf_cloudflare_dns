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
resource "cloudflare_record" "main" {
  count = length(var.records)

  zone_id         = data.cloudflare_zone.domain.id
  allow_overwrite = false

  name    = var.records[count.index].hostname
  value   = var.records[count.index].ip_address
  type    = var.records[count.index].type
  proxied = var.records[count.index].proxied
  ttl     = var.records[count.index].proxied ? 1 : var.records[count.index].ttl
}
