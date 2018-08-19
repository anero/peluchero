desc "Actualizar estado de instancias corriendo"
task update_instances_status: :environment do
  Padrino.logger.info("*** Corriendo el proceso de actualización de estado de instancias ***")

  running_instances = Server.not_terminated
  Padrino.logger.info("Hay #{running_instances.count} instancias corriendo")

  running_instances.each do |server_instance|
    server_instance.refresh_status!
    Padrino.logger.info("Instancia #{server_instance.instance_id} actualizada")
  end

  Padrino.logger.info("*** Proceso de actualización de estado de instancias terminado ***")
end
