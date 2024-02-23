resource "aws_instance" "grafana" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.instance.id ]
  tags = {
    Name = "grafana"
  }
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update

                
                sudo apt-get install -y \
                    apt-transport-https \
                    ca-certificates \
                    curl \
                    gnupg-agent \
                    software-properties-common

                
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
                
                sudo apt-key fingerprint 0EBFCD88                
                sudo add-apt-repository \
                "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) \
                stable"
                sudo apt-get update
                sudo apt-get install -y docker-ce docker-ce-cli containerd.io
                sudo docker run -d -p 3000:3000 --name grafana grafana/grafana
                EOF
  user_data_replace_on_change = true 
}