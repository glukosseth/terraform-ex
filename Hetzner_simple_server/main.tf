terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.42.0"
    }
  }
}

provider "hcloud" {
  token = var.h-token
}


resource "hcloud_ssh_key" "default" {
  name       = "hetzner_key"
  public_key = file("~/.ssh/hetzner.pub")
}

resource "hcloud_server" "server" {
  name        = "alx"
  image       = "ubuntu-20.04"
  server_type = "cx31"
  location    = "nbg1"
  ssh_keys    = [hcloud_ssh_key.default.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
}
