# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- feat: add the DDB source.
- feat: add the Glue Catalog  source.
- feat: add the JDBC table source.
- feat: add the DDB table source.
- feat: add the federated db and connection to complete catalog database example.
- feat: add the Glue Catalog table datalake permissions to complete catalog database example.
- feat: add remaining outputs to global module.
- fix: CKV_AWS_94 # Ensure that encryption is enabled for the AWS Glue Data Catalog
- fix: CKV_AWS_99 # Ensure Glue Security Configuration Encryption is enabled
- fix: CKV_AWS_108 # "Ensure IAM policies does not allow data exfiltration"
- fix: CKV_AWS_109 # "Ensure IAM policies does not allow permissions management / resource exposure without constraints"
- fix: CKV_AWS_110 # "Ensure IAM policies does not allow privilege escalation"
- fix: CKV_AWS_111 # "Ensure IAM policies does not allow write access without constraints"
- fix: CKV_AWS_356 # "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
- fix: CKV_AWS_195 # "Ensure Glue component has a security configuration associated"

## [1.0.0] - 2025-03-07
### Description
- feat: adding the catalog module with support for the region specific encryption settings and resource policy.
- feat: adding the crawler module with support for the s3_target.
- feat: adding the global module with support for the region specific encryption settings and resource policy.
- feat: adding the complete example.
- feat: adding the minimum example.

[Unreleased]: https://github.com/boldlink/terraform-module-template/compare/1.0.0...HEAD
[1.0.0]: https://github.com/boldlink/terraform-module-template/releases/tag/1.0.0
