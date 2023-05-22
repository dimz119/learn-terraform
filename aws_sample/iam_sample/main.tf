provider "aws" {
  region = "us-west-2"
}

resource "aws_iam_user" "devloper1" {
  name = "devloper1"
  path = "/system/"
}

resource "aws_iam_group" "developer_group" {
  name = "developer"
  path = "/system/"
}

resource "aws_iam_group_membership" "developer_membership" {
  name = "developer_membership"

  users = [
    aws_iam_user.devloper1.name,
  ]

  group = aws_iam_group.developer_group.name
}

resource "aws_iam_policy" "developer_policy" {
  name        = "developer_policy"
  path        = "/system/"
  description = "developer policy"
  #   policy      = file("developer_policy.json")

  # Heredoc syntax
  policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
    "Action": [
        "s3:ListAllMyBuckets"
    ],
    "Effect": "Allow",
    "Resource": "*"
    }
]
}
EOF
}


resource "aws_iam_group_policy_attachment" "developer_group_policy_attachment" {
  group      = aws_iam_group.developer_group.name
  policy_arn = aws_iam_policy.developer_policy.arn
}
