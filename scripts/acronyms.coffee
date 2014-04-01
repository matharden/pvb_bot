# Description:
#   Return definitions of acronyms from the Big Book of Acronyms
#
# Commands:
#   hubot def[ine] <acronym> - Returns definitions for the given acronym

module.exports = (robot) ->
  # Big Book of Acronyms
  robot.respond /(def|define) (.*)/i, (msg)->
    query = msg.match[2]
    msg.http("#{process.env.HUBOT_BBA_HOST}/define/#{query}").headers("Accept": "application/json").get() (err, res, body) ->
      return msg.send "BBA says: #{err}" if err
      if res.statusCode != 500
        acronym = JSON.parse body
        if acronym.error
          msg.send acronym.error
        else
          for def in acronym.definitions
            resp = []
            resp.push "#{acronym.acronym} = #{def.definition} - #{def.url}"
            msg.send resp.join('\n')
