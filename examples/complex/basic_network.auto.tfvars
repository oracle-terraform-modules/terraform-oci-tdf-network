# VCN Configurations
vcn_compartment_id    = null
vcn_name              = "test complex VCN"
vcn_cidr              = "10.10.10.0/24"
vcn_enable_dns        = true
vcn_dns_label         = "test"

dns_custom_compartment_id = null
dns_vcn_compartment_id    = null
dns_forwarder_1       = "10.0.0.11"
dns_forwarder_2       = "10.0.2.11"
dns_forwarder_3       = null
dns_domain_name       = "test.oraclevcn.com"

svcgw_name            = "my_svcgw"
svcgw_compartment_id  = null

natgw_name            = "my_natgw"
natgw_compartment_id  = null
natgw_block_traffic   = false

igw_name              = "my_igw"
igw_compartment_id    = null
igw_enabled           = true

drg_name              = "my_drg"
drg_compartment_id    = null
drg_route_table_id    = null

create_igw            = true
create_svcgw          = true
create_natgw          = true
create_drg            = true

on_prem_cidr          = "192.168.0.0/24"