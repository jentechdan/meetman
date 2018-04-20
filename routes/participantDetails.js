
/*
 * GET home page.
 */
var massive = require('massive');
const connectionParms = {
  host: 'smtpgsdev01.isus.emc.com',
  port: 5432,
  database: 'postgres',
  user: 'smtdev',
  password: 'atmp95'
};
var db;
massive(connectionParms).then(connectedDB => {
  console.log('Connected to db');
  db = connectedDB;
}).catch(error => {
  console.log('Error connecting to db');
  console.log(error);
});

exports.postteam = function(req, res){

var myTeam = req.body.teamid;
var myParticipantID = req.body.id;

db.query("Update Participant set TeamID= $1 where ParticipantID= $2",[myTeam,myParticipantID]).then(function(results) {
        res.redirect('/participants?id=' + myParticipantID);
      }).catch(error => {
        console.log('Error updating db',error);
        res.status(500);
     });           
};  

