data "aws_ami" "server_ami" {
    most_recent = true
    owners = ["099720109477"]
    filter {
         name = "name"
         values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129-*"]

}
}
resource "random_id" "my_node_id" {
    byte_length = 2
    count = var.main_instance_count
}

resource "aws_instance" "my_main" {
    count = var.main_instance_count
    instance_type = var.main_instance_type
    ami = data.aws_ami.server_ami.id
    #key_name = ""
    vpc_security_group_ids = [aws_security_group.my_sg.id]
    subnet_id = aws_subnet.my_public_subnet[0].id
    root_block_device {
          volume_size = var.main_vol_size

}

    tags = {
       Name = "my-main-${random_id.my_node_id[count.index].dec}"
       Owner = "Jana"
}
}
