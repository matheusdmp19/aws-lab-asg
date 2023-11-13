resource "aws_key_pair" "asg_lab" {
  key_name   = "asg_lab"
  public_key = var.ssh_key_pair

  tags = {
    Name = "vpc-asg-lab"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  name_regex  = "^al2023-ami-2023.2.20231030.1-kernel-[0-9].[0-9]-x86_64$"
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_ssm_parameter" "asg_lab" {
  name = "/Lab/asgLab"
  type = "String"
  value = jsonencode({
    "agent" : {
      "metrics_collection_interval" : 61
    },
    "metrics" : {
      "namespace" : "ASG_Memory",
      "append_dimensions" : {
        "AutoScalingGroupName" : "$${aws:AutoScalingGroupName}",
        "InstanceId" : "$${aws:InstanceId}"
      },
      "aggregation_dimensions" : [["AutoScalingGroupName"]],
      "metrics_collected" : {
        "mem" : {
          "measurement" : [
            { "name" : "mem_used_percent", "rename" : "MemoryUtilization", "unit" : "Percent" }
          ],
          "metrics_collection_interval" : 61
        }
      }
    }
  })

  tags = {
    Name = "asg_lab"
  }
}

resource "aws_launch_template" "asg_lab" {
  name = "asg_lab"

  update_default_version = true
  iam_instance_profile {
    name = "asg_instance_profile"
  }

  image_id = data.aws_ami.amazon_linux.image_id

  instance_type = var.instance_type

  key_name = aws_key_pair.asg_lab.key_name

  vpc_security_group_ids = [aws_security_group.asg_lab.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg_lab"
    }
  }

  user_data = filebase64("${path.module}/user-data.sh")

  depends_on = [aws_iam_role.asg_role, aws_key_pair.asg_lab, aws_security_group.asg_lab]
}

resource "aws_autoscaling_group" "asg_lab" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  vpc_zone_identifier = [var.asg_subnet.id]

  launch_template {
    id      = aws_launch_template.asg_lab.id
    version = "$Default"
  }
}
