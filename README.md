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

## Now supports the Ruby interactive shell!

```
$ irb
> require 'writer'
#=> true
> wr 'hello.txt', 'world'
#=>""
> File.open('hello.txt').read
#=> "world\n"
```

## Use a template

The Writer will copy a template file's contents into your new file
if you configure the template file's path.

Add `config/writer.yml` to the root directory of your project or journal

Create a file named whatever you want, the example uses `.template`
in the project root

```yml
template_path: .template
```

## Configuration

```yml
# in config/writer.yml

# default config:
namer:         'Writer::FileNamer'
creator:       'Writer::FileCreator'
logger:        'Writer::Logger'
date_format:   '%Y-%m%b-%d'
log_level:     2 # 0 - err, 1 - warn, 2 - info, 3 - debug
template_path: ''
```

## Contributing

Please provide a spec covering your feature or bug fix, thank you!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
