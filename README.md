# ViewComponentHelper
[![Gem Version](https://badge.fury.io/rb/view_component_helper.svg)](https://badge.fury.io/rb/view_component_helper)

`ViewComponentHelper` is a simple gem designed to enhance the functionality provided by [ViewComponent](https://github.com/ViewComponent/view_component). It offers shortcuts to access generated ViewComponents, making your Rails development experience smoother and more efficient.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add view_component_helper

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install view_component_helper

## Usage

##### Please refer to ViewComponent website for more details.

To use ViewComponent, you'll need to follow the example below. By utilizing this gem, you can make calls like the following:

```
# Before
<%= render(MessageComponent.new(name: "World")) %>

# After
<%= render_vc("messageComponent", name: "World") %>
or
<%= vc("messageComponent", name: "World") %>
```

## Usage

`ViewComponentHelper` allows for easier referencing of `ViewComponent` classes located under the `app/components` directory by providing you with intuitive shortcut methods.

### How it works
For every `ViewComponent` you define within the `app/components` directory, `ViewComponentHelper` automatically provides a shortcut method to render it.

### Examples

1. For a component located at `app/components/title_component.rb`:

You can utilize the following shortcut:
```ruby
title_component(title: "test title")
```

2. For a component located at `app/components/button.rb`:

```erb
<%= button %>
```

3.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yapr/view_component_helper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
