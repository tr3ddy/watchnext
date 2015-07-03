var express = require('express'),
    bodyParser = require('body-parser'),
    passwordHash = require('password-hash'),
    mongoose = require('mongoose'),
    passport = require('passport'),
    LocalStrategy = require('passport-local').Strategy;

var app = express();
 
var User = mongoose.model('User',{
    username: String,
    password: String,
    email: String,
});

mongoose.connect("mongodb://localhost/watchnext");




passport.use(new LocalStrategy(
  function(username, password, done) {
    User.findOne({ username: username }, function(err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Incorrect username.' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Incorrect password.' });
      }
      return done(null, user);
    });
  }
));

app.use(bodyParser());
app.use(passport.initialize())

// var db = mongoskin.db('mongodb://localhost:27017/watchnext', {safe:true})


app.route('/api/watchnextLists')
    .all(function (req, res, next) {
        // req.watchnextLists = db.collection('watchnextLists')
        next()
    })
    .get(function (req, res, next) {
        // req.watchnextLists.find({}, {limit:10, sort: [['_id',-1]]}).toArray(function (e, results) {
        //     if(e) return next(e)
        //     res.send(results)
        // })
    })
    .post(function (req, res, next) {
        // req.watchnextLists.insert(req.body, {}, function (e, results) {
        //     if (e) return next(e)
        //     res.send(results)
        // })
    })

app.route('/api/watchnextLists/:id')
    .all(function (req, res, next) {
        // req.watchnextLists = db.collection('watchnextLists')
        // next()
    })
    .get(function (req, res, next) {
        // req.watchnextLists.findById(req.params.id, function (e, result) {
        //     if (e) return next(e)
        //     res.send(result)
        // })
    })
    .put(function (req, res, next) {
        // req.watchnextLists.updateById(req.params.id, {$set: req.body}, {safe:true, multi:false}, function (e, result) {
        //     if (e) return next(e)
        //     res.send((result===1)?{msg:'success'}:{msg:'error'})
        // })
    })
    .delete(function (req, res, next) {
        // req.watchnextLists.removeById(req.params.id, function (e, result) {
        //     if (e) return next(e)
        //     res.send((result === 1) ? {msg: 'success'} : {msg: 'error'})
        // })
    })

app.listen(3000);
