/* 

Output file to highlight customized outputs that are useful 
(compared to the hundreds of attributes Terraform stores)

To see the output after the apply, use the command: "terraform output"

Note: Since we're using the official VPC and sg modules, you can NOT
create your own outputs for those modules, unless you create them as 
outputs for a new module (and nest these modules within)

 */

output "cluster_size" {
  value = length(aws_instance.cluster_master) + length(aws_instance.cluster_workers)
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "caller_user" {
  value = "${data.aws_caller_identity.current.user_id}"
}