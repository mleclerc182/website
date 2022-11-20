require 'httparty'
module UnbanHelper
  $botToken = Rails.application.credentials.bot_token

  def unban


    url = 'https://discord.com/api/v10/oauth2/token'

    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded'
    }

    body = {
      client_id: "818879724138004520",
      client_secret: Rails.application.credentials.client_secret,
      grant_type: "authorization_code" ,
      code: params['code'],
      redirect_uri: 'https://www.skilledtheory.com/unban'
    }
    response = HTTParty.post(url, headers: headers, body:body)
    json=JSON.parse(response.body)
    token = json['access_token']
    puts "TOKEN: #{token}"

    url = "https://discord.com/api/users/@me"
    headers = {
      'Authorization' => "Bearer #{token}"
    }
    response = HTTParty.get(url, headers: headers)
    json=JSON.parse(response.body)
    userid = json['id']
    twofa=json['mfa_enabled']
    userName=json['username']
    userDis=json ['discriminator']


    new_message("Starting unban process for user **#{userid}**, **#{userName}##{userDis}**.")

    if twofa

      url="https://discord.com/api/guilds/662246299369734154/bans/"+userid
      headers = {
        'Authorization' => "Bot #{$botToken}"
      }
      response = HTTParty.get(url, headers: headers)
      json=JSON.parse(response.body)
      reason = json['reason']
      if reason.include? "scam/dangerous"
        url="https://discord.com/api/guilds/662246299369734154/bans/"+userid
        headers = {
           'Authorization' => "Bot #{$botToken}"
        }
        response = HTTParty.delete(url, headers: headers)
        if response.code==204

          new_message("User <@" +userid+"> unbanned.")

          url="https://discord.com/api/guilds/662246299369734154/members/"+userid
          headers = {
            'Authorization' => "Bot #{$botToken}",
            'Content-Type' => 'application/json'
          }
          body="{\"access_token\": " + "\"" + token + "\"}"
          response = HTTParty.put(url, headers: headers, body:body)
          if response.code==201

            new_message("User has joined fall guys server")
            text = "Unbanned and joined server sucessfully. You may now close this page"
            return  text
          end
        end
      else
          text = "Not banned for malicious links. Unable to automatically unban"
          new_message("User was not banned for malicious links. Stopping uunban process")
          return  text;
      end
    end

      text = "2FA NOT ENABLED. Please come back after you have enabled 2FA"
      new_message("2FA is not enabled.")
      text
    end

  def new_message(message)

      url="https://discord.com/api/channels/902381387309535232/messages"
      headers = {
        'Authorization' =>  "Bot #{$botToken}"
      }
      body={
        content: message
      }
      response = HTTParty.post(url, headers: headers, body:body)
    end
  end



