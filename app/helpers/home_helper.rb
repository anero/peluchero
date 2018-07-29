# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module HomeHelper
      def format_date(date)
        I18n.l(date.in_time_zone(Time.zone), format: :short)
      end
    end

    helpers HomeHelper
  end
end
