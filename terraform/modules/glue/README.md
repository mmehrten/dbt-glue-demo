Create a Glue catalog and database.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_catalog_database.source-db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |
| [aws_iam_role.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.runtime](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account-id"></a> [account-id](#input\_account-id) | The account to create resources in. | `string` | n/a | yes |
| <a name="input_app-name"></a> [app-name](#input\_app-name) | The longhand name of the app being provisioned. | `string` | n/a | yes |
| <a name="input_app-shorthand-name"></a> [app-shorthand-name](#input\_app-shorthand-name) | The shorthand name of the app being provisioned. | `string` | n/a | yes |
| <a name="input_base-name"></a> [base-name](#input\_base-name) | The base name to create new resources with (e.g. {app\_shorthand}.{region}). | `string` | n/a | yes |
| <a name="input_logs-bucket-name"></a> [logs-bucket-name](#input\_logs-bucket-name) | The bucket to write logs to. | `string` | n/a | yes |
| <a name="input_output-bucket-kms-arn"></a> [output-bucket-kms-arn](#input\_output-bucket-kms-arn) | The KMS ARN for the output bucket encryption. | `string` | n/a | yes |
| <a name="input_output-bucket-name"></a> [output-bucket-name](#input\_output-bucket-name) | The output bucket name to use. | `string` | n/a | yes |
| <a name="input_output-database-name"></a> [output-database-name](#input\_output-database-name) | The output database name to use. | `string` | n/a | yes |
| <a name="input_partition"></a> [partition](#input\_partition) | The partition to create resources in. | `string` | `"aws"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to create resources in. | `string` | n/a | yes |
| <a name="input_source-bucket-name"></a> [source-bucket-name](#input\_source-bucket-name) | The source bucket name to use. | `string` | n/a | yes |
| <a name="input_source-database-name"></a> [source-database-name](#input\_source-database-name) | The source database name to use. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources. | `map(string)` | n/a | yes |
| <a name="input_terraform-role"></a> [terraform-role](#input\_terraform-role) | The role for Terraform to use, which dictates the account resources are created in. | `string` | n/a | yes |

## Outputs

No outputs.
