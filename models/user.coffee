mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
Schema = mongoose.Schema

UserSchema = new Schema {
	username: {
		type: String,
		unique: true,
		required: true
	},
	password: {
		type: String,
		required: true
	},
	email: {
		type: String,
		required: true
	}
}

UserSchema.pre('save', (callback) -> 
	user = @
	if not user.isModified 'password'
		callback()
	bcrypt.genSalt 5, (err, salt) ->
		if err
			callback err
		bcrypt.hash user.password, salt, null, (err, hash) ->
			if err
				callback err
			user.password = hash
			callback()
			return
)

UserSchema.methods.verifyPassword = (password, cb) ->
	bcrypt.compare(password, @password, (err, isMatch) -> 
		if err
			cb err
		cb null, isMatch
)


module.exports= mongoose.model 'User', UserSchema