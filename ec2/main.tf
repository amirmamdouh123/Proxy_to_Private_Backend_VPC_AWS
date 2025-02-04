resource "aws_instance" "ec2_instance" {
  ami = var.image_id
  instance_type = var.instance_type
  subnet_id= var.subnet_id
  associate_public_ip_address = var.isPublic
  vpc_security_group_ids = [ var.security_group_id ]
 user_data = <<-EOF
    #!/bin/bash
    if [ "${var.isProxy}" == true ]; then

      #install nginx as a reverse-proxy
      sudo yum install -y nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx

      internal_lb_dns_name="${var.proxy_traffic_target}"


      echo "
      server {
          listen 80;
          server_name _;

          location / {
              proxy_pass http://$internal_lb_dns_name;
              proxy_set_header Host \$host;
              proxy_set_header X-Real-IP \$remote_addr;
              proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
          }
      }" 
      | sudo tee /etc/nginx/conf.d/default.conf

      sudo systemctl restart nginx


    else
      # For HTTPD Server
      sudo yum install -y nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx
    fi
  EOF

tags = {
  Name = var.instance_type
}
}