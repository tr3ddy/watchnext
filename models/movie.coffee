mongoose = require 'mongoose'
Schema = mongoose.Schema

MovieSchema = new Schema {
	title: {
		type: String,
		required: true
	},
	imdb: {
		type: String,
		required: true
	}
}

module.exports = mongoose.model 'Movie', MovieSchema