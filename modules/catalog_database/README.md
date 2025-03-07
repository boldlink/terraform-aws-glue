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

# Terraform  module boldlink\aws\glue\catalog Terraform module

<h2> Description </h3>

This terraform creates the AWS Glue Catalog and allows you to:
* Create multiple Glue Data Catalog Databases.

Examples available [`here`](github.com/boldlink/terraform-aws-glue/tree/main/examples)

## Usage
*NOTE*: These examples use the latest version of this module

```console
module "miniumum" {
  source  = "boldlink/glue/aws//modules/catalog"
  version = "x.x.x"
  name        = "example"
  description = "example catalog"
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
| [aws_glue_catalog_database.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_table_default_permission"></a> [create\_table\_default\_permission](#input\_create\_table\_default\_permission) | A list of objects defining default table creation permissions. Each object must include a list of permissions and a principal list. | <pre>list(object({<br>    permissions = list(string)<br>    principal = list(object({<br>      data_lake_principal_identifier = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The catalog description. Note: If you supply a federated\_database configuration, AWS Glue requires description to be null. | `string` | n/a | yes |
| <a name="input_federated_database"></a> [federated\_database](#input\_federated\_database) | A list of federated database objects. Each object must include connection\_name and identifier. | <pre>list(object({<br>    connection_name = string<br>    identifier      = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Glue catalog database. | `string` | n/a | yes |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | A map of additional parameters for the catalog database. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the catalog database. | `map(string)` | `{}` | no |
| <a name="input_target_database"></a> [target\_database](#input\_target\_database) | A list of target database objects. Each object must include catalog\_id, database\_name, and region. | <pre>list(object({<br>    catalog_id    = string<br>    database_name = string<br>    region        = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARNs of the Glue catalog databases created. |
| <a name="output_name"></a> [name](#output\_name) | The name of the created Glue catalog database. |
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
