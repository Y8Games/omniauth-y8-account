# OmniAuth Y8 Account (0.2.0)

This is the official OmniAuth strategy for authenticating to [Y8 Account](https://account.y8.com). To
use it, you'll need Y* Account consumer application ID and SECRET.

## Basic Usage
Currently, you have to initialize OmniAuth (with Y8 Account strategy) like this:

    provider :y8_account, APP_CONFIG[:app_id], APP_CONFIG[:app_secret]

This way, Y8 Account strategy will be initialized with the set of default fields:

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

See [OAuth2::Client description](https://github.com/intridea/oauth2/blob/master/lib/oauth2/client.rb) for more details

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :y8_account, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
           :client_options => {:site => "http://custom.y8_account.server.org/",
                               :authorize_url => "http://custom.y8_account.server.org/oauth/authorize",
                               :token_url => "http://custom.y8_account.server.org/oauth/token",
                               :ssl => {:verify => false} # if your provider does not use ssl
                             }
end
```
If no `:client_options` passed, default `https://account.y8.com/` provider URL will be used.

This should be placed, for example, into `config/initializers/omniauth.rb`.

### Authentication popup
To invoke authentication popup, Y8 Account provides a handy Javascrip available at:
```
https://account.y8.com/api/popup.js
```

For example, for Ruby on Rails it could be included like this:
```ruby
<%= javascript_include_tag "http://#{APP_CONFIG[:y8_account][:server]}/api/popup.js" %>
```
Then you may use jQuery to handle Y8 Account authorization button clicks:

```javascript
var set_y8_account_handlers = function () {
  $(".js-y8-account-link.login").click(function() {
    open_y8_account_signin_signup(this.href);
    return false;
  });

  $(".js-y8-account-link.register").click(function() {
    var href = this.href;
    if (!href.match(/\?/)) href += '?';
    open_idnet_register(href + '&popup_window=true');
    return false;
  });
}
```

And HTML for button:
```html
<a class="js-y8-account-link login" href="/auth/y8_account">
<img src="/images/y8-account-logo.png" alt="y8-account-logo">
<span class="y8-account-link-label">Login with Y8 Account</span>
</a>
```

## License

Copyright (c) 2013 Heliostech.fr

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
