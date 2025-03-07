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

# Terraform module example of minimum configuration

* S3 bucket for the `s3_target` crawler configuration
* Role for the crawler to use.
* Glue catalog.

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
| <a name="provider_time"></a> [time](#provider\_time) | 0.13.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | boldlink/s3/aws | 2.5.1 |
| <a name="module_catalog"></a> [catalog](#module\_catalog) | ./../../modules/catalog_database | n/a |
| <a name="module_crawler"></a> [crawler](#module\_crawler) | ./../../modules/crawler | n/a |
| <a name="module_role"></a> [role](#module\_role) | boldlink/iam-role/aws | 2.0.0 |

## Resources

| Name | Type |
|------|------|
| [time_sleep.wait_for_role](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.glue_crawler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.glue_crawler_trust](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the Glue job | `string` | `"terraform-aws-glue-minimum"` | no |

## Outputs

No outputs.
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

<h2> BOLDLink-SIG 2025 </h2>
