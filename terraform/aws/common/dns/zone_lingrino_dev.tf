module "zone_lingrino_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "lingrino.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite        = true
  keybase_record_value = "keybase-site-verification=PdlLnMY9_7NaKjiMSMJ--QQXQaSHTFwb4sVmVBVT0bc"
  gsuite_dkim_value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyRi4TbeyZb+hMwV586JcQM9vetlu1wh/aB+WowPA3zS1kCr1pD3tEsW95hZ24H8/B9q0gRsrK1rZuJESLFraPPv47k2Qds+HMDDCcyC89pGeFEJ9UHbBvxmAvPvb/hjLzQMS68rx94Ag+hro119XpIkD1/B0Gd99/4OGSupQG54U4O2gnymZjWepGLDa0eFXKpolc3U+3xnHIte52Ee4E8CWYBNZ3wOWw6j2guzTNill1ecPBpSrGzaJ7EMhWbDdwjnI3aPLmCoqu/zsJUDSEE8Pbphi2ddsoO7vqOeiVYlSlmZYPsiJBxQuRzXWO+6W4hxC9Ukf5TxpFNkY8qRalQIDAQAB"
  google_site_verifications = [
    "google-site-verification=tqnkU2jHbxBeuUO8eQd90P_6bMwKletm5F6vgLu15xc",
    "google-site-verification=vxDuPgFxbbnn0WDnOzSZVz2zzv_rZr6EUegsu2gF6KY",
  ]

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}
