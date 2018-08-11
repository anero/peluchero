desc "Terminar instancias que tengan fecha de expiración cumplida"
task terminate_scheduled_instances: :environment do
  servers_to_terminate = Server.where('terminate_at > ?', Time.now.utc)
  servers_to_terminate.each do |server|
    server.terminate!
  end
end
