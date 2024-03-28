#!/usr/bin/env bash

WORKLOAD_IDENTITY_PROVIDER="projects/702125700768/locations/global/workloadIdentityPools/github-identity-pool/providers/github-identity-provider"
NPM_INTERNAL_WRITER="npm-internal-writer-gh@sknups.iam.gserviceaccount.com"
NPM_PUBLIC_WRITER="npm-public-writer-gh@sknups.iam.gserviceaccount.com"

if [[ "$SCOPE" == "@sknups-internal" ]]; then
  echo "workload_identity_provider=$WORKLOAD_IDENTITY_PROVIDER" >> "$GITHUB_OUTPUT"
  echo "service_account=$NPM_INTERNAL_WRITER" >> "$GITHUB_OUTPUT"
  echo "service account is $NPM_INTERNAL_WRITER"
fi

if [[ "$SCOPE" == "@sknups" ]]; then
  echo "workload_identity_provider=$WORKLOAD_IDENTITY_PROVIDER" >> "$GITHUB_OUTPUT"
  echo "service_account=$NPM_PUBLIC_WRITER" >> "$GITHUB_OUTPUT"
  echo "service account is $NPM_PUBLIC_WRITER"
fi
