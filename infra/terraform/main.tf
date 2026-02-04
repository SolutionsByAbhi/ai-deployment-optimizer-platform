module  "s3_artifacts"  {
   source                 = "./modules/s3-artifacts"
    project_prefix  = var.project_prefix
}

module  "iam" {
    source                =  "./modules/iam"
   project_prefix  =  var.project_prefix
}

module  "lambda_ai_advisor"  {
   source                =  "./modules/lambda-ai-advisor"
    project_prefix =  var.project_prefix
    role_arn            =  module.iam.lambda_role_arn
   bucket_name        = module.s3_artifacts.bucket_name
}

module  "codepipeline" {
    source                =  "./modules/codepipeline"
   project_prefix  =  var.project_prefix
   artifact_bucket  =  module.s3_artifacts.bucket_name
   service_role_arn  =  module.iam.codepipeline_role_arn
   github_repo           =  var.github_repo
   github_branch       =  var.github_branch
}
