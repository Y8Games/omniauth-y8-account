# OmniAuth IdNet (0.0.2)

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

Or, you may totally override default fields by your own (in any case 'uid' field will
be available for this startegy, and this could not be changed):

```ruby
provider :idnet, APP_CONFIG[:app_id], APP_CONFIG[:app_secret],
         :fields => ['foo', 'bar']
```

This should be placed, for example, into `config/initializers/omniauth.rb`.

```ruby
APP_CONFIG[:app_id] - application ID
APP_CONFIG[:app_secret] - application SECRET
```

## License

Copyright (c) 2011 Vlad Shvedov and Heliostech.hk

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
