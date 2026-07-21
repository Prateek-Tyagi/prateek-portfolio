---
name: Prateek Rajvats
role: Platform & Reliability Engineer
tagline: Senior Platform Engineer · Cloud Infrastructure & SRE
location: Gurugram, India
phone: "+91 99979 94367"
email: parteekrajvats@gmail.com
website: prateek.co.uk
linkedin: linkedin.com/in/prateekrajvats
github: github.com/Prateek-Tyagi
---

## Summary

Platform engineer with 6+ years building and operating secure, multi-account AWS
infrastructure for globally distributed production systems. I turn manual, error-prone
operations into self-service platforms — governance enforced as code, reliability measured
against SLOs, and guardrails that let product teams ship safely without waiting on Platform.
Comfortable across the full surface area: IaC, CI/CD, observability, container security, and FinOps.

## Technical Skills

**Cloud & Governance** — AWS (Organizations, Control Tower, SCPs, IAM Identity Center, Lake Formation, VPC, Transit Gateway, EC2, ECS, Lambda, Step Functions, EventBridge, RDS, S3, Athena, Glue)

**IaC & Automation** — Terraform (module registries, remote state), CloudFormation, AWS CDK, Ansible, Python (boto3), Bash

**CI/CD** — Bitbucket Pipelines, AWS CodePipeline, GitHub Actions, OIDC-based auth

**Containers & Security** — Docker, ECS Fargate (primary), Kubernetes/EKS (working knowledge; CKA in progress), JFrog Artifactory & Xray, ECR scanning

**SRE & Observability** — SLO/SLI design, error budgets, Datadog (RUM, synthetics, monitors, logging), CloudWatch, incident management, OpsGenie on-call

**Compliance & FinOps** — SOC2 Type II, CIS Benchmarks, GDPR, KMS, compliance-as-code, cost attribution & tagging, rightsizing, RI planning

## Experience

### Senior Platform Engineer [May 2025 – Present]{.when}

**Safeguard Global** · Remote, India

- Lead platform engineering for a multi-account AWS organization (20+ accounts) running globally distributed payroll and workforce systems under strict data-residency and compliance requirements.
- Building a Bitbucket Dynamic Pipelines governance system (Forge app) that injects SonarQube and security controls into repositories at runtime — enforcing governance with zero per-repo configuration.
- Built a centralized, versioned Terraform module ecosystem with CI-integrated policy validation, cutting release time ~75% by letting teams provision compliant infrastructure deterministically across dev/stage/prod.
- Centralized code-quality and artifact-security scanning across 30+ teams (SonarQube, SBOM generation, JFrog Xray/Artifactory) as a self-service platform, reducing manual vulnerability-triage effort ~60%.
- Codified SOC2 and CIS hardening as executable Terraform and IAM policy, enforcing org-wide guardrails via SCPs, permission boundaries, and mandatory encryption — replacing manual audit checklists with continuous enforcement.
- Drove a ~30% AWS cost reduction through rightsizing, commitment planning, and idle-resource elimination, surfaced via cross-account cost attribution.
- Migrated 300+ users from per-account IAM to AWS Identity Center with custom permission sets that standardized access control across the organization.
- Instrumented SLOs/SLIs with error-budget policies, helping sustain ~99.7% availability across critical services.

<div class="page-break"></div>

### Platform Engineer [Oct 2022 – Apr 2025]{.when}

**Safeguard Global** · Remote, India

- Delivered Safeguard's first compliance-as-code program across 20+ AWS accounts — enforcing encryption-at-rest, IAM least-privilege, and audit logging via Terraform and Python, reaching SOC2 review with no exceptions in scope.
- Onboarded 15+ engineering teams onto SonarQube, JFrog Artifactory, and Xray as centrally governed platform services.
- Centralized SonarQube static analysis using versioned, Docker-based Bitbucket Pipes (reusable like Terraform modules), standardizing code-quality gates across 30+ teams.
- Built a container-security pipeline integrating JFrog Xray with policy gates that block vulnerable images from production, cutting remediation time ~60%.
- Built an end-to-end incident system (Datadog → OpsGenie) with custom routing, escalation, and on-call rotations, reducing MTTD ~45%.
- Stood up a FinOps cost-visibility platform with automated tagging taxonomy and cross-account aggregation, surfacing $150K+ in annual savings via RI planning and rightsizing.

### DevOps Engineer → Senior DevOps Engineer [Jun 2020 – Aug 2022]{.when}

**Solytics Partners** · Pune → Remote, India

- Promoted to lead container-orchestration design on ECS Fargate running 50+ microservices with horizontal autoscaling and cross-AZ fault tolerance.
- Provisioned Terraform-managed AWS environments for 20+ services with VPC isolation, security-group hardening, and least-privilege IAM roles.
- Implemented immutable deployment pipelines with artifact versioning and a 95% deployment success rate via automated integration testing, canary releases, and rollback — compressing release-cycle time ~75%.
- Drove ~30% infrastructure cost reduction via compute rightsizing, reserved-instance procurement, and architectural optimization.

## Selected Projects

- **SarkariPing** (active side project) — A government-job alerts PWA for Indian students who miss deadlines buried across fragmented government portals. Matches students to eligible roles, uses an LLM syllabus parser to identify cross-exam overlap, assesses prep level, and generates a study plan delivered through a built-in lightweight LMS.
- **Earlier engineering** — File malware-scanning service; FortiGate VPN deployment on AWS.

## Education & Certifications

**B.Tech, Computer Science** — Lovely Professional University, Punjab, India [2016 – 2020]{.when}

AWS Certified Solutions Architect – Associate · CKA (Certified Kubernetes Administrator) — in progress

## Key Achievements

- Sustained ~99.7% availability via SLO instrumentation, error budgets, and proactive capacity planning.
- Achieved zero audit exceptions enforcing SOC2 / CIS across 20+ AWS accounts through automated controls.
- Surfaced $150K+ in annual cost savings through FinOps practices and automated cost attribution.
- Reduced security-remediation cycles ~60% and MTTD ~45% through automated scanning and incident tooling.

**Languages:** English (fluent), Hindi (native) · 6+ years in remote-first distributed teams
