resource "aws_instance" "my_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install nginx -y
    cat > /var/www/html/index.html <<EOF
    <!doctype html>
    <html>
      <head>
        <title>Hello, World!</title>
      </head>
      <body>
        <h1>Hello, World!</h1>
      </body>
    </html>
    EOF
    systemctl start nginx
    EOF
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

