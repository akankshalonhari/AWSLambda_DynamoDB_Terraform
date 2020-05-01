provider "aws" {
	version = "~> 2.7"
	region = var.region
}

terraform {
	backend "s3" {
		bucket	= "and-wellnessconnected-terraform-npe"
		key		= "dev/terraform.tfstate"
		region	= "us-east-1"
		dynamodb_table	= "wc-terraform-locks"
		encrypt	= true
	
	}
}

module adminLambdaRole {
	source = "./modules/admin-lambda-role"
	iam_role_name = "${var.current_env}-DynamoAdminLambdaRole"	
}

module "dynamodbCreateLambdaPkg" {
	source	= "./modules/zip"
	source_dir = "../../cd_workspace/wellnessconnected-lambdas/dynamo-readings-create"
	dest_dir = "../../cd_staging"
	dest_pkg = "dynamo-create.zip"
}

module "dynamoCreateLambda" {
	source = "./modules/dynamo-create-lambda"
	function_name = "${var.current_env}-dynamo-readings-create"
	region = var.region
	role_arn = "${module.adminLambdaRole.role_arn}"
	s3_bucket = "and-wellnessconnected-terraform-${var.env_type["${var.current_env}"]}"
	lambda_pkg = "dynamo-create.zip"
	#lambda_pkg = "${module.dynamodbCreateLambdaPkg.filename}"
	current_env	= var.current_env
}