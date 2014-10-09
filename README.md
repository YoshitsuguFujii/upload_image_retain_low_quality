# UploadImageRetainLowQuality
upload image to s3(Glacier) bucket retain low quality image file

## Requirements

ImageMagick or GraphicsMagick command-line tool has to be installed.  
because this gem require  [minimagick](https://github.com/minimagick/minimagick)

## Installation

install

    $ gem install upload_image_retain_low_quality

## Usage

####First setting

    $ upload_image_retain_low_quality init

####Upload Image
create .upload_image_retain_low_qualityrc in your current directory
rewrite your aws key and secret

    access_key_id: 'YOUR ACCESS KEY'
    secret_access_key:  'SECRET ACCESS KEY'

move to direcory. then just do this.

    $ upload_image_retain_low_quality

current directory image files(.jpg .jpeg .gif .png) convert low quality and transfer your interactive selected buckets and folder.


help

    $ upload_image_retain_low_quality --help


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
