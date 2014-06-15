var express = require('express'),
    bodyParser = require('body-parser'),
    passwordHash = require('password-hash'),
    mongoskin = require('mongoskin');

var app = express();
app.use(bodyParser());

var db = mongoskin.db('mongodb://localhost:27017/watchnext', {safe:true})


app.use(express.static(__dirname + '/public'))


app.route('/api/watchnextLists')
    .all(function (req, res, next) {
        req.watchnextLists = db.collection('watchnextLists')
        next()
    })
    .get(function (req, res, next) {
        req.watchnextLists.find({}, {limit:10, sort: [['_id',-1]]}).toArray(function (e, results) {
            if(e) return next(e)
            res.send(results)
        })
    })
    .post(function (req, res, next) {
        req.watchnextLists.insert(req.body, {}, function (e, results) {
            if (e) return next(e)
            res.send(results)
        })
    })

app.route('/api/watchnextLists/:id')
    .all(function (req, res, next) {
        req.watchnextLists = db.collection('watchnextLists')
        next()
    })
    .get(function (req, res, next) {
        req.watchnextLists.findById(req.params.id, function (e, result) {
            if (e) return next(e)
            res.send(result)
        })
    })
    .put(function (req, res, next) {
        req.watchnextLists.updateById(req.params.id, {$set: req.body}, {safe:true, multi:false}, function (e, result) {
            if (e) return next(e)
            res.send((result===1)?{msg:'success'}:{msg:'error'})
        })
    })
    .delete(function (req, res, next) {
        req.watchnextLists.removeById(req.params.id, function (e, result) {
            if (e) return next(e)
            res.send((result === 1) ? {msg: 'success'} : {msg: 'error'})
        })
    })



app.listen(3000);
