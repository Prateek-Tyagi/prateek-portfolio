---
name: tailor-cv
description: Tailors Prateek Rajvats's job-specific CV to a supplied job description using a consistent, truthful, ATS-friendly workflow. Use whenever the user asks to tune, align, adapt, or update a CV/resume for a company, role, vacancy, or JD in this repository.
---

# Tailor CV

Create a focused application CV without changing the public CV or inventing experience.

## Files and scope

- Public CV source: `cv.md`. Never edit it during job-specific tailoring.
- Tailored CVs: `applications/<company-role>/cv.md`.
- If the requested application directory exists, edit its `cv.md`.
- If it does not exist, run `./new-cv-application.sh <company-role>` using a concise lowercase slug, then edit the generated file.
- Never hand-edit generated `cv.html` or PDF files.
- Do not build unless the user asks. Build command:
  `./build-cv.sh applications/<company-role>`.
- Application output must remain local under the gitignored `applications/` directory.

## Truth constraints

Use only facts supported by the current application CV, root `cv.md`, or information the user explicitly provides.

- Never invent tools, responsibilities, scale, outcomes, leadership, migrations, or production experience.
- Preserve employment dates, company names, education, certifications, and exact underlying job titles.
- The frontmatter `role` and `tagline` may target the vacancy; employment headings must remain factual.
- Do not turn “working knowledge” into hands-on expertise.
- Do not claim Go, Node.js, SaltStack, GCP, Azure, Oracle Cloud, Bazel, or search technologies unless the user supplies supporting experience.
- Keep experience at “6+ years” until the source CV or user updates it.
- Retain supported metrics; do not create new percentages or counts.
- Do not add `prateek.co.uk`, the personal portfolio, or its infrastructure as a Selected Project. The website may remain in contact metadata.
- Prefer an explicit gap over a fabricated keyword.

## Verified baseline

Use these themes when relevant to the JD:

- AWS multi-account platforms across 20+ accounts.
- Terraform modules, remote state, policy validation, CloudFormation, AWS CDK.
- Python with boto3, Bash, and Ansible.
- ECS Fargate, Docker, EC2, Lambda, IAM, VPC, S3, RDS, EventBridge, SQS, Lakeformation.
- Kubernetes/EKS: working knowledge; CKA in progress.
- Bitbucket Pipelines, GitHub Actions, AWS CodePipeline, OIDC.
- Datadog, Grafana, CloudWatch, OpsGenie, SLOs/SLIs, error budgets, on-call.
- Least-privilege IAM, SCPs, permission boundaries, KMS/encryption, SOC2/CIS.
- Self-service platform tooling used across 15–30+ engineering teams.
- Supported outcomes: ~99.7% availability, ~75% faster releases, ~60% faster security remediation, ~45% lower MTTD, ~30% cloud/infrastructure cost reduction, $150K+ annual savings.
- Selected Projects may include SarkariPing and earlier engineering work already present in the source CV.

## Tailoring workflow

1. Read the complete target `cv.md`.
2. Extract the JD into:
   - role mission,
   - required technologies,
   - operational responsibilities,
   - collaboration/leadership expectations,
   - preferred or optional skills.
3. Map each important requirement to verified evidence from the CV.
4. Prioritize evidence:
   - direct matches first,
   - adjacent transferable experience second,
   - unsupported requirements omitted rather than claimed.
5. Edit the target CV:
   - `role` and `tagline`: match the vacancy naturally.
   - Summary: 4–6 concise lines covering role fit, scale, core stack, reliability, and collaboration.
   - Technical Skills: reorder and rename categories around the JD; avoid duplicate or malformed rows.
   - Experience: rewrite bullets to foreground relevant outcomes while preserving facts.
   - Projects: retain only credible, relevant projects; never add the personal portfolio.
   - Achievements: select 3–4 metrics most relevant to the vacancy.
6. Use exact JD terminology where truthful, but do not keyword-stuff or repeat every term.
7. Keep the existing Markdown/frontmatter syntax and `<div class="page-break"></div>`.
8. Aim for a readable two-page PDF; remove low-value repetition before shrinking content.
9. Re-read the final file for:
   - unsupported claims,
   - changed facts or employment titles,
   - duplicated skills,
   - grammar and punctuation,
   - first-person filler and generic claims.

## Writing style

- Lead with outcomes and scale, then explain how they were achieved.
- Use concise action verbs: built, automated, operated, improved, designed, delivered.
- Prefer “Built reusable Terraform modules used across 20+ accounts” over “Responsible for Terraform.”
- Make seniority visible through ownership, design, incident response, collaboration, and measurable impact.
- Avoid claiming a direct domain match when only transferable platform experience exists.
- Use `—` consistently between skill headings and details.

## Completion response

State:

1. the exact `cv.md` updated,
2. the main JD themes emphasized,
3. notable requirements intentionally not claimed due to missing evidence,
4. the build command if the user wants to generate the HTML/PDF.
