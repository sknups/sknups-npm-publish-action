# sknups-npm-publish-action

This GitHub Action is used by the SKNUPS organisation to publish npm packages.

```yaml
  - name: Publish npm package
    uses: sknups/sknups-npm-publish-action@v1
```

If your `package.json` has `private` to true, this action will do nothing.

If your GitHub repository has not been added to the `sknups-terraform` project, this action will fail.

---

## Artifact Registry

We have two npm repositories in Google Cloud Artifact Registry:

| npm package scope  | npm repository | read access | write access |
|--------------------|----------------|-------------|--------------|
| `@sknups`          | `npm`          | public      | needs auth   |
| `@sknups-internal` | `npm-internal` | needs auth  | needs auth   |

## Authentictation

See: [Enabling keyless authentication from GitHub Actions](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)

We have three service accounts:

| service account          | `npm-internal` | `npm` |
|--------------------------|----------------|-------|
| `npm-internal-reader-gh` | read           | read  |
| `npm-internal-writer-gh` | write          | read  |
| `npm-public-writer-gh`   | -              | write |

## Terraform

We explicitly configure which Git repositories impersonate the service accounts.

https://github.com/sknups/sknups-terraform/blob/main/main.tf

```terraform
module "artifact_registry" {

  source   = "./modules/artifact_registry"
  location = local.location
  project  = local.project
  
  # these can read from npm-internal
  npm_internal_reader_repositories = [
    "sknups/example-project"
  ]
  
  # these can write to npm-internal
  npm_internal_writer_repositories = [
    "sknups/example-project"
  ]
  
  # these can write to npm
  npm_public_writer_repositories = [
    "sknups/example-project"
  ]
  
  workload_identity_pool_name = module.github_oidc.workload_identity_pool_name
  
}
```
