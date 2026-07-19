# prateek-portfolio

My personal site — a single self-contained `index.html` (no build step, no framework, zero image assets) — plus the Terraform that ships it. The site claims to be infrastructure-as-code, so it is: S3 + CloudFront + ACM + Route 53, deployed by GitHub Actions over OIDC with **no long-lived AWS keys**.

```
.
├── index.html                    # the whole site (HTML + CSS + JS inline)
├── .github/workflows/deploy.yml  # OIDC deploy: sync to S3 + invalidate CloudFront
└── terraform/
    ├── bootstrap/                # one-time: creates the S3 remote-state bucket
    ├── functions/                # CloudFront Functions (301 redirects)
    └── *.tf                      # the stack
```

## What it provisions

- **`prateek.co.uk`** serves `index.html` over HTTPS from a private S3 bucket via CloudFront (Origin Access Control, TLS 1.2+, HTTP→HTTPS, compression, HSTS, PriceClass_100).
- **`www.prateek.co.uk`** 301-redirects to the apex via a CloudFront Function.
- **`prateektyagi.com`** and **`www.prateektyagi.com`** 301-redirect to `https://prateek.co.uk` via a small dedicated CloudFront distribution (a CloudFront Function returns the 301).
- **ACM certs** in `us-east-1` (required by CloudFront), DNS-validated.
- **Route 53** A/AAAA aliases at every apex and www. Both hosted zones (`prateek.co.uk` and `prateektyagi.com`) already exist and are **looked up** via data sources — Terraform never creates or duplicates a zone. Web-only; no email records are managed.
- **GitHub OIDC role** — assumed by GitHub Actions, scoped to `repo:Prateek-Tyagi/prateek-portfolio:ref:refs/heads/main`, allowed only `s3:PutObject/DeleteObject/GetObject/ListBucket` on the site bucket and `cloudfront:CreateInvalidation` on the primary distribution. No wildcards.
- **AWS Budget** — emails you at 80%/100% of a ~$5/month tripwire.

Remote state: S3 backend with **native lockfile locking** (`use_lockfile`, no DynamoDB).

## Prerequisites

- Terraform **>= 1.10**, AWS CLI with credentials for the target account.
- Both `prateek.co.uk` and `prateektyagi.com` already exist as public Route 53 hosted zones (delegation already in place).

## Run order

### 1. Bootstrap the remote-state bucket (once)

```bash
cd terraform/bootstrap
terraform init
terraform apply          # creates prateek-portfolio-tfstate (versioned, encrypted, private)
cd ..
```

### 2. Initialise the main stack

```bash
cd terraform
terraform init -backend-config=backend.hcl
```

`terraform.tfvars` and `backend.hcl` already hold real values (both gitignored). Edit if needed.

### 3. Plan and apply

```bash
terraform plan
terraform apply
```

Both zones already exist, so the ACM certs validate automatically once the
DNS validation records are in place — no registrar changes needed.

### 4. Wire up GitHub Actions secrets

`terraform apply` prints four outputs that map 1:1 to repo **secrets**
(Settings → Secrets and variables → Actions → *Secrets*):

| GitHub secret                | Comes from Terraform output  |
| ---------------------------- | ---------------------------- |
| `AWS_ROLE_ARN`               | `aws_role_arn`               |
| `AWS_REGION`                 | `aws_region`                 |
| `S3_BUCKET`                  | `s3_bucket`                  |
| `CLOUDFRONT_DISTRIBUTION_ID` | `cloudfront_distribution_id` |

Set them quickly with the GitHub CLI:

```bash
cd terraform
gh secret set AWS_ROLE_ARN               -b "$(terraform output -raw aws_role_arn)"
gh secret set AWS_REGION                 -b "$(terraform output -raw aws_region)"
gh secret set S3_BUCKET                  -b "$(terraform output -raw s3_bucket)"
gh secret set CLOUDFRONT_DISTRIBUTION_ID -b "$(terraform output -raw cloudfront_distribution_id)"
```

### 5. Deploy

Push to `main`. The workflow assumes the OIDC role, `aws s3 sync`s the site files
(only `*.html` + `assets/**` — never `terraform/`, `.github/`, or `.git/`) to S3,
and invalidates CloudFront `"/*"`.

## Notes

- `terraform.tfvars` and `backend.hcl` are gitignored (account-specific). The `.example` files are the templates.
- OIDC provider: `create_oidc_provider` defaults to `false` (reuse the existing one). Set `true` only if the account has none — check with `aws iam list-open-id-connect-providers`.

## Credits

The "personal site as infrastructure-as-code" pattern here was inspired by [Joseph Coleman's `cv` repo](https://github.com/JoeColeman95/cv) (MIT). The site itself and this Terraform are my own, but credit where it's due for the idea.
