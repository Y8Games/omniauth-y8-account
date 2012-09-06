# OmniAuth IdNet (0.0.6)

This is the official OmniAuth strategy for authenticating to [Idnet](http://id.net). To
use it, you'll need Idnet consumer application ID and SECRET.

## Basic Usage
Currently, you have to initialize OmniAuth (with Idnet strategy) like this:

    provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret]

This way, Idnet strategy will be initialized with the set of default fields:

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
    "zip"
  ]
```

Also, you may initialize it with the set of default fields + custom fields for your
consumer application:

```ruby
provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
         :fields => OmniAuth::Idnet::DEFAULT + ['home_planet', 'anything_else']
```

Where,
```ruby
APP_CONFIG[:app_id] - application ID
APP_CONFIG[:app_secret] - application SECRET
```

Or, you may totally override default fields by your own (in any case 'uid' field will
be available for this startegy, and this could not be changed):

```ruby
provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
         :fields => ['foo', 'bar']
```

Also, you may (if you know what to pass there, in this example, it's `http://custom.idnet.server.org/`) use custom provider URL:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
           :fields => OmniAuth::Idnet::DEFAULT + ['dob'],
           :client_options => {:site => "http://custom.idnet.server.org/",
                               :authorize_url => "http://custom.idnet.server.org/oauth/authorize",
                               :access_token_url => "http://custom.idnet.server.org/oauth/token"}
end
```
If no `:client_options` passed, default `http://id.net/` provider URL will be used.

This should be placed, for example, into `config/initializers/omniauth.rb`.

### Auth form pre-fill
Starting from version 0.0.4 you can pre-fill auth form. It could be useful when you migrate from existing authentification system to IDnet.
Currently available for pre-fill fields are:

```ruby
email
nickname
dob
country
gender
```
This way you can format a URI like:

    /auth/idnet?email=user@name.com&nickname=user42&gender=female&country=ALA&dob=1982-01-01

to pre-fill IDnet form.

### Authentication popup
To invoke authentication popup, id.net provides a handy Javascrip available at:
```
https://www.id.net/api/popup.js
```

For example, for Ruby on Rails it could be included like this:
```ruby
<%= javascript_include_tag "http://#{APP_CONFIG[:idnet][:server]}/api/popup.js" %>
```
Then you may use jQuery to handle id.net authorization buttno clicks:

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

Copyright (c) 2011-2012 Vlad Shvedov and Heliostech.hk

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
