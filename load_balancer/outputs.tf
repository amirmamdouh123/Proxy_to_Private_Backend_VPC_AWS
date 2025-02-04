output "lb_content" {
  value = aws_lb.ec2_load_balancer
}

output "lb_dns_name" {
  value = aws_lb.ec2_load_balancer.dns_name
  description = "The DNS name of the internal load balancer"
}