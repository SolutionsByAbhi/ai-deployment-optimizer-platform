# 🤖  AI‑Driven  Deployment  Optimizer  Platform   
###  GitHub  Actions +  Amazon  Bedrock  +  AWS CodePipeline

This  repository  implements an  **AI‑assisted  deployment  platform**  where **GitHub  Actions**,  **Amazon  Bedrock**,  and **AWS  CodePipeline**  work  together  to:

-  Analyze  each  deployment (changes,  tests,  risk  signals)
- Ask  an  AI  “deployment  advisor” which  strategy  to  use:
   -  **Canary**
   -  **Blue/Green**
    - **All‑at‑once**
    -  **Block /  require  human  review**
- Dynamically  configure  CodePipeline  /  CodeDeploy behavior  based  on  AI  output

It’s  designed  as  a **portfolio‑grade  project**  that  shows  you can  combine:

-  DevOps &  CI/CD
-  AI  reasoning (Bedrock)
-  Cloud  architecture  (IAM, Lambda,  CodePipeline,  S3)
-  Risk‑aware deployment  strategies

---

##  High‑Level  Flow

1. Developer  opens  a  PR  → GitHub  Actions  runs  tests  & build.
2.  On  merge  to `main`,  GitHub  Actions:
     -  Collects  metadata:  diff summary,  test  results,  service  risk profile.
      - Calls  the  **AI  Deployment  Advisor Lambda**  (Bedrock  behind  it).
3. The  AI  returns  a  JSON decision:
      - `strategy`:  `"canary"  |  "blue_green"  | "all_at_once"  |  "block"`
     -  `risk_score`:  `0–100`
     -  `notes`:  explanation.
4.  If  `block`  →  pipeline is  not  triggered,  GitHub  Action posts  a  comment.
5.  Otherwise →  GitHub  Actions  triggers  **CodePipeline** with  the  chosen  strategy  as a  parameter.
6.  CodePipeline  deploys using  the  selected  strategy  (e.g., CodeDeploy  canary  config).
7.  All decisions  are  logged  for  audit and  learning.

---

##  Key  Components

- **GitHub  Actions**
    - `ci-build.yml`  –  build  &  test on  PR.
    - `ai-deploy-optimizer.yml`  –  on  `main`  push, call  AI  advisor,  trigger  CodePipeline.

-  **AI  Deployment  Advisor (Lambda  +  Bedrock)**
   -  Receives  deployment  context  (diff summary,  tests,  service  criticality).
   -  Uses  a  Bedrock model  (e.g.,  Claude)  with  a structured  prompt.
    - Returns  a  JSON  decision.

-  **AWS  CodePipeline**
   -  Source:  GitHub  or  S3.
   -  Build:  CodeBuild (optional).
    -  Deploy: CodeDeploy  /  ECS  /  Lambda with  strategy  parameter.

- **Terraform**
    -  IAM roles  &  policies.
   -  Lambda  +  S3  artifact bucket.
    -  CodePipeline definition.

---

## Quick  Start

1.  **Deploy infra**

```bash
cd  infra/terraform
terraform  init
terraform  apply  -var="region=us-east-1" -var="project_prefix=ai-deploy-opt"
