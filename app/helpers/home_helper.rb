# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module HomeHelper
      def format_date(date)
        return '' if date.blank?
        date.in_time_zone(Time.zone).strftime('%k:%M %e/%-m/%Y')
      end
    end

    helpers HomeHelper
  end
end
