output "role_arn" {
	value = "${aws_iam_role.role.arn}"
}

output "output_role_name" {
	value = "${aws_iam_role.role.name}"
}