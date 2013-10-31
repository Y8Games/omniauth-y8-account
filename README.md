# OmniAuth IdNet (0.0.6)

This is the official OmniAuth strategy for authenticating to [Id.net](https://www.id.net). To
use it, you'll need Id.net consumer application ID and SECRET.

## Basic Usage
Currently, you have to initialize OmniAuth (with Id.net strategy) like this:

    provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret]

This way, Id.net strategy will be initialized with the set of default fields:

```ruby
DEFAULT =
  [
    "nickname",
    "first_name",
    "last_name",
    "email",
    "language",
    "gender",
    "street_address",
    "city",
    "country",
    "state_or_province",
    "zip",
    "dob",
    "level",
    "avatars",
    "version",
    "risk"
  ]
```

Where,
```ruby
APP_CONFIG[:app_id] - application ID
APP_CONFIG[:app_secret] - application SECRET
```

Also, you may (if you know what to pass there, in this example, it's `http://custom.idnet.server.org/`) use custom provider URL:

See [OAuth2::Client description](https://github.com/intridea/oauth2/blob/master/lib/oauth2/client.rb) for more details

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
           :client_options => {:site => "http://custom.idnet.server.org/",
                               :authorize_url => "http://custom.idnet.server.org/oauth/authorize",
                               :token_url => "http://custom.idnet.server.org/oauth/token",
                               :ssl => {:verify => false} # if your provider does not use ssl
                             }
end
```
If no `:client_options` passed, default `https://www.id.net/` provider URL will be used.

This should be placed, for example, into `config/initializers/omniauth.rb`.

### Authentication popup
To invoke authentication popup, id.net provides a handy Javascrip available at:
```
https://www.id.net/api/popup.js
```

For example, for Ruby on Rails it could be included like this:
```ruby
<%= javascript_include_tag "http://#{APP_CONFIG[:idnet][:server]}/api/popup.js" %>
```
Then you may use jQuery to handle id.net authorization button clicks:

```javascript
var set_idnet_handlers = function () {
  $(".js-idnet-link.login").click(function() {
    open_idnet_signin_signup(this.href);
    return false;
  });

  $(".js-idnet-link.register").click(function() {
    var href = this.href;
    if (!href.match(/\?/)) href += '?';
    open_idnet_register(href + '&popup_window=true');
    return false;
  });
}
```

And HTML for button:
```html
<a class="js-idnet-link login" href="/auth/idnet">
<img src="/images/id.net-logo.png" alt="Id.net-logo">
<span class="id-net-link-label">Login with id.net</span>
</a>
```

## License

Copyright (c) 2013 Heliostech.fr

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
