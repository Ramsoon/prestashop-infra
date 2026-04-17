output "public_ip" {
  value = aws_instance.prestashop.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.prestashop_db.endpoint
}