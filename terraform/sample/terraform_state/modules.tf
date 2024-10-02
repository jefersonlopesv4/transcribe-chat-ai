module "state" {
  source      = "../../modules/state"
  name        = local.account_name
  environment = local.environment
}
