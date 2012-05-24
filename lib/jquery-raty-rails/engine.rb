module JqueryRatyRails
  class Engine < ::Rails::Engine
    initializer 'jquery-raty-rails.load-jquery-raty-rails' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/vendor"
    end
  end
end
