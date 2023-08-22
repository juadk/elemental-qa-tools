# Helm resources

# Install cert-manager helm chart
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  chart            = "https://charts.jetstack.io/charts/cert-manager-v${var.cert_manager_version}.tgz"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true
  timeout          = 90

  set {
    name  = "installCRDs"
    value = "true"
  }
}

# Install Rancher helm chart
resource "helm_release" "rancher_server" {
  depends_on = [
    helm_release.cert_manager,
  ]

  name             = "rancher"
  chart            = "rancher"
  repository       = "${var.rancher_helm_repository}"
  devel            = "${var.rancher_devel_version}"
  version	         = "${var.rancher_version}"
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "bootstrapPassword"
    value = "admin" # TODO: change this once the terraform provider has been updated with the new pw bootstrap logic
  }
}

# Install Elemental crds
resource "helm_release" "elemental_operator_crds" {
  depends_on = [
    helm_release.rancher_server,
  ]
  name             = "elemental-operator-crds"
  chart            = "elemental-operator-crds-chart"
  repository       = "oci://registry.opensuse.org/isv/rancher/elemental/${var.elemental_operator_version}/charts/rancher"
  namespace        = "cattle-elemental-system"
  create_namespace = true
  wait             = true
  timeout          = 90
}

# Install Elemental operator
resource "helm_release" "elemental_operator" {
  depends_on = [
    helm_release.elemental_operator_crds,
  ]
  name             = "elemental-operator"
  chart            = "elemental-operator-chart"
  repository       = "oci://registry.opensuse.org/isv/rancher/elemental/${var.elemental_operator_version}/charts/rancher"
  namespace        = "cattle-elemental-system"
  create_namespace = true
  wait             = true
  timeout          = 90
}
