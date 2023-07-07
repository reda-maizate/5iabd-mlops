resource "aws_instance" "front" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name  # TODO: Need to create a key pair
  user_data     = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y git python3 python3-pip
              sudo git clone https://github.com/reda-maizate/5iabd-mlops.git
              cd 5iabd-mlops/web/
              sudo pip3 install -r requirements.txt
              sudo python3 streamlit run main.py --server.port=8501 --server.address=0.0.0.0
              EOF

  root_block_device {
    volume_size           = var.volume_size
    volume_type           = "gp2"
    delete_on_termination = true
  }
}