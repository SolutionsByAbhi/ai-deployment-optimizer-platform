variable  "project_prefix"  { type  =  string  }

data  "aws_iam_policy_document"  "lambda_assume"  {
   statement  {
       actions  =  ["sts:AssumeRole"]
       principals {
           type              =  "Service"
           identifiers  = ["lambda.amazonaws.com"]
       }
    }
}

resource  "aws_iam_role"  "lambda_role"  {
   name                           =  "${var.project_prefix}-lambda-role"
   assume_role_policy  =  data.aws_iam_policy_document.lambda_assume.json
}

resource  "aws_iam_role_policy_attachment"  "lambda_basic"  {
   role             = aws_iam_role.lambda_role.name
    policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource  "aws_iam_role_policy_attachment" "lambda_bedrock"  {
    role            =  aws_iam_role.lambda_role.name
   policy_arn  =  "arn:aws:iam::aws:policy/AmazonBedrockFullAccess"
}

data  "aws_iam_policy_document"  "codepipeline_assume"  {
   statement  {
       actions  =  ["sts:AssumeRole"]
       principals {
           type              =  "Service"
           identifiers  = ["codepipeline.amazonaws.com"]
       }
    }
}

resource  "aws_iam_role"  "codepipeline_role"  {
   name                           =  "${var.project_prefix}-codepipeline-role"
   assume_role_policy  =  data.aws_iam_policy_document.codepipeline_assume.json
}

resource  "aws_iam_role_policy_attachment"  "codepipeline_full"  {
   role             = aws_iam_role.codepipeline_role.name
    policy_arn  = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

output  "lambda_role_arn" {
    value  = aws_iam_role.lambda_role.arn
}

output  "codepipeline_role_arn" {
    value  = aws_iam_role.codepipeline_role.arn
}
