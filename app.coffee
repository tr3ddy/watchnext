express = require 'express'
bodyParser = require 'body-parser'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
expressSession = require 'express-session'
bCrypt = require 'bCrypt'
mongoose = require 'mongoose'

userController = require './controllers/user'
authController = require './controllers/auth'
watchnextListController = require './controllers/watchnextlist'

port = 8080
app = express()

mongoose.connect 'mongodb://192.168.59.103:27017/watchnext'

app.use bodyParser.urlencoded {extended: true}
app.use bodyParser.json()
app.use passport.initialize()

router = express.Router()

router.route('/users')
    .post(userController.addUser)
    .get(authController.isAuthenticated, userController.getAllUsers)

router.route('/lists')
    .post(authController.isAuthenticated, watchnextListController.addList)
    .get(authController.isAuthenticated, watchnextListController.getAllLists)

router.route('/lists/:list_id')
	.get(authController.isAuthenticated, watchnextListController.getListById)
	.put(authController.isAuthenticated, watchnextListController.updateList)

router.route('/lists/:list_id/movies')
	.post(authController.isAuthenticated, watchnextListController.insertMovie)

app.use '/api', router

app.listen port
console.log 'Server started on port ' + port