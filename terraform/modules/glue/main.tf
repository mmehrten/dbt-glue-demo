/*
* Create a Glue catalog and database.
*/

resource "aws_iam_role" "client" {
  name = "GlueClientRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : ["sts:AssumeRole"],
      "Effect" : "Allow",
      "Principal" : {
        "AWS" : ["arn:${var.partition}:iam::${var.account-id}:role/Admin"]
      },
      "Sid" : "AllowAdminToAssume"
      }, {
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "glue.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })

  inline_policy {
    name = "AllowGlueS3Access"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "CloudwatchMetrics",
          "Effect" : "Allow",
          "Action" : "cloudwatch:PutMetricData",
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "cloudwatch:namespace" : "Glue"
            }
          }
        },
        {
          "Sid" : "CloudwatchLogs",
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
          ],
          "Resource" : [
            "arn:${var.partition}:logs:*:*:/aws-glue/*"
          ]
        },
        {
          "Sid" : "accesstoconnections",
          "Action" : [
            "glue:GetConnection",
            "glue:GetConnections"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:connection/*"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "AllowDefaultDatabaseAccess",
          "Action" : [
            "glue:GetUserDefinedFunctions",
            "glue:CreateDatabase"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/default/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/default"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readandwritedatabases",
          "Action" : [
            "glue:SearchTables",
            "glue:BatchCreatePartition",
            "glue:CreatePartitionIndex",
            "glue:DeleteDatabase",
            "glue:GetTableVersions",
            "glue:GetPartitions",
            "glue:DeleteTableVersion",
            "glue:UpdateTable",
            "glue:DeleteTable",
            "glue:DeletePartitionIndex",
            "glue:GetTableVersion",
            "glue:UpdateColumnStatisticsForTable",
            "glue:CreatePartition",
            "glue:UpdateDatabase",
            "glue:CreateTable",
            "glue:GetTables",
            "glue:GetDatabases",
            "glue:GetTable",
            "glue:GetDatabase",
            "glue:GetPartition",
            "glue:UpdateColumnStatisticsForPartition",
            "glue:CreateDatabase",
            "glue:BatchDeleteTableVersion",
            "glue:BatchDeleteTable",
            "glue:DeletePartition",
            "glue:GetUserDefinedFunctions",
            "lakeformation:ListResources",
            "lakeformation:BatchGrantPermissions",
            "lakeformation:ListPermissions"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/${var.database-name}/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/${var.database-name}"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readonlydatabases",
          "Action" : [
            "glue:SearchTables",
            "glue:GetTableVersions",
            "glue:GetPartitions",
            "glue:GetTableVersion",
            "glue:GetTables",
            "glue:GetDatabases",
            "glue:GetTable",
            "glue:GetDatabase",
            "glue:GetPartition",
            "lakeformation:ListResources",
            "lakeformation:ListPermissions"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/${var.database-name}/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/${var.database-name}",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/default",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/global_temp"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Storageallbuckets",
          "Action" : [
            "s3:GetBucketLocation",
            "s3:ListBucket"
          ],
          "Resource" : concat(var.read-bucket-arns, var.write-bucket-arns),
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readandwritebuckets",
          "Action" : [
            "s3:*Object",
            "s3:PutObjectAcl",
            "s3:*Multipart*",
            "kms:GenerateDataKey",
            "kms:Decrypt",
            "kms:Encrypt",
          ],
          "Resource" : var.write-bucket-arns,
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readonlybuckets",
          "Action" : [
            "s3:GetObject",
            "kms:Decrypt",
            "kms:GenerateDataKey"
          ],
          "Resource" : var.read-bucket-arns,
          "Effect" : "Allow"
        }
      ]
    })
  }
}

resource "aws_iam_role" "client-super" {
  name = "GlueSuperUserRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : ["sts:AssumeRole"],
      "Effect" : "Allow",
      "Principal" : {
        "AWS" : ["arn:${var.partition}:iam::${var.account-id}:role/Admin"]
      },
      "Sid" : "AllowAdminToAssume"
      }, {
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "glue.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })

  inline_policy {
    name = "AllowGlueS3Access"

    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "CloudwatchMetrics",
          "Effect" : "Allow",
          "Action" : "cloudwatch:PutMetricData",
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "cloudwatch:namespace" : "Glue"
            }
          }
        },
        {
          "Sid" : "CloudwatchLogs",
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogStream",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
          ],
          "Resource" : [
            "arn:${var.partition}:logs:*:*:/aws-glue/*"
          ]
        },
        {
          "Sid" : "accesstoconnections",
          "Action" : [
            "glue:GetConnection",
            "glue:GetConnections"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:connection/*"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "AllowDefaultDatabaseAccess",
          "Action" : [
            "glue:GetUserDefinedFunctions",
            "glue:CreateDatabase"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/*/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/*"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readandwritedatabases",
          "Action" : [
            "glue:SearchTables",
            "glue:BatchCreatePartition",
            "glue:CreatePartitionIndex",
            "glue:DeleteDatabase",
            "glue:GetTableVersions",
            "glue:GetPartitions",
            "glue:DeleteTableVersion",
            "glue:UpdateTable",
            "glue:DeleteTable",
            "glue:DeletePartitionIndex",
            "glue:GetTableVersion",
            "glue:UpdateColumnStatisticsForTable",
            "glue:CreatePartition",
            "glue:UpdateDatabase",
            "glue:CreateTable",
            "glue:GetTables",
            "glue:GetDatabases",
            "glue:GetTable",
            "glue:GetDatabase",
            "glue:GetPartition",
            "glue:UpdateColumnStatisticsForPartition",
            "glue:CreateDatabase",
            "glue:BatchDeleteTableVersion",
            "glue:BatchDeleteTable",
            "glue:DeletePartition",
            "glue:GetUserDefinedFunctions",
            "lakeformation:ListResources",
            "lakeformation:BatchGrantPermissions",
            "lakeformation:ListPermissions"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:catalog",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/*/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/*"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readonlydatabases",
          "Action" : [
            "glue:SearchTables",
            "glue:GetTableVersions",
            "glue:GetPartitions",
            "glue:GetTableVersion",
            "glue:GetTables",
            "glue:GetDatabases",
            "glue:GetTable",
            "glue:GetDatabase",
            "glue:GetPartition",
            "lakeformation:ListResources",
            "lakeformation:ListPermissions"
          ],
          "Resource" : [
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:table/*/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/*",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/default",
            "arn:${var.partition}:glue:${var.region}:${var.account-id}:database/global_temp"
          ],
          "Effect" : "Allow"
        },
        {
          "Sid" : "Readandwritebuckets",
          "Action" : [
            "s3:*Object",
            "s3:PutObjectAcl",
            "s3:*Multipart*",
            "kms:GenerateDataKey",
            "kms:Decrypt",
            "kms:Encrypt",
          ],
          "Resource" : [
            "arn:${var.partition}:s3:::${var.base-name}*",
            "arn:${var.partition}:s3:::${var.base-name}*/*",
            "arn:${var.partition}:kms:${var.region}:${var.account-id}:key/*"
          ],
          "Effect" : "Allow"
        }
      ]
    })
  }
}

resource "aws_iam_role" "runtime" {
  name                = "AwsGlueSessionUserRestrictedServiceRole-GlueRuntimeRole"
  managed_policy_arns = ["arn:${var.partition}:iam::aws:policy/service-role/AwsGlueSessionUserRestrictedServiceRole"]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "glue.amazonaws.com"
          ]
        },
        "Action" : [
          "sts:AssumeRole"
        ]
      }
    ]
  })
}

resource "aws_glue_catalog_database" "source-db" {
  name        = var.database-name
  description = "Database for Glue jobs."
}