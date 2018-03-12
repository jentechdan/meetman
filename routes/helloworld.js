
/*
 * GET home page.
 */

exports.hello = function(req, res){

// Lets create an array and load it with User Data
  var myArray = [];
  myArray.push({
 		  participantid: "1",
  		organization: "Round Rock",
  		firstname: "Scott",
      lastname: "Troyer",
      email: "scott.troyer@dell.com"});
  myArray.push({
      participantid: "2",
      organization: "Austin",
      firstname: "Jean",
      lastname: "Ludlam",
      email: "jean.ludlam@dell.com"});
  myArray.push({
      participantid: "3",
      organization: "Southboro",
      firstname: "Michael",
      lastname: "Clarke",
      email: "michael.clark@dell.com"});
 
  title = "Hello World";
  m_names = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");

  d = new Date();
  curr_day = d.getDate();
  curr_month = d.getMonth();
  curr_year = d.getFullYear();
  reportdate =  curr_day + "-" + m_names[curr_month] + "-" + curr_year;                 

  res.render('helloworld', 
  			{ tabletitle: title, 
          reportdate: reportdate,
  			  header1: 'Participant ID',
  			  header2: 'Organization',
  			  header3: 'First Name',
          header4: 'Last Name',
          header5: 'Email',
  			  participants:  myArray})
};
