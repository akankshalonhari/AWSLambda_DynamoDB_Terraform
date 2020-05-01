data "archive_file" "zipfile" {
	type	=	"zip"
	source_dir	= var.source_dir
	output_path	= "${var.dest_dir}/${var.dest_pkg}"
}