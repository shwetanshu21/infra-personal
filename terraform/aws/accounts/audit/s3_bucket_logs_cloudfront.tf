resource "aws_s3_bucket" "logs_cloudfront" {
  bucket_prefix = "logs-cloudfront-"
  acl           = "log-delivery-write"
  force_destroy = false

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id                                     = "all-logs-cloudfront-lifecycle"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1

    expiration {
      days = "90"
    }

    noncurrent_version_expiration {
      days = "90"
    }
  }

  tags = merge(
    { "Name" = "logs-cloudfront" },
    { "description" = "Stores all of our cloudfront access logs" },
    { "service" = "logs-cloudfront" },
    var.tags
  )
}

resource "aws_s3_bucket_policy" "logs_cloudfront" {
  bucket = aws_s3_bucket.logs_cloudfront.id
  policy = data.aws_iam_policy_document.bucket_policy_logs_cloudfront.json
}

# https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-access-logs.html
data "aws_iam_policy_document" "bucket_policy_logs_cloudfront" {
  statement {
    sid    = "AllowOtherAccountsWriteACL"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", data.terraform_remote_state.organization.outputs.account_ids)
    }

    actions = [
      "s3:GetBucketAcl",
      "s3:PutBucketAcl",
    ]

    resources = [aws_s3_bucket.logs_cloudfront.arn]
  }

  statement {
    sid    = "DenyInsecureUsage"
    effect = "Deny"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = ["*"]

    resources = ["${aws_s3_bucket.logs_cloudfront.arn}/*"]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

output "bucket_logs_cloudfront_arn" {
  description = "The ARN of the logs cloudfront bucket"
  value       = aws_s3_bucket.logs_cloudfront.arn
}

output "bucket_logs_cloudfront_name" {
  description = "The name of the logs cloudfront bucket"
  value       = aws_s3_bucket.logs_cloudfront.id
}

output "bucket_logs_cloudfront_domain" {
  description = "The domain of the logs cloudfront bucket"
  value       = aws_s3_bucket.logs_cloudfront.bucket_domain_name
}
