data "aws_iam_policy_document" "asg_role" {
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "asg_role" {
  name               = "asg_role"
  assume_role_policy = data.aws_iam_policy_document.asg_role.json
}

resource "aws_iam_role_policy_attachment" "asg_cwa_policy" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.asg_role.name
}

resource "aws_iam_role_policy_attachment" "asg_ssm_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.asg_role.name
}

resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = "asg_instance_profile"
  role = aws_iam_role.asg_role.name
}