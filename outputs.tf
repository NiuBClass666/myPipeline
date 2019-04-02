output "address" {
  value = "${module.ELB.dns_name}"
}