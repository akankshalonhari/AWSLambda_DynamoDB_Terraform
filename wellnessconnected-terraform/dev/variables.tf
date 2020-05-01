variable "region" {
	default = "us-east-1"
}

variable "deployment_name" {
	default = "wellnessconnected-lambdas"
}

variable "env_type" {
	type	= map
	default = {
		prod = "prod"
		dev  = "npe"
		qa	 = "npe"	
	}	
}