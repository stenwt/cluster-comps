# If looking up a cluster profile instead of creating a new one
# data "spectrocloud_cluster_profile" "profile" {
#   # id = <uid>
#   name = "eks-basic"
# }
#

data "spectrocloud_registry" "registry" {
  name = "Public Repo"
}

data "spectrocloud_pack" "aws-ssm-agent" {
  name    = "aws-ssm-agent"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.0.0"
}

data "spectrocloud_pack" "spectro-rbac" {
  name    = "spectro-rbac"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.0.0"
}

data "spectrocloud_pack" "csi" {
  name    = "csi-aws-ebs"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.16.0"
}

data "spectrocloud_pack" "cni" {
  name    = "cni-aws-vpc-eks"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.0"
}

data "spectrocloud_pack" "k8s" {
  name    = "kubernetes-eks"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.24"
}

data "spectrocloud_pack" "linux" {
  name    = "amazon-linux-eks"
  registry_uid = data.spectrocloud_registry.registry.id
  version = "1.0.0"
}

resource "spectrocloud_cluster_profile" "profile" {
  name        = "amazon-eks-infra-profile1"
  description = "basic eks cp"
  cloud       = "eks"
  type        = "cluster"

  pack {
    name   = data.spectrocloud_pack.linux.name
    tag    = data.spectrocloud_pack.linux.version
    uid    = data.spectrocloud_pack.linux.id
    values = data.spectrocloud_pack.linux.values
  }
  pack {
    name   = data.spectrocloud_pack.k8s.name
    tag    = data.spectrocloud_pack.k8s.version
    uid    = data.spectrocloud_pack.k8s.id
    values = data.spectrocloud_pack.k8s.values
  }

  pack {
    name   = data.spectrocloud_pack.cni.name
    tag    = data.spectrocloud_pack.cni.version
    uid    = data.spectrocloud_pack.cni.id
    values = data.spectrocloud_pack.cni.values
  }

  pack {
    name   = data.spectrocloud_pack.csi.name
    tag    = data.spectrocloud_pack.csi.version
    uid    = data.spectrocloud_pack.csi.id
    values = data.spectrocloud_pack.csi.values
  }
}

resource "spectrocloud_cluster_profile" "profile-rbac" {
  name        = "spectrocloud-rbac-addons"
  description = "rbac"
  type        = "add-on"

  pack {
    name   = data.spectrocloud_pack.aws-ssm-agent.name
    tag    = data.spectrocloud_pack.aws-ssm-agent.version
    uid    = data.spectrocloud_pack.aws-ssm-agent.id
    values = data.spectrocloud_pack.aws-ssm-agent.values
  }
  pack {
    name   = data.spectrocloud_pack.spectro-rbac.name
    tag    = data.spectrocloud_pack.spectro-rbac.version
    uid    = data.spectrocloud_pack.spectro-rbac.id
    values = data.spectrocloud_pack.spectro-rbac.values
  }
}
