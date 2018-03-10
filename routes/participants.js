
/*
 * GET home page.
 */
var massive = require('massive');
const connectionParms = {
  host: 'localhost',
  port: 5432,
  database: 'MeetingManager',
  user: 'postgres',
  password: 'Sarge3836'
};
var db;
massive(connectionParms).then(connectedDB => {
  console.log('Connected to db');
  db = connectedDB;
}).catch(error => {
  console.log('Error connecting to db');
  console.log(error);
});

exports.list = function(req, res){

var myID = req.query.id;

if (myID != null) {
  myQuery = 'SELECT participant.*, organization.organizationname, team.* \
                FROM participant \
                  LEFT JOIN team ON team.teamid = participant.teamid \
                  LEFT JOIN organization on organization.organizationid = participant.organizationid \
                  where participant.participantid = ' + myID;
  myRender = 'participantDetails';

  } else {

  myQuery =  'SELECT participant.*, organization.organizationname, team.* \
                FROM participant \
                  LEFT JOIN team ON team.teamid = participant.teamid \
                  LEFT JOIN organization on organization.organizationid = participant.organizationid order by 1;'    
  myRender = 'participants';  
                           
}

      db.query(myQuery).then(function(results) {
        res.render(myRender, 
            { participants: results})
      }).catch(error => {
        console.log('Error querying db',error);
        res.status(500);
     });
           
};  

