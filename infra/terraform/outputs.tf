output "artifact_bucket"  {
    value =  module.s3_artifacts.bucket_name
}

output "ai_advisor_lambda_arn"  {
    value =  module.lambda_ai_advisor.lambda_arn
}

output "codepipeline_name"  {
    value =  module.codepipeline.pipeline_name
}
