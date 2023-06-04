provider "aws" {
  region     = "ap-south-1"
  access_key = "access_key"
  secret_key = "secret_key"
}

module "webserver-1" {
  source = ".//module-1"
}


module "webserver-2" {
  source = ".//module-2"
}
