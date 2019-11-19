terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-files-sei-qa"
    key            = "marketplace.tf"
    region         = "us-west-2"
    profile        = "qa"
    dynamodb_table = "terraform"
    encrypt        = true
  }
}
