# GCP-01.1 — GCP Resource Hierarchy

**GitHub Issue:** #2  
**Project:** `gcp-platform-lab-2026`

## 1. Objective

Understand Google Cloud resource hierarchy, inspect an existing GCP project, identify its IAM configuration, and document how resource organization differs between a personal lab and a production environment.

## 2. GCP Resource Hierarchy

Google Cloud organizes resources into the following hierarchy:

```text
Organization (optional)
    |
    +-- Folder (optional)
          |
          +-- Project
                |
                +-- Resources
                    - VPC networks
                    - GKE clusters
                    - Cloud Storage buckets
                    - Service accounts
```

Organizations represent a company or institution. Folders help group projects by department, team, or environment.

Projects provide a management boundary for cloud resources, APIs, IAM policies, quotas, and billing associations.

## 3. Lab Environment

The following command was used to inspect the existing project:

```bash
gcloud projects describe gcp-platform-lab-2026 \
  --format="yaml(projectId,name,parent,lifecycleState)"
```

Observed result:

```yaml
lifecycleState: ACTIVE
name: GCP Platform Lab
projectId: gcp-platform-lab-2026
```

Organization discovery:

```bash
gcloud organizations list
```

Observed result:

```text
Listed 0 items.
```

No organizations were visible to the authenticated account.

The project description did not return a parent field.

## 4. IAM Inspection

The project IAM policy was inspected using:

```bash
gcloud projects get-iam-policy gcp-platform-lab-2026 \
  --format="table(bindings.role,bindings.members)"
```

Observed result:

```text
ROLE             MEMBERS
['roles/owner']  [['user:<redacted>']]
```

The lab account has the Owner role at the project level.

In production, broad Owner permissions should generally be replaced with more specific roles following the principle of least privilege.

## 5. Production Architecture Example

A company might organize GCP resources as follows:

```text
Organization: example.com
|
+-- Folder: Engineering
|   |
|   +-- Project: platform-dev
|   +-- Project: platform-staging
|   +-- Project: platform-prod
|
+-- Folder: Data
    |
    +-- Project: analytics-dev
    +-- Project: analytics-prod
```

IAM roles granted at the organization or folder level can be inherited by resources below them.

Project-level IAM roles apply to resources within that project but do not automatically grant access to other projects.

## 6. Architecture Decision

**Decision:** Use the existing standalone GCP project for the learning environment.

**Reasons:**

- No organization is visible to the lab account.
- One project is sufficient for the initial platform build.
- Avoid unnecessary projects and administration.
- Keep the learning environment simple and cost-conscious.

**Production consideration:** For a company-wide platform, evaluate separate projects for development, staging, and production, organized under appropriate folders with centralized governance.

## 7. Troubleshooting and Verification

**Scenario:** Determine why the lab project does not appear beneath a visible organization.

**Investigation:**

1. Inspect the project metadata.
2. List organizations visible to the account.
3. Inspect project-level IAM permissions.

**Findings:** The project is ACTIVE, no organizations were listed, and the project metadata query did not return a parent.

**Resolution:** No configuration change was required. Continue using the existing project.

**Verification:** Project status and IAM policy were successfully retrieved.

## 8. Lessons Learned

- Organizations and folders are optional in GCP resource hierarchy.
- Projects contain cloud resources and provide important management boundaries.
- IAM permissions can be inherited from ancestors.
- A personal lab can operate without an organization.
- Production environments benefit from deliberate project separation and centralized access governance.