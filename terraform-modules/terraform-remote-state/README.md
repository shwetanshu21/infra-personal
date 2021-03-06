# Module - Terraform Remote State

This module creates a terraform remote state bucket that is well protected, requires ecryption, requires `bucket-owner-full-control`, and writes access logs to a second created bucket.

Note that by default we do not create a DynamoDB Lock Table in this module because you should instead create the lock table in every account that you will be running terraform in. If you are only using one AWS account you can set `var.create_lock_table` to `true`.

## Usage

The below code is a simple way of calling the module.

```terraform
module "remote_state" {
  source = "../path/to/module/terraform-remote-state//"

  name_prefix = "terraform-remote-state"

  tags = var.tags
}
```

After all resources are created you can write state to them with a configuration like this.

```terraform
terraform {
  backend "s3" {
    region         = "us-east-1"
    bucket         = "state-bucket-name"
    key            = "aws/terraform.tfstate"
    dynamodb_table = "TerraformRemoteStateLock"
    acl            = "bucket-owner-full-control"
    encrypt        = "true"
  }
}
```
