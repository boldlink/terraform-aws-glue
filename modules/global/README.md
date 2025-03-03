[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-module-template/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-module-template.svg)](https://github.com/boldlink/terraform-module-template/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)
[![Build Status](https://github.com/boldlink/terraform-module-template/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-module-template/actions)

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
module "miniumum" {
  source  = "boldlink/glue/aws//modules/catalog"
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

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

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

#### BOLDLink-SIG 2022
