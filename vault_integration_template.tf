provider "vault" {
  address = "https://your-vault-url"

  // Authentication method (e.g., token, userpass, etc.)
  auth {
    method = "token"
    config = {
      token = "your-vault-token"
    }
  }
}
resource "vault_generic_secret" "example_secret" {
  path = "secret/myapp/credentials"

  data = {
    username = "myusername"
    password = "secretpassword"
  }
}
# terraform apply
