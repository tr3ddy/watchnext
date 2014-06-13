var express = require('express');
var bodyParser = require('body-parser');
var passwordHash = require('password-hash');
var app = express();

var mongoose = require('mongoose');

mongoose.connect('mongodb://localhost:27017/watchnext');

var Schema = mongoose.Schema;

var User = new Schema({
    id: {type: String, required: true},
    saltedHash: {type: String, required: true}
});

var UserModel = mongoose.model('User', User);

app.use(bodyParser.json());

app.route('/api/users')
    .all(function (req, res, next) {
        next();
    })
    .get(function(req, res, next){
        return UserModel.find(function (err, users) {
            if(!err){
                return res.send(users)
            }else{
                return console.log(err);
            }
        })
    })
    .post(function (req, res, next) {
        var hash = passwordHash.generate(req.body.password);
        var user = new UserModel({
            id: req.body.id,
            saltedHash: hash
        });
        user.save(function (err){
            if(!err){
                return console.log("created");
            }else {
                return console.log(err);
            }
        });
        return res.send(user);
    });


app.listen(3000);
