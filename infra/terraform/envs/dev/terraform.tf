terraform {
  backend "s3" {
    bucket         = "aegis-tf-state-1756686579"   # e.g., ${env.TF_STATE_BUCKET}
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "aegis-tf-locks"
    encrypt        = true
  }
}