# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "tenancy_id" {}
variable "user_id" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "default_compartment_id" {}

variable "vcn_name" {}
variable "vcn_cidr" {}
variable "vcn_enable_dns" {}
variable "vcn_dns_label" {}
variable "vcn_compartment_id" {}

variable "svcgw_name" {}
variable "svcgw_compartment_id" {}

variable "natgw_name" {}
variable "natgw_compartment_id" {}
variable "natgw_block_traffic" {}

variable "igw_name" {}
variable "igw_compartment_id" {}
variable "igw_enabled" {}

variable "drg_name" {}
variable "drg_compartment_id" {}
variable "drg_route_table_id" {}

variable "dns_custom_compartment_id" {}
variable "dns_vcn_compartment_id" {}
variable "dns_forwarder_1" {}
variable "dns_forwarder_2" {}
variable "dns_forwarder_3" {}
variable "dns_domain_name" {}
variable "on_prem_cidr" {}

variable "create_igw" {}
variable "create_svcgw" {}
variable "create_natgw" {}
variable "create_drg" {}
