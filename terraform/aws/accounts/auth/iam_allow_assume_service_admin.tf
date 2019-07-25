resource "aws_iam_group_membership" "allow_assume_service_admin" {
  name  = "allow-assume-service-admin-members"
  group = aws_iam_group.allow_assume_service_admin.name

  users = [
    aws_iam_user.terraform_cloud.name,
  ]
}

resource "aws_iam_group" "allow_assume_service_admin" {
  name = "allow-assume-service-admin"
}

resource "aws_iam_policy_attachment" "allow_assume_service_admin" {
  name       = "allow-assume-service-admin-policy-attachments"
  policy_arn = aws_iam_policy.allow_assume_service_admin.arn
  groups     = [aws_iam_group.allow_assume_service_admin.name]
}

resource "aws_iam_policy" "allow_assume_service_admin" {
  name        = "allow-assume-service-admin"
  description = "Allow the entity to assume the ServiceAdmin role"
  policy      = data.aws_iam_policy_document.allow_assume_service_admin.json
}

data "aws_iam_policy_document" "allow_assume_service_admin" {
  statement {
    sid       = "AllowAssumeAtlantis"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["arn:aws:iam::*:role/service/ServiceAdmin"]
  }
}
