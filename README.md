# AudioTag

A Ruby library for reading and writing various audio file metadata. Currently only reading ID3v2 MP3 metadata is supported.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add audio_tag

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install audio_tag


## Usage

To read MP3 file metadata:

```ruby
AudioTag::ID3::V2::Tag.from_file(path_to_file).to_h
```

## Development

- Note that `AudioTag` is still in active development
- It is planned for further audio metadata formats to be supported in the future


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Copyright

- Please note that the samples in `spec/examples` have been redacted to contain audio metadata only. These files contain no playable audio data.
