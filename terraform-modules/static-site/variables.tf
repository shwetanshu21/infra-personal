variable "name_prefix" {
  type        = "string"
  description = "A prefix to prepend to all 'Name' tags"
}

variable "dns_names_to_zone_names" {
  type        = "map"
  description = "A map of FQDNs to their Route53 Zone names that this site should be accessible at. Ex: ['example.com' => 'example.com', 'foo.example.com' => 'foo.example.com', '*.bar.example.com' => 'bar.example.com']"
}

variable "bucket_logs_domain" {
  type        = "string"
  description = "The domain of the S3 bucket to write logs to"
}

variable "healthcheck_sns_arn" {
  type        = "string"
  description = "The ARN of the SNS topic to notify when the configured healthcheck is unhealthy"
}

variable "tags" {
  type        = "map"
  description = "A map of tags to apply to all resources"
}