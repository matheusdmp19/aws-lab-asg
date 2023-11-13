resource "aws_security_group" "asg_lab" {

  name   = "asg-lab-sg"
  vpc_id = var.asg_vpc.id

  egress {
    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-asg-lab"
  }
}

resource "aws_security_group_rule" "cluster_ingress_ssh" {

  # Enter ip/interval for public api access. It is not recommended to leave open access to the internet.
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"

  security_group_id = aws_security_group.asg_lab.id

  type = "ingress"
}
