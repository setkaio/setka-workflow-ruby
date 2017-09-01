# Setka Workflow API Ruby Library

This gem implements the Setka Workflow API for integration an external publishing platform written in the Ruby language with Setka Workflow.

[Full API documentation](http://www.rubydoc.info/gems/workflow).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'workflow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workflow

## Requirements

* Ruby 2.0+.

## Configuration

*Access token* is an unique key to authorize in Workflow Integration API. It is generated after the creation of the space and can be obtained from the Settings page (Integration section) in Setka Workflow.

*Space name* is the part of URL segment next after the hostname. For example in the URL `https://workflow.setka.io/foobar/tickets` `foobar` is the space name.

1. Configuring by passing a block with `space_name` and `access_token`.

```ruby
require 'workflow'

Workflow.configure do |config|
  config.access_token = ACCESS_TOKEN
  config.space_name  = SPACE_NAME
end
```

This kind of configuration is global. In order to reset the configuration `Workflow.reset!` should be executed.

2. Instantiating an client object on behalf which operations are executed.

```ruby
client = Workflow::Client.new(access_token: ACCESS_TOKEN, space_name: SPACE_NAME)
```

## Usage

### Ticket operations

```ruby
# To publish the ticket:

# ticket_id = 112329

Workflow::Ticket.publish(ticket_id)

# To unpublish the ticket:

# ticket_id = 112330

Workflow::Ticket.unpublish(ticket_id)

# To update the ticket:

# ticket_id = 112331

Workflow::Ticket.update(ticket_id)

# To sync analytics of the tickets:

# body = {
#   tickets: [
#     {
#       id: 18712,
#       views_count: 5123
#     },
#     {
#       id: 18713,
#       views_count: 2023,
#       comments_count: 98
#     }
#   ]
# }

Workflow::Ticket.sync_analytics(body)
```

### Category operations

```ruby
# To create a category:

# body = { name: 'Cats & Dogs' }

Workflow::Category.create(body)

# To update the category:

# category_id = 412
# body = { name: 'Hamsters' }

Workflow::Category.update(category_id, body)

# To delete the category:

# category_id = 413

Workflow::Category.delete(category_id)
```

### Multiple clients

```ruby
# Clients creation

animals_client = Workflow::Client.new(access_token: 'animals_access_token', space_name: 'animals')
humans_client = Workflow::Client.new(access_token: 'humans_access_token', space_name: 'humans')

# Publishing the ticket in animals space

Workflow::Ticket.publish(41123, client: animals_client)

# Updating the category in humans space

body = { name: 'Professions' }

Workflow::Category.update(882, body, client: animals_client)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/setkaio/workflow-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

