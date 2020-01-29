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
  default_compartment_id  = var.default_compartment_id
  
  vcn_options             = {
    display_name          = "simple test"
    cidr                  = "10.0.0.0/24"
    enable_dns            = true
    dns_label             = "simpletest"
    compartment_id        = null
    defined_tags          = null
    freeform_tags         = null
  }
  
  svcgw_options           = {
    display_name          = null
    compartment_id        = null
    defined_tags          = null
    freeform_tags         = null
    services              = [
      module.oci_network.svcgw_services.0.id
    ]
  }

  create_igw              = true
  create_svcgw            = true
  create_natgw            = true
  create_drg              = true
  
  route_tables            = {
    int_systems           = {
      compartment_id      = null
      defined_tags        = null
      freeform_tags       = null
      route_rules         = [
        {
          dst             = "192.168.0.0/24"
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
      compartment_id      = null
      server_type         = local.dhcp_option_types["custom"]
      forwarder_1_ip      = "10.0.0.11"
      forwarder_2_ip      = "10.0.2.11"
      forwarder_3_ip      = null
      search_domain_name  = "test.local"
    }
    vcn                   = {
      compartment_id      = null
      server_type         = local.dhcp_option_types["vcn"]
      forwarder_1_ip      = null
      forwarder_2_ip      = null
      forwarder_3_ip      = null
      search_domain_name  = null
    }
  }
}
