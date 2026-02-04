 variable  "region"  {
    type               = string
     description  = "AWS  region"
     default         = "us-east-1"
 }
 
 variable  "project_prefix" {
     type              =  string
    description  =  "Prefix  for  resource names"
     default         =  "ai-deploy-opt"
}
 
 variable  "github_repo"  {
    type              =  string
     description =  "GitHub  repo  (owner/name)"
 }

 variable  "github_branch"  {
    type               = string
     description  = "Branch  for  CodePipeline  source"
    default         =  "main"
 }
