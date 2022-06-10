data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh")}"
  vars = {
    zip                       = "bits-${data.archive_file.ansible_script.output_md5}.zip"
    s3_bucket                 = "${var.s3_bucket}"
    environment               = "${var.environment}"
  }
}

resource "random_shuffle" "sni" {
  input        = "${split(",", var.subnet_ids)}"
  result_count = 1
}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${aws_security_group.inst.id}"]
  subnet_id              = "${element(random_shuffle.sni.result, 0)}"
  user_data              = "${data.template_file.user_data.rendered}"
  key_name               = "${var.key_pair}"
  iam_instance_profile   = "${aws_iam_instance_profile.iam_profile.name}"

  root_block_device {
    volume_type = "gp3"
    volume_size = "50"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = "${var.environment}"
  }
}

data "archive_file" "ansible_script" {
  type        = "zip"
  source_dir  = "${path.module}/ansible_script/"
  output_path = "ansible_script.zip"
}

resource "aws_s3_bucket_object" "ansible_script" {
  bucket = "${var.s3_bucket}"
  key    = "terraform/bits-${data.archive_file.ansible_script.output_md5}.zip"
  source = "ansible_script.zip"
  etag   = "${data.archive_file.ansible_script.output_md5}"
}


#### Example How make your local/pipeline/terraform to execute Ansible
# resource "aws_instance" "web" {

#   provisioner "remote-exec" {
#     # Install Python for Ansible Or use userdata.sh for it.
#     inline = ["cat /etc/os-release || true",
#       "cat /etc/system-release || true",
#     ]
  
#     connection {
#       type        = "ssh"
#       user        = "ec2-user"
#       host        = "${self.private_ip}"
#       private_key = "${file(var.ssh_key_private)}"
      
#     }
#   }
  
#   provisioner "local-exec" {
#     command = "ansible-playbook -u ec2-user -i '${self.private_ip},' --private-key ${var.ssh_key_private} -T 600 \"${path.module}/ansible_script/provision.yml\""
#   }
# }

