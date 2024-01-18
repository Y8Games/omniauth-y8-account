# OmniAuth Y8 Account (0.3.0)

This is the official OmniAuth strategy for authenticating to [Y8 Account](https://account.y8.com). To
use it, you'll need Y8 Account consumer application ID and SECRET.

## Basic Usage
Currently, you have to initialize OmniAuth (with Y8 Account strategy) like this:

    provider :y8_account, APP_CONFIG[:app_id], APP_CONFIG[:app_secret]

Where,
```ruby
APP_CONFIG[:app_id] - application ID
APP_CONFIG[:app_secret] - application SECRET
```

This way, Y8 Account strategy will be initialized with the set of default fields:

```ruby
DEFAULT =
  %w[
    nickname
    first_name
    last_name
    email
    language
    gender
    street_address
    city
    country
    state_or_province
    zip
    dob
    level
    avatars
    version
    risk
  ]
```

See [OAuth2::Client description](https://gitlab.com/oauth-xx/oauth2/-/blob/main/lib/oauth2/client.rb) for more details

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :y8_account, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
           client_options: {
             site: "http://custom.y8_account.server.org/",
             authorize_url: "http://custom.y8_account.server.org/oauth/authorize",
             token_url: "http://custom.y8_account.server.org/oauth/token"
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
