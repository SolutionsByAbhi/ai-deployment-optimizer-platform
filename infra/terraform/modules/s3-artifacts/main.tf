 variable  "project_prefix"  {  type =  string  }
 
 resource "aws_s3_bucket"  "artifacts"  {
    bucket  =  "${var.project_prefix}-artifacts"
 }
 
resource  "aws_s3_bucket_versioning"  "versioning"  {
    bucket  =  aws_s3_bucket.artifacts.id
    versioning_configuration  {
        status  =  "Enabled"
    }
 }
 
output  "bucket_name"  {
    value  =  aws_s3_bucket.artifacts.bucket
 }
