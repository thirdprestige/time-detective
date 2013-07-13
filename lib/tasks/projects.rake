namespace :projects do
  namespace :activities do
    desc 'Periodically bring server releases into our app'
    task server: :environment do
      Project::Identity.server.find_each do |server|
        server.releases.each do |release|
          # POST
          # created_at
          # id
          # email
        end
      end
    end
  end
end
