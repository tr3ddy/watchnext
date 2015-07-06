WatchNextList = require '../models/watchnextlist'

exports.addList = (req, res) ->
	watchNextList = new WatchNextList {
		name: req.body.name,
		owner: req.user._id
		movies: []
	}
	watchNextList.save (err) ->
		if err
			return res.send err
		res.json {message: 'New list added'}

exports.getAllLists = (req, res) ->
	WatchNextList.find (err, lists) ->
		if err
			return res.send err
		res.json lists

exports.getListByUser = (req,res) ->
	WatchNextList.find {owner: req.user._id}, (err, lists) ->
		if err
			return res.send err
		res.json lists
