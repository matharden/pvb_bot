# Description:
#   Harness the full power of Pivotal Tracker's search
#
# Commands:
#   hubot piv/pivotal <string> - returns list of matching Pivotal Tracker storie[s]


module.exports = (robot) ->

  robot.respond /(piv|pivotal) (.*)/i, (msg) ->
    token = process.env.HUBOT_PIVOTAL_TOKEN
    query = encodeURIComponent(msg.match[2])
    projects = JSON.parse process.env.HUBOT_PIVOTAL_PROJECTS

    for project in projects
      msg.http("https://www.pivotaltracker.com/services/v5/projects/#{project.id}/stories?filter=#{query}").headers("X-TrackerToken": token).get() (err, res, body) ->
        if err
          msg.send "Pivotal says: #{err}"
          return
        if res.statusCode != 500
          stories = JSON.parse body
          for story in stories
            message = "#{story.id} #{story.name}"
            message += " (#{story.current_state})" if story.current_state
            message += " - #{story.url}"
            msg.send message
