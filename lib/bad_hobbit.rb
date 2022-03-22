#!/usr/bin/env ruby
# frozen_string_literal: true

# Id$ nonnax 2022-03-22 17:36:02 +0800
require 'hobbit'
require 'erb'

@template ||= File.read('app.rb')

BadHobbit = Hobbit

module KernelExt
  module_function

  def erb(template, **param)
    @param = param
    template_layout = param[:layout]
    views=File.join(File.dirname(__FILE__), '../views')
    
    f = File.read(File.join(views, "#{template}.erb"))
    res = _render f, **param
    
    if template_layout
       template_layout
       res = File
        .read( File.join(views, "#{template_layout}.erb") )
        .then{ |f| _render(f) { res }}
    end    
    
    res
  end

  def _render(f, **param)
    context_binding = param.fetch(:context, binding)
    ERB.new(f).result(context_binding)
  end

  def _layout
    app_layout = File.read(__FILE__).split('__END__').last
    ERB.new(app_layout).result(binding)
  end
end

Hobbit::Base.include(KernelExt)

# eval badhobbit app
eval KernelExt._layout { KernelExt._render @template }

__END__
class App < Hobbit::Base
  <%= yield%>
end
