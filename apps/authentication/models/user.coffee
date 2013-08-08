mongoose = require('mongoose')
Schema = mongoose.Schema
passportLocalMongoose = require('passport-local-mongoose')

userSchema = new Schema({})
userSchema.plugin(passportLocalMongoose);

module.exports = mongoose.model('User', userSchema)
