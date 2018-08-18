desc "Terminar instancias que tengan fecha de expiración cumplida"
task terminate_scheduled_instances: :environment do
  Padrino.logger.info("*** Corriendo el proceso de expiración de instancias ***")

  servers_to_terminate = Server.where('terminate_at < ? AND status = ?', Time.now.utc, 'running')
  Padrino.logger.info("Hay #{servers_to_terminate.count} instancias para terminar")

  servers_to_terminate.each do |server|
    server.terminate!
    Padrino.logger.info("Instancia #{server.instance_id} terminada")
  end

  Padrino.logger.info("*** Proceso de expiración de instancias terminado ***")
end
