-- TODO: Write a validator for url
return {
  -- This plugin will not be specific to kong consumers
  no_consumer = true,
  fields = {
    -- This oauth_server_url will contains the oauth2 server's token validation URL
    oauth_server_url = { required = true, type = "string" },
    -- Scope should only be used when authorization is also required
    scope = { default = "", type = "string" },
    -- Keepalive timeout for token validation call
    keepalive_timeout = { default = 60000, type = "number" }
  }
}
