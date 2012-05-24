# jquery-raty-rails

## Introduction

*jquery-raty-rails* is a Ruby gem that wraps the [jQuery Raty][] plugin,
allowing its image and Javascript files to be served via the [Rails][]
[asset pipeline][].

[jQuery Raty][] is a useful "star rating" [jQuery][] plugin.

**This project is not officially associated with the [jQuery Raty][] project.**

## Installation

### Install the gem

*jquery-raty-rails* requires Rails 3, since it depends on the asset pipeline.

To install, add one of the following to your Rails project's `Gemfile`:

    gem 'jquery-raty-rails'                                  # Released version
    gem 'jquery-raty-rails', github: 'bmc/jquery-raty-rails' # Bleeding edge

Then, install the gem by running `bundle install`.

### Configure the assets

Modify the [Sprockets manifest][] in your `application.js` file to include
*one* of the following, depending on whether you want to include the compressed
Javascript or the uncompressed Javascript:

    //= require jquery.raty
    //= require jquery.raty.min

## Usage

At this point, your Rails application has access to jQuery Raty. See the
[jQuery Raty][] web site for instructions on how to use the plugin.

## Notes

* The [jQuery Raty][] images are installed so that their assets paths won't
  conflict with same-named images in the application or in other gems.
* This [blog post][], by Stephen Ball, was a huge help in figuring out how
  to create this gem.

## Copyrights, License, etc.

[jQuery Raty][] is copyright &copy; [Washington Botelho][].

*jquery-raty-rails* copyright &copy; 2012 Brian M. Clapper and is released
under a [BSD license](/bmc/jquery-raty-rails/blob/master/LICENSE.md).

[blog post]: http://rakeroutes.com/blog/write-a-gem-for-the-rails-asset-pipeline/
[Rails]: http://rubyonrails.org/
[jQuery]: http://jquery.org/
[jQuery Raty]: http://www.wbotelhos.com/raty/
[asset pipeline]: http://guides.rubyonrails.org/asset_pipeline.html
[Sprockets manifest]: https://github.com/sstephenson/sprockets#the-directive-processor
[Washington Botelho]: https://github.com/wbotelhos
