---
name: Prateek Rajvats
role: Senior Platform Engineer
tagline: Cloud Platforms · Infrastructure as Code · Security · Reliability
location: Gurugram, India
phone: "+91 99979 94367"
email: parteekrajvats@gmail.com
website: prateek.co.uk
linkedin: linkedin.com/in/prateekrajvats
github: github.com/Prateek-Tyagi
---

## Summary

Senior Platform Engineer with 6+ years building the AWS platform that other
engineering teams ship on. I work on globally distributed payroll and workforce
systems where security, compliance, and availability have to be defaults — not
follow-up work after a release.

I treat Platform as a product: reusable infrastructure, governed delivery, and
least-privilege access that teams can consume without opening a ticket for every
change. The aim is a paved path that stays safe when the platform team is small.

## Technical Skills

**AWS & Cloud Platform** — Organizations, Control Tower, SCPs, IAM, IAM Identity Center, EC2, ECS, Fargate, Lambda, EventBridge, SQS/DLQ, Step Functions, RDS, Aurora PostgreSQL, DynamoDB, S3, AWS Backup, KMS, WAF, Route 53

**Infrastructure as Code & Automation** — Terraform (reusable/versioned modules, registries, remote state), CloudFormation, AWS CDK, Ansible, Python, boto3, Bash, YAML

**Platform Architecture & Governance** — Platform-as-a-Product, Zero-Trust Architecture, multi-account AWS, account/environment separation, self-service infrastructure, secure-by-default patterns, reusable primitives, centralized governance, developer guardrails, event-driven architecture, cross-account services

**Cloud Networking** — VPC architecture, public/private subnets, route tables, Transit Gateway, TGW peering, VPC peering, Site-to-Site VPN, AWS Client VPN, FortiGate VPN, private connectivity, NLB, Route 53/DNS, security groups, cross-account and multi-region routing, TLS/certificates, NGINX/reverse proxy

**Identity & Access** — IAM, IAM Identity Center/SSO, permission sets, Entra ID SAML, SCPs, permission boundaries, cross-account roles, temporary credentials, OIDC, SAML, least privilege, service identities

**CI/CD & Release Engineering** — Bitbucket Pipelines, Bitbucket Dynamic Pipelines, Dynamic Runtime Injections, AWS CodePipeline, CodeBuild, GitHub Actions, GitLab CI, OIDC, OIDC-based CI auth, reusable pipeline components, policy and quality gates, GitOps concepts, ArgoCD

**DevSecOps & Supply Chain** — SonarQube, JFrog Artifactory, JFrog Xray, SBOM Automation, Checkov, Gitleaks, SAST, IaC scanning, dependency and artifact scanning, container-image scanning, vulnerability policy gates, controlled package resolution

**Containers** — Docker, Amazon ECS, ECS Fargate, ECR, Kubernetes/EKS (strong working knowledge; not used in production; CKA in progress), container security, autoscaling

**SRE & Observability** — Datadog (metrics, logs, dashboards, monitors, synthetics, RUM), CloudWatch, Grafana dashboards, SLO/SLI design, error-budget concepts, SQS/DLQ monitoring, incident management, OpsGenie/on-call, Prometheus and Grafana exposure

**Data Platform Infrastructure** — Athena, Glue/Data Catalog, Lake Formation, S3-based data platforms, QuickSight, AWS DMS, Postgres, platform integration with dbt and Fivetran, SQL Server connectivity (infrastructure, access, and governance — not data engineering)

**Security & Compliance** — SOC 2 controls, CIS-aligned cloud controls, GDPR considerations, encryption at rest, KMS, least privilege, audit logging, AWS WAF, security policy enforcement, compliance-as-code

**FinOps** — AWS cost analysis and optimization, rightsizing, tagging and cost attribution, idle-resource identification, commitment/reservation planning

**Programming & Scripting** — Python, boto3, Bash, YAML, SQL

## Experience

### Senior Platform Engineer [May 2025 – Present]{.when}

**Safeguard Global** · Remote, India

- Kept 100% operational continuity for three months after two Principal Engineers left, while continuing to own multi-account AWS, IAM Identity Center, Dynamic Pipelines, networking, and production observability.
- Own the versioned Terraform module platform that engineering teams consume to provision networking, compute, databases, storage, security controls, backup, and container services.
- Engineered zero-touch CI/CD governance with Bitbucket Dynamic Pipelines and Forge — Dynamic Runtime Injections of compliance, SBOM Automation, and quality gates so developers did not migrate or rewrite pipeline configuration.
- Rationalized fragmented AWS IAM into a strict least-privilege model using IAM Identity Center permission sets and permission boundaries (Zero-Trust Architecture: temporary credentials, no standing keys, just-enough access).
- Implementing Entra ID SAML with IAM Identity Center so joiner and leaver access is automatic and no live credentials remain when someone leaves the business.
- Supported the Zendesk → Salesforce + Amazon Connect omnichannel migration by providing just-enough IAM policies and Salesforce permission sets for Connect roles, including access for the implementation partner.
- Centralize AWS networking across accounts and regions using VPCs, Transit Gateway, TGW peering, routing, private endpoints, load balancing, and DNS.
- Support AWS data-platform infrastructure (S3, Athena, Glue, Lake Formation, QuickSight) and evolve Datadog/CloudWatch observability into SLO/SLI instrumentation, including EventBridge, SQS, Lambda, and DLQ failure detection.

### Platform Engineer [Oct 2022 – Apr 2025]{.when}

**Safeguard Global** · Remote, India

- Built Terraform-based AWS infrastructure and the first reusable platform components across a multi-account AWS organization.
- Delivered the first compliance-as-code program — encryption, IAM least privilege, audit logging, and security configuration standards — using Terraform, AWS policy controls, and automation.
- Standardized SonarQube as a centrally managed code-quality capability, with reusable Docker-based Bitbucket Pipes for consistent quality-gate enforcement across repositories.
- Integrated JFrog Artifactory and Xray into delivery workflows for artifact management, dependency scanning, vulnerability detection, and policy enforcement.
- Implemented SBOM and vulnerability-scanning workflows, and moved package consumption toward centrally governed artifact repositories instead of uncontrolled public resolution.
- Built container-security workflows that scan artifacts and images and apply vulnerability policies before production deployment.
- Integrated IaC and source-code security tooling, including Checkov and secrets scanning, into CI/CD workflows.
- Built Datadog monitoring and alerting for AWS and application workloads, including event-driven services, queues, Lambda, and operational failure scenarios.
- Integrated Datadog alerting with OpsGenie/on-call processes to improve routing and escalation of production incidents.
- Stood up AWS cost visibility through tagging, cost attribution, rightsizing analysis, idle-resource identification, and reservation/commitment planning.
- Built secure connectivity: FortiGate VPN (greenfield; internal applications and a local domain controller behind it), AWS Client VPN endpoints, and Fivetran connections into private resources through FortiGate.

### DevOps Engineer → Senior DevOps Engineer [Jun 2020 – Aug 2022]{.when}

**Solytics Partners** · Pune → Remote, India

- Built and operated AWS infrastructure supporting containerized applications and microservices.
- Designed and operated container workloads on Amazon ECS and ECS Fargate — service deployment, autoscaling, networking, load balancing, and multi-AZ availability.
- Provisioned and maintained AWS environments with Terraform, including VPC networking, compute, container services, IAM, security groups, storage, and supporting infrastructure.
- Built CI/CD automation for application and infrastructure delivery — artifact versioning, automated testing, deployment automation, and rollback workflows.
- Implemented IAM and network-security controls using least-privilege roles, VPC isolation, security groups, and controlled application connectivity.
- Worked on infrastructure cost optimization through compute rightsizing, capacity planning, reservation/commitment analysis, and architecture improvements.
- Used Python and Bash automation to reduce repetitive infrastructure and operational tasks.
- Supported production troubleshooting across AWS infrastructure, containers, networking, CI/CD, and application deployments.

## Selected Projects

- **SarkariPing** (side project; paused) — Working live app for Indian students to track upcoming exams and generate LLM insights from previous-year papers and historical merit data. Built on Vercel and Supabase, with SNS/SQS for mail. Not production-scale; paused to focus on the day job.
- **File malware-scanning service** — Automated inspection of uploaded files for malicious content as part of a secure application workflow.
- **FortiGate VPN on AWS** — Deployed and configured FortiGate-based VPN connectivity for secure network access, including internal applications and directory access.

## Education & Certifications

**B.Tech, Computer Science** — Lovely Professional University, Punjab, India [2016 – 2020]{.when}

AWS Certified Solutions Architect – Associate · CKA (Certified Kubernetes Administrator) — in progress

## Professional Strengths

Platform-as-a-Product · Zero-Trust Architecture · AWS multi-account platform engineering · Terraform and reusable IaC · CI/CD governance and Dynamic Runtime Injections · SBOM Automation · IAM Identity Center and Entra ID SAML · Cloud networking and private connectivity · ECS/Fargate · Datadog observability · Compliance-as-code · FinOps

**Languages:** English (fluent), Hindi (native) · 6+ years in remote-first distributed teams
