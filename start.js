////////////////////////////////////////////////////////////////////////////////////////////
// MINERSTAT.COM - LINUX CLIENT BETA

"use strict";

var colors = require('colors'); var sleep = require('sleep');
var pump = require('pump'); var fs = require('fs');
let ascii_text_generator = require('ascii-text-generator');

var tools = require('./tools.js');
var settings = require("./config.js");

global.timeout;

process.on('SIGINT', function() {
console.log("Ctrl + C --> Closing running miner & minerstat");
tools.killall(); process.exit(); });

process.on('uncaughtException', function (err) { console.log(err);    var log = err + ""; if(log.indexOf("ECONNREFUSED") > -1) { 
clearInterval(global.timeout); tools.restart();  }    })

process.on('unhandledRejection', (reason, p) => { });

function header() {
console.log(colors.cyan('/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*'));
console.log(colors.cyan('------------------------ v0.1 Linux Beta ---------------------------'));
console.log(colors.cyan("*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
console.log('');
let input_text = "minerstat";
let text ="/*\n" + ascii_text_generator(input_text,"2") + "\n*/";
console.log(text);
}

function getDateTime() {
var date = new Date(); var hour = date.getHours(); var min  = date.getMinutes(); var sec  = date.getSeconds(); 
hour = (hour < 10 ? "0" : "") + hour; min = (min < 10 ? "0" : "") + min; sec = (sec < 10 ? "0" : "") + sec; return hour + ":" + min + ":" + sec;
}

module.exports = {
main: function () {

tools.killall();

global.sync; global.res_data; global.sync_num; global.sync = new Boolean(false);
global.sync_num = 0; global.res_data = "";

header();

console.log(colors.cyan(getDateTime() + " WORKER: " + global.worker)); 

// GET DEFAULT CLIENT AND SEND STATUS TO THE SERVER
const https = require('https');
var needle = require('needle');

needle.get('https://minerstat.com/getresponse.php?action=getminer&token='+ global.accesskey +'&worker=' + global.worker, function(error, response) {
global.client = response.body;


var request = require('request');
request.get({
  url:     'http://minerstat.com/control.php?worker='+ global.accesskey +'.' + global.worker + '&miner=' + response.body + '&os=linux&ver=4&cpu=NO',
  form:    { mes: "kflFDKME" }
}, function(error, response, body){
 console.log(colors.green("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
 console.log(colors.green(getDateTime() + " MINERSTAT.COM: Waiting for the first sync.. (60 sec)")); 
 console.log(colors.green("*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
});


dlconf();
});


//// GET CONFIG TO YOUR DEFAULT MINER
function dlconf() {

if(global.client === "claymore-eth") { global.db = "eth"; }
if(global.client === "claymore-xmr") { global.db = "xmr"; }
if(global.client === "claymore-zec") { global.db = "zec"; } 
if(global.client === "ewbf-zec") { global.db = "ezec"; } 
if(global.client === "sgminer-gm") { global.db = "sgg"; } 
if(global.client === "ethminer") { global.db = "genoil"; }

if(global.client.indexOf("ewbf") > -1) { global.file = "clients/"+ global.client + "/start.bash"; }
if(global.client.indexOf("ethminer") > -1) { global.file = "clients/"+ global.client + "/start.bash"; }
if(global.client.indexOf("claymore") > -1) { global.file = "clients/"+ global.client + "/config.txt"; }
if(global.client.indexOf("sgminer") > -1) { global.file = "sgminer.conf"; }

needle.get('https://minerstat.com/getconfig.php?action=simple&token='+ global.accesskey +'&worker=' + global.worker + '&db=' + global.db, function(error, response) {
global.chunk = response.body;

if(global.client != "ewbf-zec" && global.client != "ethminer") {

var writeStream = fs.createWriteStream(global.path + "/" + global.file);
console.log(global.chunk);
var str = global.chunk;

if(global.client.indexOf("sgminer") > -1) {
str = JSON.stringify(str);
}

writeStream.write(""+str);
writeStream.end();

writeStream.on('finish', function(){
tools.killall();
tools.start();
});

} else {
console.log(global.chunk); 
tools.killall();
tools.start();    
}

});
    
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// START LOOP  //////////////////////////////////////////////////////////////////////////////////////////////

(function() {
global.timeout = setInterval(function() {



global.sync_num ++;
tools.remotecommand();
tools.fetch();

if (global.sync_num > 1) { //SKIP THE FIRST SYNC
    
    if (global.client !== "ethminer") { //SKIP ETHMIENR BECAUSE INTEGRATED
      
// SEND LOG TO SERVER

var sync = global.sync;
var res_data = global.res_data;

if(sync.toString() === "true"){ // IS HASHING?

var request = require('request');
request.post({
url: 'https://minerstat.com/getstat.php?token='+ global.accesskey +'&worker='+ global.worker+'&miner='+global.client, form: { mes: res_data }
}, function(error, response, body){
console.log(colors.green("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
console.log(colors.green(getDateTime() + " MINERSTAT.COM: Package Sent ["+global.worker+"]"));
console.log(colors.green("*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
});  } else {
console.log(colors.red("/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
console.log(colors.red(getDateTime() + " MINERSTAT.COM: Package Error  ["+global.worker+"]")); 
console.log(colors.red("*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/"));
}



}
}

}, 30000);
})();

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// END LOOP/////////////////////////////////////////////////////////////////////////////////////////////


}
};
tools.restart();
