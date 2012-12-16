module.exports = (app) ->

  controllers   = app.settings.controllers
  ViewController = controllers.ViewController app
  DataController = controllers.DataController app

  app.get '/'             , ViewController.index
  app.put /^\/(.*)\.json$/, DataController.index

