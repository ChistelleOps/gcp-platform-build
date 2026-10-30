# GCP-01.3 — Troubleshooting gcloud Authentication

**GitHub Issue:** #4  
**GCP Project:** `gcp-platform-lab-2026`  
**Status:** Troubleshooting and recovery verified

## 1. Objective

Install and validate Google Cloud CLI, reproduce an authentication failure, investigate the root cause, and restore access.

## 2. Initial Validation

Verified the active project:

```bash
gcloud config get-value project
```

Result:

```text
gcp-platform-lab-2026
```

Verified authentication:

```bash
gcloud auth print-access-token >/dev/null \
  && echo "Authentication successful"
```

Result:

```text
Authentication successful
```

Verified project access:

```bash
gcloud projects describe gcp-platform-lab-2026 \
  --format="value(lifecycleState)"
```

Result:

```text
ACTIVE
```

## 3. Reproduce the Authentication Failure

Created a temporary gcloud configuration:

```bash
gcloud config configurations create auth-troubleshooting-lab \
  --no-activate
```

Activated the configuration:

```bash
gcloud config configurations activate auth-troubleshooting-lab
```

Checked available accounts:

```bash
gcloud auth list
```

An authenticated account existed, but no account was selected as active.

Attempted to list GCP projects:

```bash
gcloud projects list
```

Received the error:

```text
ERROR: (gcloud.projects.list) You do not currently
have an active account selected.
```

## 4. Root Cause

The temporary gcloud configuration did not have an active account selected.

Google Cloud CLI stores authentication credentials separately from the account and project selected in a named configuration.

Therefore, an account can have valid credentials without being selected for the current configuration.

## 5. Resolution

Restored the original configuration:

```bash
gcloud config configurations activate default
```

Verified the selected account:

```bash
gcloud config get-value account
```

Verified the selected project:

```bash
gcloud config get-value project
```

Verified project access:

```bash
gcloud projects describe gcp-platform-lab-2026 \
  --format="value(lifecycleState)"
```

Result:

```text
ACTIVE
```

The problem was resolved without logging in again.

## 6. Prevention

When troubleshooting gcloud authentication, inspect:

```bash
gcloud config configurations list
gcloud auth list
gcloud config list
```

Check whether the correct configuration, account, and project are selected before attempting to authenticate again.

## 7. Explanation

I reproduced an authentication failure using a temporary gcloud configuration. Although credentials existed, no account was active in that configuration.

I identified the root cause by checking the active account, restored the original configuration, and verified access to the GCP project.

This helped me understand how Google Cloud CLI manages credentials and named configurations.