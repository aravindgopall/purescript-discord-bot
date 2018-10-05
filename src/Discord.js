const discord = require('discord.js');


exports["getClient"] = function(options) {
	return function(){
		var client = new discord.Client();
		return client;
	}
}


exports["_updateToken"] = function(token) {
	return function(client) {
		return function(){
			return client.login(token);
		}
	}
}

exports["_onMessage"] = function(client) {
	return function(cb) {
		return function(){
			client.on("message", function(message) { return cb(message); });
		}
	}
}

exports["onReady"] = function(client) {
	return function(cb) {
		return function() {
			client.on("ready", function(){return cb()();} );
		}
	}
}
