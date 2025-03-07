[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-glue/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-glue.svg)](https://github.com/boldlink/terraform-aws-glue/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-glue/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-glue/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

<h1> Terraform  module \aws\glue\crawler Terraform module </h1>

\<Description>

This module creates a Glue Crawler on s3_target.

A Glue Crawler connects to one (or more) data store(s), progresses through a prioritized list of classifiers to determine the schema for your data, and then creates metadata tables in the target Data Catalog.

Examples available [`here`]github.com/boldlink/terraform-aws-glue//tree/main/examples)

<h2> Usage </h2>
*NOTE*: These examples use the latest version of this module

```console
module "example" {
  source  = "boldlink/glue/aws//modules/crawler"
  version = "x.x.x"
  source                = "./../../modules/crawler"
  name                  = var.name
  role                  = module.role.arn
  database_name         = var.name
  s3_target_path        = "s3://bucket/data/"
  ...
  tags                  = { Environment = "example" }
  }
}
```

<h2> Documentation </h2>

[Amazon Documentation](https://link)

[Terraform module documentation](https://link)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_glue_crawler.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_classifiers"></a> [classifiers](#input\_classifiers) | List of classifier names for the crawler | `list(string)` | `[]` | no |
| <a name="input_configuration"></a> [configuration](#input\_configuration) | A JSON string representing the crawler configuration | `string` | `""` | no |
| <a name="input_crawler_lineage_settings"></a> [crawler\_lineage\_settings](#input\_crawler\_lineage\_settings) | Lineage configuration for the crawler (e.g., ENABLE or DISABLE) | `string` | `""` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The Glue database name where the crawler’s output will be stored | `string` | n/a | yes |
| <a name="input_delete_behavior"></a> [delete\_behavior](#input\_delete\_behavior) | Policy for handling deletes (e.g., LOG) | `string` | `"LOG"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the Glue Crawler | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the Glue Crawler | `string` | n/a | yes |
| <a name="input_recrawl_policy"></a> [recrawl\_policy](#input\_recrawl\_policy) | Recrawl policy behavior (e.g., CRAWL\_EVERYTHING or CRAWL\_NEW\_FOLDERS\_ONLY) | `string` | `""` | no |
| <a name="input_role"></a> [role](#input\_role) | IAM Role ARN that the Glue Crawler assumes | `string` | n/a | yes |
| <a name="input_s3_target_exclusions"></a> [s3\_target\_exclusions](#input\_s3\_target\_exclusions) | List of S3 path patterns to exclude from crawling | `list(string)` | `[]` | no |
| <a name="input_s3_target_path"></a> [s3\_target\_path](#input\_s3\_target\_path) | The S3 path that the crawler will scan (e.g., s3://bucket/path/) | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Cron expression to schedule the crawler (optional) | `string` | `null` | no |
| <a name="input_table_prefix"></a> [table\_prefix](#input\_table\_prefix) | Table prefix for tables created by the crawler | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the crawler | `map(string)` | `{}` | no |
| <a name="input_update_behavior"></a> [update\_behavior](#input\_update\_behavior) | Policy for updating the schema (e.g., UPDATE\_IN\_DATABASE) | `string` | `"UPDATE_IN_DATABASE"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The id of the created Glue Crawler |
| <a name="output_name"></a> [name](#output\_name) | The name of the created Glue Crawler |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<h2> Third party software </h2>
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

<h4> BOLDLink-SIG 2025 </h4>
