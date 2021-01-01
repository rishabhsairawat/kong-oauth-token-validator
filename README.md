# kong-oauth-token-validator
Simple OAuth2 token validation plugin for Kong. If oauth token scope is not configured, it simply checks for response status from oauth server's token validation API otherwise it also validates the scope of the token.

---

## How to use it
<pre>
$ cd /path/to/your/custom/kong/plugins
$ git clone https://github.com/rishabhsairawat/kong-oauth-token-validator oauth-token-validator
$ cd oauth-token-validator
$ luarocks make
</pre>


Add `oauth-token-validator` to your custom_plugins property of your `kong.conf` file.

Then, restart kong

---
