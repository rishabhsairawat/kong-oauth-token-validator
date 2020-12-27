-- TODO: Write a validator for url
return {
  no_consumer = true,
  fields = {
    oauth_server_url = {required = true, type = "string"},
    scope = {required: true, type = "string"}
  }
}