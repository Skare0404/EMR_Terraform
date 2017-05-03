provider "aws" {
  access_key = "xxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
  region     = "us-west-2"
}

resource "aws_emr_cluster" "emr-test-cluster" {
  name          = "emr-test-arn"
  release_label = "emr-4.6.0"
  applications  = ["Spark"]

  termination_protection = false
  keep_job_flow_alive_when_no_steps = true

  ec2_attributes {
    subnet_id                         = "subnet-53a37834"
    emr_managed_master_security_group = "sg-xxxxxx"
    emr_managed_slave_security_group  = "sg-xxxxxx"
    instance_profile                  = "arn:aws:iam::121492707555:instance-profile/EMR_EC2_DefaultRole"
  }

  master_instance_type = "m3.xlarge"
  core_instance_type   = "m3.xlarge"
  core_instance_count  = 1

  tags {
    role     = "spark_ins"
    env      = "env"
  }
log_uri = "s3://emrbucket54/logs1"
/*
  bootstrap_action {
    path = "s3://elasticmapreduce/bootstrap-actions/run-if"
    name = "runif"
    args = ["instance.isMaster=true", "echo running on master node"]
  }
*/
#  configurations = "test-fixtures/emr_configurations.json"


  service_role = "arn:aws:iam::121492707555:role/EMR_DefaultRole"
}


