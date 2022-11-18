# Glue dbt Project

A demo project using `dbt` with AWS Glue.

## Environment Setup
### 1. Set up Terraform infra (optional)
This project includes a Terraform module which can be used to provision the required Glue resources
in any region / partition. The `terraform-infra` project creates the necessary Terraform infrastructure (s3 bucket, dynamodb table for locking, IAM roles).

Update the `params/default.tfvars` file for your region, partition, and account before running:
```
cd terraform/projects/terraform-infra
terraform apply -var-file params/default.tfvars
```

### 2. Set up Glue infra
The `glue` project can be used to create the roles, buckets, and permissions necessary to run AWS Glue with dbt.

Update the `params/default.tfvars` file and the `main.tf` backend configuration to use the backend created in step 1.
```
cd terraform/projects/glue
terraform apply -var-file params/default.tfvars
```

Then download and stage HUDI JAR files - you will need to update the bucket and region in this script to copy the JARs to your staging bucket:
```
sh hudi.sh
```

If you don't use Terraform to set up the Glue infrastructure, you'll need to set up S3 buckets for HUDI, data, and logs manually, and provision IAM roles as described in [this documentation](https://docs.aws.amazon.com/glue/latest/dg/glue-is-security.html), with read/write access to the S3 buckets you created.

### 3. Run dbt
Set the `AWS_REGION`, `GLUE_CLIENT_ROLE`, `DATA_S3_BUCKET`, `JAR_S3_BICKET`, and `LOGS_S3_BUCKET` environment variables with the infrastructure set up in step 2.

Run dbt:
```
cd dbt
dbt run --profiles-dir ..
```

## References

* [dbt-glue](https://github.com/aws-samples/dbt-glue)
* [Glue immersion day](https://catalog.us-east-1.prod.workshops.aws/workshops/ee59d21b-4cb8-4b3d-a629-24537cf37bb5/en-US/lab6/custom-connector/create-hudi-connector)
