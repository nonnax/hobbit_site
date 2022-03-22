@@name='wakalaka'
get '/' do
  # "Hello World! #{@@name}"  
  @name='nonnax'
  name='nald'
  erb :index, 
    layout: :layout, 
    context: binding # if using user vars
end

get '/:name' do
  erb :namer, layout: :layout 
end

get '/:name/:age' do
  erb :namer, layout: :layout 
end
