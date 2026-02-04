variable  "project_prefix"  {  type  = string  }
variable  "role_arn"            {  type  =  string  }
variable  "bucket_name"       {  type  =  string  }

resource  "aws_lambda_function"  "ai_advisor"  {
   function_name  =  "${var.project_prefix}-ai-deployment-advisor"
   role                  =  var.role_arn
   handler             =  "handler.lambda_handler"
   runtime             = "python3.11"
    timeout            =  15

   filename                 = "${path.module}/../../../lambdas/ai-deployment-advisor/dist/ai-deployment-advisor.zip"
    source_code_hash  = filebase64sha256("${path.module}/../../../lambdas/ai-deployment-advisor/dist/ai-deployment-advisor.zip")

    environment {
       variables  =  {
           AWS_REGION =  "us-east-1"
       }
    }
}

output  "lambda_arn"  {
   value  =  aws_lambda_function.ai_advisor.arn
}
