# frozen_string_literal: true

# Helper methods defined here can be accessed in any controller or view in the application

module Peluchero
  class App
    module HomeHelper
      def format_date(date)
        return '' if date.blank?
        date.in_time_zone(Time.zone).strftime('%e/%-m/%Y')
      end

      def format_datetime(date)
        return '' if date.blank?
        date.in_time_zone(Time.zone).strftime('%k:%M %e/%-m/%Y')
      end

      def format_date_for_control(date)
        return '' if date.blank?
        date.in_time_zone(Time.zone).strftime('%d/%m/%Y %I:%M %p')
      end
    end

    helpers HomeHelper
  end
end
