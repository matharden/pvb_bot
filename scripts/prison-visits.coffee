# Description:
#   Return a list of current URLs on the PVB Project
#
# Commands:
#   hubot list urls/envs - returns list of project urls (also works without "list")
#   mention "ZenDesk" and "email" - returns the ZenDesk email for PVB


envs = ->
  ENVS = JSON.parse process.env.HUBOT_PROJECT_ENVS
  resp = []
  resp.push("#{name}: #{URL}") for name, URL of ENVS
  resp.join '\n'


module.exports = (robot) ->
  # Project URLS
  robot.respond /((list )?(urls?|envs))/i, (msg) ->
    msg.send envs()

  # Project help
  robot.hear /(?=.*\bemail\b)(?=.*\bzendesk).*/i, (msg) ->
    msg.reply "The ZenDesk email for PVB feedback is prison.visits@ministryofjustice.zendesk.com"

  # Project no-nos
  robot.hear /(?=.*\b(ms|microsoft|docs?)\b)(?=.*\bword\b).*/i, (msg) ->
    msg.reply "Thou shalt not use MS Word docs!!! Use Google Docs instead."

  robot.hear /((ms|microsoft) )?power ?point/i, (msg) ->
    msg.reply "Thou shalt not use MS PowerPoint! Try using Google Slides, or if it's a diagram you could try Google Drawings."

  robot.hear /((ms|microsoft) )?excel/i, (msg) ->
    msg.reply "Thou shalt always use MS Excel! It's awesome. Unless you want to work on a simple spreadsheet in real time, then try Google Sheets."
