# If looking up a cluster profile instead of creating a new one
# data "spectrocloud_cluster_profile" "profile" {
#   # id = <uid>
#   name = var.cluster_cluster_profile_name
# }

data "spectrocloud_registry" "registry" {
  name = "Public Repo"
}

data "spectrocloud_pack" "csi" {
  name = "csi-aws-ebs"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "1.16.0"
}

data "spectrocloud_pack" "cni" {
  name    = "cni-cilium-oss"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.12.6"
}

data "spectrocloud_pack" "k8s" {
  name    = "kubernetes"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.26.1"
}

data "spectrocloud_pack" "linux" {
  name = "ubuntu-aws"
  registry_uid = data.spectrocloud_registry.registry.id
  version  = "22.04"
}

data "spectrocloud_pack" "wordpress" {
  name    = "wordpress-chart"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "5.4.1"
}

resource "spectrocloud_cluster_profile" "profile" {
  name        = "aws-cluster-profile1"
  description = "aws iaas cluster profile"
  tags        = ["terraform-managed:true"]
  cloud       = "aws"
  type        = "cluster"

  pack {
    name   = data.spectrocloud_pack.csi.name
    tag    = data.spectrocloud_pack.csi.version
    uid    = data.spectrocloud_pack.csi.id
    values = data.spectrocloud_pack.csi.values
  }

  pack {
    name   = data.spectrocloud_pack.cni.name
    tag    = data.spectrocloud_pack.cni.version
    uid    = data.spectrocloud_pack.cni.id
    values = data.spectrocloud_pack.cni.values
  }

  pack {
    name   = data.spectrocloud_pack.k8s.name
    tag    = data.spectrocloud_pack.k8s.version
    uid    = data.spectrocloud_pack.k8s.id
    values = data.spectrocloud_pack.k8s.values
  }

  pack {
    name   = data.spectrocloud_pack.linux.name
    tag    = data.spectrocloud_pack.linux.version
    uid    = data.spectrocloud_pack.linux.id
    values = data.spectrocloud_pack.linux.values
  }
}

resource "spectrocloud_cluster_profile" "wordpress" {
  name        = "wordpress1"
  description = "basic application cp"
  type        = "add-on"

  pack {
    name   = data.spectrocloud_pack.wordpress.name
    tag    = data.spectrocloud_pack.wordpress.version
    uid    = data.spectrocloud_pack.wordpress.id
    values = data.spectrocloud_pack.wordpress.values
  }
}


