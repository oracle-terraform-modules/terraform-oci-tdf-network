# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

locals {
  next_hop_ids            = {
    "drg"                 = module.oci_network.drg.drg.id
    "igw"                 = module.oci_network.igw.id
    "svcgw"               = module.oci_network.svcgw.id
    "natgw"               = module.oci_network.natgw.id
  }
  dhcp_option_types       = {
    "vcn"                 = "VcnLocalPlusInternet"
    "custom"              = "CustomDnsServer"
  }
}

module "oci_network" {
  source                  = "../../"
  
  
  default_compartment_id  = "${var.default_compartment_id}"
  
  vcn_options             = {
    display_name          = var.vcn_name
    cidr                  = var.vcn_cidr
    enable_dns            = var.vcn_enable_dns
    dns_label             = var.vcn_dns_label
    compartment_id        = var.vcn_compartment_id
    defined_tags          = null
    freeform_tags         = null
  }
  
  svcgw_options           = {
    display_name          = var.svcgw_name
    compartment_id        = var.svcgw_compartment_id
    defined_tags          = null
    freeform_tags         = null
    # this cannot be parameterized, because we cannot reference variables in .tfvars files
    services              = [
      module.oci_network.svcgw_services.0.id
    ]
  }

  natgw_options           = {
    display_name          = var.natgw_name
    compartment_id        = var.natgw_compartment_id
    defined_tags          = null
    freeform_tags         = null
    block_traffic         = var.natgw_block_traffic
  }

  igw_options             = {
    display_name          = var.igw_name
    compartment_id        = var.igw_compartment_id
    defined_tags          = null
    freeform_tags         = null
    enabled               = var.igw_enabled
  }

  drg_options             = {
    display_name          = var.drg_name
    compartment_id        = var.drg_compartment_id
    defined_tags          = null
    freeform_tags         = null
    route_table_id        = var.drg_route_table_id
  }

  create_igw              = var.create_igw
  create_svcgw            = var.create_svcgw
  create_natgw            = var.create_natgw
  create_drg              = var.create_drg
  
  
  route_tables            = {
    int_systems           = {
      compartment_id      = null
      defined_tags        = null
      freeform_tags       = null
      route_rules         = [
        {
          dst             = var.on_prem_cidr
          dst_type        = "CIDR_BLOCK"
          next_hop_id     = local.next_hop_ids["drg"]
        },
        {
          dst             = "0.0.0.0/0"
          dst_type        = "CIDR_BLOCK"
          next_hop_id     = local.next_hop_ids["natgw"]
        }
      ]
    },
    dmz_systems           = {
      compartment_id      = null
      defined_tags        = null
      freeform_tags       = null
      route_rules         = [
        {
          dst             = "0.0.0.0/0"
          dst_type        = "CIDR_BLOCK"
          next_hop_id     = local.next_hop_ids["igw"]
        }
      ]
    }
  }

  dhcp_options            = {
    custom                = {
      compartment_id      = var.dns_custom_compartment_id
      server_type         = local.dhcp_option_types["custom"]
      forwarder_1_ip      = var.dns_forwarder_1
      forwarder_2_ip      = var.dns_forwarder_2
      forwarder_3_ip      = var.dns_forwarder_3
      search_domain_name  = var.dns_domain_name
    }
    vcn                   = {
      compartment_id      = var.dns_vcn_compartment_id
      server_type         = local.dhcp_option_types["vcn"]
      forwarder_1_ip      = null
      forwarder_2_ip      = null
      forwarder_3_ip      = null
      search_domain_name  = null
    }
  }
}
