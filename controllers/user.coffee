User = require '../models/user'

exports.addUser = (req, res)->
	user= new User {
			username: req.body.username,
			password: req.body.password,
			email: req.body.email
		}
	user.save (err) ->
		if err
			return res.send(err)
		res.json {message: 'New user added'}

exports.getAllUsers = (req, res) ->
	User.find (err, users) ->
		if err
			res.send err
		res.json users

