provider "aws" {
  region     = "ap-south-1"
  access_key = "accesskey"
  secret_key = "secretkey"
}

module "webserver-1" {
  source = ".//module-1"
}

module "webserver-2" {
  source = ".//module-2"
}
