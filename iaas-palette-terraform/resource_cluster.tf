
resource "spectrocloud_cluster_aws" "cluster" {
  name = "aws-iaas-cluster1"
  cluster_profile {
    id = spectrocloud_cluster_profile.profile.id
  }
  cloud_account_id = spectrocloud_cloudaccount_aws.account.id

  cloud_config {
    ssh_key_name = var.aws_ssh_key_name
    region       = var.aws_region
  }

  cluster_profile {
    id = spectrocloud_cluster_profile.wordpress.id
    pack {
      name   = "wordpress-chart"
      tag    = "5.4.1"
      values = ""
    }
  }

  machine_pool {
    control_plane           = true
    control_plane_as_worker = true
    name                    = "master-pool"
    count                   = 1
    instance_type           = "t3a.xlarge"
    disk_size_gb            = 62
    azs                     = [var.aws_region_az]
  }

  machine_pool {
    name          = "worker-basic"
    count         = 2
    instance_type = "t3a.xlarge"
    azs           = [var.aws_region_az]
  }

}
