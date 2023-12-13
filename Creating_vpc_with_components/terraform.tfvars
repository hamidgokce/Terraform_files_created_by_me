name   = "created by terraform"
region = "us-east-1"

vpc_cidr_block     = "10.0.0.0/16"
availability_zones = ["a", "b", "c"]
public_subnet_cidr_blocks = {
  "a" = "10.0.10.0/24"
  "b" = "10.0.12.0/24"
  "c" = "10.0.14.0/24"
}
private_subnet_cidr_blocks = {
  "a" = "10.0.11.0/24"
  "b" = "10.0.13.0/24"
  "c" = "10.0.15.0/24"
}


security_group_name = "security-group"
ingress_ports = [{
  port        = 22
  description = "SSH"
  },
  {
    port        = 80
    description = "HTTP"
  },
  {
    port        = 443
    description = "HTTPS"
  },
  {
    port        = 9090
    description = "Prometheus"
  },
  {
    port        = 9100
    description = "Node Exporter"
  },
  {
    port        = 3000
    description = "Grafana"
}]

ingress_ports_nexp = [{
  port        = 22
  description = "SSH"
  },
  {
    port        = 80
    description = "HTTP"
  },
  {
    port        = 443
    description = "HTTPS"
  },

  {
    port        = 9100
    description = "Node Exporter"
  },
]

egress_ports = [{
  port        = 0
  description = "All traffic"
}]

ami_owners              = "099720109477"
ami_name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
ami_virtualization-type = "hvm"
instance_type           = "t2.micro"
key_name                = "Aws_key"
user_data_file_ps       = "user_data_prometheus_gafana.sh"
user_data_file_nexp     = "user_data_node_exporter.sh"