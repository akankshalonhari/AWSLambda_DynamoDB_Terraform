provider "aws" {
	version = "~> 2.7"
	region = "${var.region}"
}

resource "aws_s3_bucket" "npe_terraform_state" {
	bucket = "and-wellnessconnected-terraform-npe"
	versioning {
		enabled = true
	}
	
	server_side_encryption_configuration {
		rule {
			apply_server_side_encryption_by_default {
				sse_algorithm = "AES256"
			}
		}
	}
}

resource "aws_dynamodb_table" "terraform_locks" {
	name	=	"wc-terraform-locks"
	billing_mode = "PAY_PER_REQUEST"
	hash_key	= "LockID"
	attribute {
		name	= "LockID"
		type	= "S"
	}
}