# Require any additional compass plugins here.
require 'compass/import-once/activate'
require 'susy'
require 'normalize-scss'
require 'autoprefixer-rails'
require 'csso-rails'

# Set this to the root of your project when deployed:
project_type = :stand_alone
http_path = "/"
sass_dir = "."
css_dir = "../web/assets/css"
http_stylesheets_path = "/assets/css"
images_dir = "../web/images"
http_images_path = "/images"
generated_images_dir = "../web/assets/images"
http_generated_images_path = "/assets/images"
fonts_dir = "../web/fonts"
http_fonts_path = "/fonts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :development) ? :expanded : :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
relative_assets = false

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false

on_stylesheet_saved do |filename|
    supported_browsers = ['> 1%', 'last 2 versions', 'Firefox ESR', 'ie >= 9']
    if output_style == :compressed
        File.write(filename+'.ap',AutoprefixerRails.process(File.read(filename), {browsers: supported_browsers}))
        File.write(filename,Csso.optimize(File.read(filename+'.ap')))
        File.delete(filename+'.ap')
    else
        File.write(filename,AutoprefixerRails.process(File.read(filename), {browsers: supported_browsers}))
    end
end
