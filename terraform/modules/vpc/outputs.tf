output "subnets_id" {
    value = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
}