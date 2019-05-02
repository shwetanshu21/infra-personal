module "site_personal" {
  source = "../../../modules/aws/static-site//"

  name_prefix = "site-personal"

  dns_names_to_zone_names = {
    "lingrino.com"    = "lingrino.com"
    "*.lingrino.com"  = "lingrino.com"
    "lingrino.dev"    = "lingrino.dev"
    "*.lingrino.dev"  = "lingrino.dev"
    "srlingren.com"   = "srlingren.com"
    "*.srlingren.com" = "srlingren.com"
  }

  tags = "${ var.tags }"
}

output "site_personal_bucket_name" {
  value = "${ module.site_personal.bucket_name }"
}

output "site_personal_distribution_id" {
  value = "${ module.site_personal.distribution_id }"
}

output "site_personal_deployer_access_key_id" {
  value = "${ module.site_personal.deployer_access_key_id }"
}

output "site_personal_deployer_secret_access_key" {
  value = "${ module.site_personal.deployer_secret_access_key }"
}
