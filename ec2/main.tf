resource "aws_instance" "ec2_instance" {
  ami = var.image_id
  instance_type = var.instance_type
  subnet_id= var.subnet_id
  associate_public_ip_address = var.isPublic
  vpc_security_group_ids = [ var.security_group_id ]
  
  key_name = var.key_pair_name

 user_data = <<-EOF
    #!/bin/bash
    
    
    #install nginx as a reverse-proxy
    sudo yum install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    
    if [ "${var.isProxy}" == true ]; then



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
      }"  >>  /etc/nginx/conf.d/default.conf

      sudo systemctl restart nginx


    fi
  EOF

tags = {
  Name = var.instance_type
}
}