# Notiffany

Notification library supporting popular notifiers, such as:
- Growl
- libnotify
- TMux
- Emacs (see: https://github.com/guard/notiffany/wiki/Emacs-support)
- rb-notifu
- notifysend
- gntp
- TerminalNotifier

## Features
- most popular notification libraries supported
- easy to override options at any level (new(), notify())
- using multiple notifiers simultaneously
- child processes reuse same configuration

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notiffany'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install notiffany

## Usage

Basic notification

```ruby
notifier = Notiffany.connect(title: "A message")
notifier.notify("Hello there!", image: :success)
notifier.disconnect # some plugins like TMux and TerminalTitle rely on this
```

Enabling/disabling and on/off

### disable with option

```ruby
notifier = Notiffany.connect(notify: false)
notifier.notify('hello') # does nothing
```

### switch on/off using methods

```ruby
notifier = Notiffany.connect
notifier.turn_off
notifier.turn_on
notifier.toggle
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/notiffany/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
