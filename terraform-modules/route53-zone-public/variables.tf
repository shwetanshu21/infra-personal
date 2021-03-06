variable "domain" {
  type        = string
  description = "The domain to create the zone for"
}

variable "delegation_set_id" {
  type        = string
  description = "The ID of the delegation set to use for the domain"
}

variable "enable_gsuite" {
  type        = bool
  description = "Whether or not to enable gsuite domain verification"
  default     = false
}

variable "gsuite_dkim_value" {
  type        = string
  description = "The value of your gsuite dkim record. Prefix must be google."
  default     = ""
}

variable "google_site_verifications" {
  type        = list(string)
  description = "An optional list of google site verification strings"
  default     = []
}

variable "verify_ses" {
  type        = bool
  description = "Default true. Whether or not to create a domain in SES and verify it"
  default     = true
}

variable "ses_region" {
  type        = string
  description = "Default us-east-1. The region to verify SES in"
  default     = "us-east-1"
}

variable "ses_sns_arn" {
  type        = string
  description = "An SNS ARN to send SNS bounce, complaint, and delivery events to"
  default     = ""
}

variable "keybase_record_value" {
  type        = string
  description = "An optional keybase verification string, starts with keybase-site-verification="
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources"
}
