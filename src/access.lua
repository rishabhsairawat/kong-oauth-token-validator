local cjson = require "cjson"
local http = require("resty.http")

local response = kong.response
local log = ngx.log
local ERROR = ngx.ERR
local DEBUG = ngx.DEBUG

local _M = {}

local function has_scope(scopes_table, scope)
  for key, value in ipairs(scopes_table) do
    if(value == scope) then
      return true
    end
  end
  return false
end

local function get_first_auth_header
  local auth_header = ngx.req.get_headers()['Authorization']
  if auth_header and type(auth_header) == 'table' then
    auth_header = auth_header[1]
  end
  return auth_header
end

function _M.execute(conf)
  local oauth_server_url = conf.oauth_server_url
  local configured_scope = conf.scope
  local authorization = get_first_auth_header
  local keepalive_timeout = conf.keepalive_timeout

  local httpc = http.new()
  local res, err = httpc:request_uri(oauth_server_url, {
    method = 'GET',
    headers = {
      ['Authorization'] = authorization,
    },
    keepalive_timeout = keepalive_timeout
  })

  if not res then
    log(ERROR, 'Error occurred while connecting with oauth server: ', err) 
    return response.exit(500, 'Some error occurred')
  end

  -- For all not success, returning unauthorized
  if(res.status ~= 200) then
    log(DEBUG, 'Received non success response from authorization server')
    return response.exit(401, 'Unauthorized Request')
  end

  -- Only Authentication is needed i.e. only check response status
  if configured_scope == "" then
    log(DEBUG, 'Request authenticated successfully')
    return
  -- Authorization is also need to be checked i.e. check for the required scopes also
  -- (Response should be a valid JSON string which should have scope key with array value)
  else
    local status, result = pcall(cjson.decode, res.read_body)
    if status then
      if has_scope(result.scope, configured_scope) then
        log(DEBUG, 'Request authorized successfully')
        return
      else
        log(DEBUG, 'Configured scope not present in the token')
        return response.exit(403, 'Forbidden Request')
    end
  end
end

return _M
