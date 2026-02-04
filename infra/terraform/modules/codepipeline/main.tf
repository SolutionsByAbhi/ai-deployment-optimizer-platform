variable "project_prefix"      {  type =  string  }
variable  "artifact_bucket"   {  type  =  string }
variable  "service_role_arn"  {  type =  string  }
variable  "github_repo"          {  type  =  string  }
variable  "github_branch"       {  type  =  string  }

resource  "aws_codepipeline"  "this"  {
   name         =  "${var.project_prefix}-pipeline"
   role_arn  =  var.service_role_arn

   artifact_store  {
       type         =  "S3"
       location =  var.artifact_bucket
    }

    stage  {
       name =  "Source"

       action  {
          name                        =  "Source"
          category                =  "Source"
           owner                     =  "ThirdParty"
           provider                =  "GitHub"
          version                  =  "1"
           output_artifacts  = ["SourceOutput"]

           configuration  = {
               Owner          =  split("/",  var.github_repo)[0]
              Repo             =  split("/", var.github_repo)[1]
               Branch         = var.github_branch
               OAuthToken =  "REPLACE_WITH_GITHUB_TOKEN_IN_PARAMETER_STORE"
           }
       }
   }

   stage  {
       name  =  "Deploy"

       action {
           name                      = "Deploy"
           category              =  "Deploy"
           owner                    = "AWS"
           provider              =  "CodeDeploy"
           input_artifacts  = ["SourceOutput"]
           version                =  "1"

          configuration  =  {
              ApplicationName         =  "${var.project_prefix}-app"
              DeploymentGroupName  =  "${var.project_prefix}-dg"
          }
       }
    }
}

output  "pipeline_name"  {
   value  =  aws_codepipeline.this.name
}
