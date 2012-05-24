#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'JqueryRatyRails'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task :default => :test

# ---------------------------------------------------------------------------
# Local additions
# ---------------------------------------------------------------------------

require 'fileutils'
require 'pathname'

include FileUtils

ROOT         = Pathname(File.dirname(__FILE__))
DOWNLOAD_DIR = ROOT + "tmp/download"
ASSETS       = ROOT + 'vendor/assets'
PACKAGE      = "jquery-raty-rails"
GEMSPEC      = "#{PACKAGE}.gemspec"

def load_gem
  eval File.open(GEMSPEC).read
end

def gem_name
  gem = load_gem
  version = gem.version.to_s
  "#{PACKAGE}-#{version}.gem"
end

# Tasks

desc "Build the gem"
task :gem => gem_name

desc "Build the gem"
file gem_name do
  require 'rubygems/builder'
  raise "Gem package not defined" unless defined? Gem
  spec = eval File.open(GEMSPEC).read
  Gem::Builder.new(spec).build
end

desc "Publish the gem"
task :publish => :gem do
  sh "gem push #{gem_name}"
end

desc "Update to the most recently released version of jQuery Raty"
task :update => [:download_raty, :copy_raty] do
  rm_rf "tmp"
end

desc "Download and unpack the latest version of jquery-raty"
task :download_raty do
  require 'octokit'
  require 'time'

  gh = Octokit::Client.new
  newest_time = 0
  newest = nil
  download = gh.downloads('wbotelhos/raty').select do |dl|
    dl["content_type"] == "application/zip"
  end.map do |dl|
    dl["timestamp"] = Time.iso8601 dl["created_at"]
    dl
  end.sort do |dl1, dl2|
    dl1["timestamp"].to_i <=> dl2["timestamp"].to_i
  end.last

  raise "Can't find suitable download" if download.nil?

  rm_rf DOWNLOAD_DIR
  mkdir_p DOWNLOAD_DIR

  url = download["html_url"]
  uri = URI(url)
  filename = File.basename(uri.path)
  local_path = DOWNLOAD_DIR + filename

  download(uri, local_path)
  unzip local_path
end

desc "Copy the jquery-raty assets in place"
task :copy_raty do
  %w[javascripts images/jquery.raty].each do |d|
    mkdir_p ASSETS + d
  end

  Dir.glob(DOWNLOAD_DIR + 'img/*') do |f|
    cp(f, ASSETS + "images/jquery.raty/")
  end

  js_file = DOWNLOAD_DIR + 'js/jquery.raty.js'
  puts "Editing and copying #{js_file}"
  js = File.open(js_file).readlines.map do |line|
    case line
    when /^(\s+path\s+:)\s'([^']+)'(.*)$/
      line = "#{$1}'/assets/jquery.raty/'#{$3}\n"
    end
    line.gsub(/\r/, "").gsub(%r{^/\*!}, "/**")
  end

  full_js = ASSETS + "javascripts/jquery.raty.js"
  File.open(full_js, "wb") { |f| f.write(js.join('')) }

  min_js = ASSETS + "javascripts/jquery.raty.min.js"
  minify full_js, min_js
end

# Download a URL, handling redirects and SSL.
#
# Parameters:
#
# uri  - URI object
# dest - destination path
def download(uri, dest)
  require 'net/http'

  # Would use open-uri, as shown, but it pukes on the GitHub redirection
  # from an https URL to a cloud http URL.
  #
  #     open(local_path, 'wb') do |file|
  #       file << open(url).read
  #     end
  keep_going = true
  while keep_going
    use_ssl = uri.scheme == 'https'
    Net::HTTP.start(uri.host, uri.port, use_ssl: use_ssl) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      puts "Downloading #{uri.to_s}"
      http.request request do |response|
        if response.is_a? Net::HTTPSuccess
          File.open(dest, 'wb') do |f|
            response.read_body do |chunk|
              f.write chunk
            end
          end
          keep_going = false

        elsif (response.code[0] == '3') && response['location']
          # Redirect.
          puts "(Redirected to #{response['location']}"
          uri = URI(response['location'])
        else
          raise "Download failed: #{response.code} #{response.message}"
        end
      end
    end
  end
end

def unzip(path)
  require 'zip/zip'

  puts "Unpacking #{path}"
  Zip::ZipFile.open(path) do |zip_file|
    zip_file.each do |entry|
      dest = File.join(DOWNLOAD_DIR, entry.name)
      mkdir_p File.dirname(dest), verbose: false
      zip_file.extract(entry, dest)
    end
  end
end

# Minify JS. Currently expects Google Closure to be installed.
def minify(input_file, output_file)
  #require 'uglifier'
  require 'tempfile'

  puts "Minifying #{input_file} to #{output_file}."
  Tempfile.open('jquery-raty') do |temp|
    sh 'closure', input_file.to_s, temp.path
    temp.rewind
    File.open(output_file, 'wb') do |out|
      out.puts "/* Minified by Google Closure */"
      out.write(temp.read)
    end
  end
end
