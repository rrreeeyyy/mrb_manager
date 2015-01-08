# mrb\_manager

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/rrreeeyyy/mrb_manager?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

mruby binary manager having a affinity for mgem

## Installation

Install it yourself as:

    $ gem install mrb_manager

Afterwards you will still need to add ```eval "$(mrbm init)"``` to your profile.

You'll only ever have to do this once.

## Usage

### Install mruby with current active mgems

You should be able to:

	$ mgem add mruby-redis
	$ mrbm install

If ```-t tag_name``` specified, you can install tagged mruby

	$ mgem add mryby-redis
	$ mgem add mruby-http2
	$ mrbm install -t redis-and-http2

### Uninstall mruby

You should be able to:

	# list all available mruby
	$ mrbm list
	ID				    CREATED			  VERSION		TAG
	cfb43c1811c5	1 month ago		1.1.0
	$ mrbm uninstall cfb43c1811c5

If you tagged:

	$ mrbm list
	ID				    CREATED			  VERSION		TAG
	cf3889727b2a	1 month ago		1.0.0		  redis-and-http2
	$ mrbm uninstall -t redis-and-http2

## Contributing

1. Fork it ( https://github.com/rrreeeyyy/mrb_manager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
