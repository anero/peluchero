# frozen_string_literal: true

class DiscordBot
  def initialize
    @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID'],
                              type: :bot, log_mode: :debug)
  end

  def send_message(message)
    @bot.send_message(ENV['DISCORD_CHANNEL_ID'], message)
  end
end
