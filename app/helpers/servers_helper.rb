# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module ServersHelper
      def security_group_options
        client = Aws::EC2::Client.new(region: ENV['AWS_REGION'], credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']))
        resp = client.describe_security_groups

        resp.security_groups.map {|sg| [sg.group_name, sg.group_id] }
      end

      def instance_type_options
        [ 't2.micro', 't2.small', 't2.medium', 't2.large', 't2.xlarge' ]
      end

      def format_server_public_ip(public_ip)
        public_ip || 'No asignada aún'
      end

      def can_be_terminated?(server)
        Server::NOT_TERMINATED_STATUSES.include?(server.status)
      end
    end

    helpers ServersHelper
  end
end
