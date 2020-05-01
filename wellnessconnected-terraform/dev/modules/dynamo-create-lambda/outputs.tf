output "invoke_arn" {
	value	= "${aws_lambda_function.node_lambda.invoke_arn}"
}

output "qualified_arn" {
	value	= "${aws_lambda_function.node_lambda.qualified_arn}"
}