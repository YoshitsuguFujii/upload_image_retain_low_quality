# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upload_image_retain_low_quality/version'

Gem::Specification.new do |spec|
  spec.name          = "upload_image_retain_low_quality"
  spec.version       = UploadImageRetainLowQuality::VERSION
  spec.authors       = ["y.fujii"]
  spec.email         = ["ishikurasakura@gmail.com"]
  spec.description   = %q{upload image to s3 bucket retain low quality image file}
  spec.summary       = %q{upload image to s3 bucket retain low quality image file}
  spec.homepage      = "http://d.hatena.ne.jp/gogo_sakura/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency 'aws-sdk'
  spec.add_dependency 'mini_magick'
  spec.add_dependency 'parallel'
end
