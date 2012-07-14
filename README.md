# Writer

This gem adds a command line utility that writes a new file for you.

## Doesn't touch do that?

Yes, but with this gem you can simply type `wr` and it defaults to
a markdown file named after today's date.

## Installation

Create a bundler Gemfile and add this:

    gem 'writer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install writer

## Usage

```
$ wr
#=> Creates a MarkDown file named after today's date
## e.g. `2012-01Jan-03.md`

$ wr hello
#=> Creates a file named `hello`

$ wr hello world
#=> Creates a file named `hello` with the content `world`
```

## Use a template

Add `config/writer.yml` to the root directory of your project or journal

Create a file named whatever you want, the example uses `.template`
in the project root

```yml
template_path: .template
```

## Contributing

Please provide a spec covering your feature or bug fix, thank you!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
