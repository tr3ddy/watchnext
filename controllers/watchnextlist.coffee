WatchNextList = require '../models/watchnextlist'
Movie = require '../models/movie'

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

exports.getListById = (req,res) ->
	WatchNextList.find({_id: req.params.list_id}).populate('movies').exec (err, list) ->
		if err
			return res.send err
		res.json list

exports.updateList = (req,res) ->
	WatchNextList.findOne {_id: req.params.list_id}, (err, list) ->
		if err
			return res.send err
		list.name = req.body.name

		list.save (err) ->
			if err
				return res.send err
			res.send 200
		
exports.insertMovie = (req,res) -> 
	WatchNextList.findOne {_id: req.params.list_id}, (err, list) ->
		if err
			return res.send err
		myMovie = new Movie {
			title: req.body.title,
			imdb: req.body.imdb
		}
		myMovie.save (err) ->
			if err
				return res.send err
		list.movies.push myMovie
		list.save (err) ->
			if err
				return res.send err
			res.send 200
