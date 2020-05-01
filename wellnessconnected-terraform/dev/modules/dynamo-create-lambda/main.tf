resource "aws_s3_bucket_object" "lambdaS3Upload" {
	bucket = var.s3_bucket
	key		= "${var.current_env}-artifacts/lambdas/${var.lambda_pkg}"
	source	= "../../cd_staging/${var.lambda_pkg}"
	etag	= filemd5("../../cd_staging/${var.lambda_pkg}")
}

resource "aws_lambda_function" "node_lambda" {
	s3_bucket	= aws_s3_bucket_object.lambdaS3Upload.bucket
	s3_key		= aws_s3_bucket_object.lambdaS3Upload.key
	# s3_object_version		= aws_s3_bucket_object.lambdaS3Upload.version_id
	function_name	= var.function_name
	role		= var.role_arn
	handler		= "index.handler"
	publish		= true
	source_code_hash	= filebase64sha256("../../cd_staging/${var.lambda_pkg}")
	runtime	= "nodejs12.x"
	#environment {
	#	variables {
	#	
	#	}
	#}
}