local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.oauth_token_validator.access"

local OauthTokenHandler = BasePlugin:extend()

OauthTokenHandler.PRIORITY = 900

function OauthTokenHandler:new()
  OauthTokenHandler.super.new(self, "oauth_token_validator")
end

-- Since this plugin will run before request is proxied to the upstream server,
-- our access function will have to take care of authentication/authorization for the request
function OauthTokenHandler:access(conf)
  OauthTokenHandler.super.access(self)
  access.execute(conf)
end

return OauthTokenHandler
