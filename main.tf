provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAU5OVVT5TENUMEHDZ"
  secret_key = "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"
}

module "webserver-1" {
  source = ".//module-1"
}


module "webserver-2" {
  source = ".//module-2"
}
