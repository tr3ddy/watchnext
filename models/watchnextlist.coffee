mongoose = require 'mongoose'
Schema = mongoose.Schema

WatchNextListSchema = new Schema {
	name: {
		type: String,
		required: true
	},
	owner: {
		type: String,
		required: true
	},
	movies: [{type: Schema.ObjectId, ref: 'Movie'}]
}

module.exports = mongoose.model 'WatchNextList', WatchNextListSchema