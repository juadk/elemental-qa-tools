
output "rancher_server_url" {
  value = module.rancher_common.rancher_url
}

output "rancher_node_ip" {
  value = digitalocean_droplet.rancher_server.ipv4_address
}
