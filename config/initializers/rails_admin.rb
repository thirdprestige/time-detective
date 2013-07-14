RailsAdmin.config do |config|
  config.main_app_name = ['TimeDetective.io', 'Admin']

  config.current_user_method { current_admin } # auto-generated

  config.model Block do
    list do
      field :content
    end

    edit do
      field :content #, :wysihtml5
      field :position
    end
  end
end
