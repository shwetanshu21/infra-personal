module "zone_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_prod.id }"

  keybase_record_value = "keybase-site-verification=OSEFJcKRkkit1mlWF_9zDpsE0q3ocWV8AfDWtbDU6lo"

  tags = "${ var.tags }"

  providers {
    aws = "aws.prod"
  }
}

module "delegate_dev_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-delegation//"

  zone_id     = "${ module.zone_lingrino_com.zone_id }"
  domain      = "dev.lingrino.com"
  nameservers = "${ aws_route53_delegation_set.lingrino_dev.name_servers }"

  providers {
    aws = "aws.prod"
  }
}

module "zone_dev_lingrino_com" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "dev.lingrino.com"
  delegation_set_id = "${ aws_route53_delegation_set.lingrino_dev.id }"

  configure_google_domains_email_forwarding = false

  tags = "${ var.tags }"

  providers {
    aws = "aws.dev"
  }
}