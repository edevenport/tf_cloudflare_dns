# tf_cloudflare_dns

## Description

The `tf_cloudflare_dns` module is a work-in-progress sub-module used by the `tf_hetzner_wireguard*` modules. This module will add/remove Cloudflare proxied or unproxied `A` and `AAAA` DNS records for the specified domain name.

## Usage

`main.tf`:

```
module "cloudflare_dns" {
  source = "github.com/edevenport/tf_cloudflare_dns"

  cloudflare_token = var.cloudflare_token
  hostname         = var.hostname
  domain_name      = var.domain_name
  proxied          = var.cloudflare_https

  ipv4_address = module.infrastructure.ipv4_address
  ipv6_address = module.infrastructure.ipv6_address
}
```
