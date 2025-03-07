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

# Terraform AWS Glue Complete module example:

* Building resources in different regions so we can test different global glue settings (Glue Catalog Encryption; Glue Security Settings; Glue Resource Policy).
* IAM roles in ireland and london for global settings.
* Kms keys in ireland and london for global settings.
* Glue catalogs in Ireland London.
* Crawlers in ireland and london using s3 Target.
* S3 bucket for the `s3_target` crawler configuration

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.20.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.90.0 |
| <a name="provider_aws.ireland"></a> [aws.ireland](#provider\_aws.ireland) | 5.90.0 |
| <a name="provider_aws.london"></a> [aws.london](#provider\_aws.london) | 5.90.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_catalog_ireland_1"></a> [catalog\_ireland\_1](#module\_catalog\_ireland\_1) | ./../../modules/catalog_database | n/a |
| <a name="module_catalog_ireland_2"></a> [catalog\_ireland\_2](#module\_catalog\_ireland\_2) | ./../../modules/catalog_database | n/a |
| <a name="module_catalog_london_1"></a> [catalog\_london\_1](#module\_catalog\_london\_1) | ./../../modules/catalog_database | n/a |
| <a name="module_catalog_london_2"></a> [catalog\_london\_2](#module\_catalog\_london\_2) | ./../../modules/catalog_database | n/a |
| <a name="module_crawler"></a> [crawler](#module\_crawler) | ./../../modules/crawler | n/a |
| <a name="module_glue_global_settings_ireland"></a> [glue\_global\_settings\_ireland](#module\_glue\_global\_settings\_ireland) | ./../../modules/global | n/a |
| <a name="module_glue_global_settings_london"></a> [glue\_global\_settings\_london](#module\_glue\_global\_settings\_london) | ./../../modules/global | n/a |
| <a name="module_ireland_s3_bucket"></a> [ireland\_s3\_bucket](#module\_ireland\_s3\_bucket) | boldlink/s3/aws | 2.5.1 |
| <a name="module_kms_ireland"></a> [kms\_ireland](#module\_kms\_ireland) | boldlink/kms/aws | 1.2.0 |
| <a name="module_kms_london"></a> [kms\_london](#module\_kms\_london) | boldlink/kms/aws | 1.2.0 |
| <a name="module_role_ireland"></a> [role\_ireland](#module\_role\_ireland) | boldlink/iam-role/aws | 2.0.0 |
| <a name="module_role_london"></a> [role\_london](#module\_role\_london) | boldlink/iam-role/aws | 2.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_glue_catalog_table.aws_glue_catalog_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table) | resource |
| [aws_glue_classifier.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_classifier) | resource |
| [time_sleep.wait_for_ireland](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.wait_for_london](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.glue_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.glue_catalog_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.glue_resource_policy_london](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ireland_glue_crawler_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.ireland](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.london](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the complete example | `string` | `"terraform-aws-glue-complete"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalogs_ireland"></a> [catalogs\_ireland](#output\_catalogs\_ireland) | The names and ARNs of the Ireland Glue data catalogs |
| <a name="output_catalogs_london"></a> [catalogs\_london](#output\_catalogs\_london) | The names and ARNs of the London Glue data catalogs |
| <a name="output_glue_encryption_settings"></a> [glue\_encryption\_settings](#output\_glue\_encryption\_settings) | The ID of the Glue Data Catalog encryption settings |
| <a name="output_glue_resource_policy_london"></a> [glue\_resource\_policy\_london](#output\_glue\_resource\_policy\_london) | The Glue resource policy for the London region |
| <a name="output_ireland_crawlers"></a> [ireland\_crawlers](#output\_ireland\_crawlers) | The names and IDs of the Ireland Glue crawlers |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
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
