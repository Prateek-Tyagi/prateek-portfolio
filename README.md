# prateek-portfolio

My personal site — a single self-contained `index.html` (no build step, no framework, zero image assets) — plus the Terraform that ships it. The site claims to be infrastructure-as-code, so it is: S3 + CloudFront + ACM + Route 53, deployed by GitHub Actions over OIDC with **no long-lived AWS keys**.

```
.
├── index.html                 # the whole site (HTML + CSS + JS inline)
├── .github/workflows/deploy.yml  # OIDC deploy: sync to S3 + invalidate CloudFront
└── terraform/                 # S3, CloudFront (OAC), ACM, Route 53, GitHub OIDC role, budget alarm
```

## What the Terraform provisions

- **S3 bucket** — private, versioned, encrypted; readable only by CloudFront.
- **CloudFront** — HTTPS-only, HTTP/2 + IPv6, Origin Access Control (the modern replacement for OAI), single-page error fallback to `index.html`.
- **ACM certificate** — issued in `us-east-1` (required by CloudFront), DNS-validated.
- **Route 53** — A/AAAA alias records for the apex and `www`.
- **GitHub OIDC role** — assumed by GitHub Actions; scoped to `s3:*Object` on this bucket + `cloudfront:CreateInvalidation` on this distribution, and only from this repo's `main` branch.
- **AWS Budget** — emails you if monthly spend crosses 80% / 100% of a small limit.

Remote state lives in S3 with **native lockfile locking** (`use_lockfile`, no DynamoDB table).

## Prerequisites

- A domain with a **public Route 53 hosted zone** already in the account (auto-created if you registered via Route 53; otherwise create the zone and point your registrar's NS records at it).
- Terraform **>= 1.10**, AWS CLI, and credentials for a bootstrap apply.

## Deploy

### 1. Bootstrap the state bucket (one time)

```bash
aws s3api create-bucket \
  --bucket prateek-portfolio-tfstate \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning \
  --bucket prateek-portfolio-tfstate \
  --versioning-configuration Status=Enabled
```

### 2. Configure

```bash
cd terraform
cp backend.hcl.example backend.hcl        # set your state bucket + region
cp terraform.tfvars.example terraform.tfvars   # set domain_name (at minimum)
```

### 3. Apply

```bash
terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

Terraform prints the values you need for GitHub:

```
github_actions_role_arn    = arn:aws:iam::...:role/prateek-portfolio-github-deploy
site_bucket_name           = ...-site
cloudfront_distribution_id = E...
```

### 4. Wire up GitHub Actions

In the repo → **Settings → Secrets and variables → Actions**:

| Kind     | Name                         | Value                          |
| -------- | ---------------------------- | ------------------------------ |
| Secret   | `AWS_ROLE_ARN`               | `github_actions_role_arn`      |
| Variable | `AWS_REGION`                 | e.g. `ap-south-1`              |
| Variable | `S3_BUCKET`                  | `site_bucket_name`             |
| Variable | `CLOUDFRONT_DISTRIBUTION_ID` | `cloudfront_distribution_id`   |

Push to `main` and the workflow syncs `index.html` to S3 and invalidates the cache. That's the whole loop — edit the page, commit, and it's live in seconds with no keys anywhere.

## Notes

- `terraform.tfvars` and `backend.hcl` are gitignored (they hold account-specific values). The `.example` files are the templates.
- If the account already has a GitHub Actions OIDC provider, set `create_oidc_provider = false` so Terraform reuses it instead of erroring.

## Credits

The "personal site as infrastructure-as-code" pattern here was inspired by [Joseph Coleman's `cv` repo](https://github.com/JoeColeman95/cv) (MIT). The site itself and this Terraform are my own, but credit where it's due for the idea.
