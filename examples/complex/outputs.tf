# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "vcn" {
  description = "VCN"
  value       = module.oci_network.vcn
}

output "igw" {
  description = "IGW"
  value       = module.oci_network.igw
}

output "svcgw" {
  description = "SVCGW"
  value       = module.oci_network.svcgw
}

output "svcgw_services" {
  description = "SVCGW Services"
  value       = module.oci_network.svcgw_services
}

output "natgw" {
  description = "NATGW"
  value       = module.oci_network.natgw
}

output "drg" {
  description = "DRG"
  value       = module.oci_network.drg
}

output "dhcp_options" {
  value       = module.oci_network.dhcp_options
}

output "route_tables" {
  value       = module.oci_network.route_tables
}
