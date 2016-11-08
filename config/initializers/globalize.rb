Globalize.fallbacks = {
  :en => [:en, :'en-US', :'en-GB'],
  :'en-US' => [:'en-US', :en, :'en-GB'],
  :'en-GB' => [:'en-GB', :en, :'en-US'],
  :'en-IN' => [:'en-IN', :en, :'en-US'],
  :es => [:es, :'es-MX', :en],
  :'es-MX' => [:'es-MX', :es, :en],
  :zh => [:zh, :en],
  :cn => [:zh, :en]
}

# My monkey patching
require 'globalize_extensions'
