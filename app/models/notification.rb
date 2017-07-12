require 'open-uri'
require 'net/http'

class Notification < ApplicationRecord
  belongs_to :user
  after_save :upload_notification_to_ionic

  validates :message, presence: true
  validates :tokens, presence: true

  # attribute :tokens, :string, array: true
  # serialize :tokens, Array
  # serialize :sent_to, Array

private
  def upload_notification_to_ionic
    puts "Push Notification Created: Sent-to: self.tokens.to_json"

    params = {
      "tokens" => self.tokens,
      "profile" => ENV['IONIC_PUSH_ENV'],
      "notification":{
        "message": self.message,
        "android":{
          "title": "Crescent Ford",
          "sound": "true"
        },
         "ios": {
              "title": "Crescent Ford",
              "sound": "true"
              # ,
              # "badge": 1
            }
      }
    }

    uri = URI.parse('https://api.ionic.io/push/notifications')
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
    req['Authorization'] = ENV['IONIC_API_TOKEN']
    req['Content-Type'] = 'application/json'
    req.body = params.to_json
    res = https.request(req)
    puts res.body
  end
end
