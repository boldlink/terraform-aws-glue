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

# Terraform  module boldlink\aws\glue\global Terraform module

<h2> Description </h3>

This terraform configures the AWS Glue Global Settings and allows you to:
* Enable Glue Data Catalog encryption, this is a region specific setting.
* Set Glue Data Catalog Resource Policy, this is a region specific setting.

**Note :** If you have existing catalogs prior to enabling encryption
* Enabling encryption does not automatically encrypt existing metadata in the Data Catalog.
* Only new metadata written to the catalog after encryption is enabled will be encrypted.
* Gradual encryption of existing metadata can be achieved by rewriting the metadata using the AWS Glue APIs or AWS Glue console.

Examples available [`here`](github.com/boldlink/terraform-aws-glue/tree/main/examples)

## Usage
*NOTE*: These examples use the latest version of this module

```console
module "example" {
  source  = "boldlink/glue/aws//modules/global"
  version = "x.x.x"
  enable_glue_encryption = true
  enable_glue_resource_policy = true
  glue_encryption_settings = {
    catalog_encryption_mode = "SSE-KMS"
    sse_kms_key_id = "arn:aws:kms:us-west-2:123456789012:key/1234abcd-12ab-34cd-56ef-1234567890ab"
  }
  glue_resource_policy = {
    policy = <<EOF
  ...
}
```
## Documentation

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
| [aws_glue_data_catalog_encryption_settings.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_data_catalog_encryption_settings) | resource |
| [aws_glue_resource_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_resource_policy) | resource |
| [aws_glue_security_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_security_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Globally enable Glue Data Catalog encryption settings | `bool` | `false` | no |
| <a name="input_enable_glue_resource_policy"></a> [enable\_glue\_resource\_policy](#input\_enable\_glue\_resource\_policy) | Globally enable applying a Glue resource policy | `bool` | `false` | no |
| <a name="input_enable_glue_security_configuration"></a> [enable\_glue\_security\_configuration](#input\_enable\_glue\_security\_configuration) | Flag to enable or disable Glue security configurations | `bool` | `false` | no |
| <a name="input_glue_encryption_role_arn"></a> [glue\_encryption\_role\_arn](#input\_glue\_encryption\_role\_arn) | The ARN of the IAM role for Glue catalog encryption service role (optional). Leave empty if not used. | `string` | `""` | no |
| <a name="input_glue_resource_policy"></a> [glue\_resource\_policy](#input\_glue\_resource\_policy) | A JSON string defining the Glue resource policy | `string` | `""` | no |
| <a name="input_glue_security_configurations"></a> [glue\_security\_configurations](#input\_glue\_security\_configurations) | List of Glue security configurations | <pre>list(object({<br>    name = string<br>    encryption_configuration = object({<br>      cloudwatch_encryption = object({<br>        cloudwatch_encryption_mode = string<br>        kms_key_arn                = string<br>      })<br>      job_bookmarks_encryption = object({<br>        job_bookmarks_encryption_mode = string<br>        kms_key_arn                   = string<br>      })<br>      s3_encryption = object({<br>        s3_encryption_mode = string<br>        kms_key_arn        = string<br>      })<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | The ARN of the KMS key to use for Glue encryption | `string` | `""` | no |
| <a name="input_return_connection_password_encrypted"></a> [return\_connection\_password\_encrypted](#input\_return\_connection\_password\_encrypted) | Override for returning connection passwords encrypted (defaults to true) | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_glue_encryption_settings"></a> [glue\_encryption\_settings](#output\_glue\_encryption\_settings) | The ID of the Glue Data Catalog encryption settings |
| <a name="output_glue_resource_policy"></a> [glue\_resource\_policy](#output\_glue\_resource\_policy) | The Glue resource policy |
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

#### BOLDLink-SIG 2022
