RailsAdmin.config do |config|
  config.main_app_name = ['TimeDetective.io', 'Admin']

  config.current_user_method { current_admin } # auto-generated

  config.model Block do
    list do
      field :content
    end

    edit do
      field :content do
        bootstrap_wysihtml5 true
      end
      field :position
    end
  end
end
