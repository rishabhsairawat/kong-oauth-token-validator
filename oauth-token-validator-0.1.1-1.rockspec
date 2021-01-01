package = "oauth-token-validator"
version = "0.1.1-1"
source = {
   url = "git+ssh://git@github.com/rishabhsairawat/kong-oauth-token-validator.git",
   tag = "0.1.1"
}
description = {
   summary = "OAuth2 Token Validator Plugin for Kong",
   homepage = "https://github.com/rishabhsairawat/kong-oauth-token-validator",
   license = "MIT"
}
build = {
   type = "builtin",
   modules = {
      access = "src/access.lua",
      handler = "src/handler.lua",
      schema = "src/schema.lua"
   }
}
