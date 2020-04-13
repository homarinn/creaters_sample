Dir[Rails.root.join('lib', 'core_ext', '*.{rb}').to_s].each {|file| require file }

module CoreExt
end