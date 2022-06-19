output "public_dns" {
  value       = aws_lb.example-lb.dns_name
  description = "The public DNS address of the Load Balancer"
}