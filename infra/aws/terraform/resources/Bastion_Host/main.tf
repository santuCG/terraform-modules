resource "aws_subnet" "main" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = var.vpc_id
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id     = var.vpc_id
}
resource "aws_instance" "main" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    volume_size           = var.disk_size
    delete_on_termination = var.delete_on_termination
  }
  # tags = var.tags
}                  