provider "rancher2" {
  api_url     = "${var.RANCHER_URL}"
  access_key  = "${var.RANCHER_ACCESSKEY}"
  secret_key  = "${var.RANCHER_SECRETKEY}"
}
