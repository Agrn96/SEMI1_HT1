output "server_node_public_ip" {
  value = try(aws_instance.ec2_node_ht1.public_ip, "")
}

output "server_python_public_ip" {
  value = try(aws_instance.ec2_python_ht1.public_ip, "")
}

output "load_balancer_url" {
  value = aws_lb.semi_load_balancer1.dns_name
}


