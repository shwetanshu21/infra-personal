resource "aws_route53_record" "ses_txt_verification" {
  provider = aws.dns

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses.domain}"
  type    = "TXT"
  ttl     = 3600
  records = [aws_ses_domain_identity.ses.verification_token]
}

resource "aws_route53_record" "ses_dkim_verification" {
  provider = aws.dns

  for_each = toset(aws_ses_domain_dkim.ses.dkim_tokens)

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "${each.value}._domainkey.${aws_ses_domain_identity.ses.domain}"
  type    = "CNAME"
  ttl     = 3600
  records = ["${each.value}.dkim.amazonses.com"]
}

resource "aws_route53_record" "ses_mailfrom_mx_verification" {
  provider = aws.dns

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = aws_ses_domain_mail_from.ses.mail_from_domain
  type    = "MX"
  ttl     = 3600
  records = ["10 feedback-smtp.${var.ses_region}.amazonses.com"]
}

resource "aws_route53_record" "ses_mailfrom_spf_verification" {
  provider = aws.dns

  zone_id = data.aws_route53_zone.zone.zone_id
  name    = aws_ses_domain_mail_from.ses.mail_from_domain
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:amazonses.com -all"]
}
