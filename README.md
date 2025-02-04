# Terraform Load Balancer Setup with Public and Private Subnets

This Terraform project automates the creation of an AWS infrastructure consisting of external and internal load balancers, proxy instances, and backend instances, with traffic routing between them through public and private subnets.

## Architecture Overview

The architecture consists of:
- **External Load Balancer**: Exposed to the internet, directing traffic to two proxy instances.
- **Proxy Instances**: Hosted in two public subnets, these instances forward traffic to the internal load balancer.
- **Internal Load Balancer**: Operates within two private subnets and routes traffic to backend instances.
- **Backend Instances**: Located in private subnets, these instances handle application-level traffic from the internal load balancer.

### Traffic Flow:
1. The **external load balancer** receives internet traffic.
2. Traffic is directed to **proxy instances** in public subnets.
3. The **proxy instances** route the traffic to the **internal load balancer**.
4. The **internal load balancer** distributes traffic to **backend instances** in private subnets.

## Resources Created

- **External Load Balancer (ALB)**: Configured to distribute traffic to proxy instances.
- **Proxy EC2 Instances**: Two EC2 instances in public subnets that forward traffic to the internal load balancer.
- **Internal Load Balancer (NLB)**: Routes traffic from the proxy instances to backend instances.
- **Backend EC2 Instances**: Two EC2 instances in private subnets, receiving traffic from the internal load balancer.

## Requirements

- Terraform 0.12+.
- AWS account and proper IAM permissions to create VPC, EC2 instances, load balancers, and other required resources.
- AWS credentials configured via AWS CLI or environment variables.

## Setup

### 1. Clone the repository

```bash
git clone https://github.com/your-username/terraform-loadbalancer-setup.git
cd terraform-loadbalancer-setup
