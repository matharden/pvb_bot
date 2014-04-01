# Description:
#   Return a list of people's real names
#
# Commands:
#   hubot who is - list all user aliases
#   hubot who is <name> - explain who this is an alias of


whois = (name) ->
  ALIAS = JSON.parse process.env.HUBOT_ALIASES
  return "#{name} is #{ALIAS[name.toLowerCase()]}" if name
  resp = []
  resp.push("#{name} is #{alias}") for name, alias of ALIAS
  resp.join '\n'


module.exports = (robot) ->
  # Who are these people?
  robot.respond /who ?is( ([a-z]+))?/i, (msg) ->
    msg.send whois(msg.match[2])
