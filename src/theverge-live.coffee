# Description:
#   Follow live events covered by live.theverge.com
# Dependencies:
#   "request": "2.40.0"
#   "wait": "0.1.0"
# Commands:
#   hubot start live <live.theverge url>
#   hubot stop live

request = require 'request'
zlib = require 'zlib'
wait = require 'wait'


module.exports = (robot) ->
  running = true
  retrieveMSG = ""
  archivedMSG = []
  robot.respond /(start)( live)? (.*)$/i, (msg) ->
    url = msg.match[3] + 'live.json'
    msg.send 'Started live of ' + msg.match[3]
    retrieveMSG = msg
    retrieve url, true

  robot.respond /stop live/i, (msg) ->
    msg.send "Live stopped"
    archivedMSG = []
    running = false


  retrieve = (url, firstTime) ->
    options =
      url: url,
      encoding: null,
      headers: 'Accept-Encoding': 'gzip', 'User-Agent': 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13'
    request options, (err, response, body) ->
      zlib.unzip body, (err, buffer) ->
        for item in JSON.parse(buffer).entries
          text = htmlClean(item.body)
          if firstTime == true
            archivedMSG.push text
          if text not in archivedMSG and firstTime == false
            archivedMSG.push text
            retrieveMSG.send text
    wait 5000, ->
        if running
            retrieve(url, false)


  htmlClean = (html) ->
    html = html.replace /<br>/gi, " "
    html = html.replace /<strong>/gi, ""
    html = html.replace /<\/strong>/gi, ""
    html = html.replace /<p>/gi, ""
    html = html.replace /<\/p>/gi, ""
    html = html.replace /<a.*href="(.*?)".*>(.*?)<\/a>/gi, "$1"
    html = html.replace /<img [^>]*src="([^"]+)"[^>]*>/gi, "$1"
    html = html.replace /\n/g, ""
    html = html.replace /&#39;/gi, "'"
    html = html.replace /&quot;/gi, "\""
    return html