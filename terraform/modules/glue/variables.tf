variable "database-name" {
  type        = string
  description = "The database name to use."
}
variable "read-bucket-arns" {
  type        = list(string)
  description = "The ARNs for buckets with read access."
}
variable "write-bucket-arns" {
  type        = list(string)
  description = "The ARNs for buckets with write access."
}