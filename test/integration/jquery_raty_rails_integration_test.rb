require 'test_helper'

describe "jQuery Raty integration" do
  it "pulls in jquery.raty.js" do
    visit '/assets/jquery.raty.js'
    page.status_code.must_equal 200
    page.text.must_include "$.fn.raty.defaults"
  end

  it "pulls in jquery.raty.min.js" do
    visit '/assets/jquery.raty.min.js'
    page.status_code.must_equal 200
    page.text.must_include "/* Minified"
  end

  it "pulls in various images" do
    root = File.expand_path('../../..', __FILE__)
    images = Dir.glob("#{root}/vendor/**/*.png")
    images.length.must_be :>, 0

    images.each do |image|
      visit "/assets/jquery.raty/#{File.basename image}"
      page.status_code.must_equal 200
    end
  end

end
