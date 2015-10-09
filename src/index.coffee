Watcher = require 'rss-watcher'
request = require 'request'

exports.start = (config) ->

  watcher = new Watcher config.feed

  watcher.set
    feed: config.feed
    interval: config.interval

  watcher.on "new article", (article) ->
    request.post
      url: config.slackHook,
      body: JSON.stringify(
        {"username": config.slackBotUser
        "text": "New post: <#{article.link}|#{article.title}>"
        "icon_url": config.slackIcon})
      headers:
        "Content-Type": "application/json"

  watcher.run (error, articles) ->
    console.log "Started watching rss feed."
