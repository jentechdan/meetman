

drop table Resume;
drop table Facilitator;
drop table Allergy;
drop table Expense;
drop table ExpenseType;
drop table Participant;
drop table Committee;
drop table Topic;
drop table Equipment;
drop table EventRoom;
drop table Meeting;
drop table Venue;
drop table VenueType;
drop table Team;
drop table FoodAllergy;
drop table Association;
drop table Organization;


create table Organization (
   OrganizationID	        	INTEGER       not null,
   OrganizationName					VARCHAR(50)			not null,
   constraint pkOrganization primary key (OrganizationID)
);

create table Association (
   AssociationID	         INTEGER       		not null,
   AssociationName				 VARCHAR(100)			not null,		
   Website                 VARCHAR(100),
   Phone1                  VARCHAR(50),
   Phone2				           VARCHAR(50),
   constraint pkAssociation primary key (AssociationID)
);

create table FoodAllergy (
   FoodAllergyID                INTEGER          not null,
   FoodAllergyName              VARCHAR(25)      not null,
   constraint pkFoodAllergy primary key (FoodAllergyID)
);

create table Team (
   TeamID	        		INTEGER           not null,
   TeamLetter 				CHAR(1)    			  not null,
   TeamColor					VARCHAR(15)				not null,			
   TeamSpiritName			VARCHAR(50),
   TeamPoints					INTEGER,
   TeamRank						INTEGER,
   constraint pkTeam primary key (TeamID)
);

create table VenueType (
  VenueTypeID           INTEGER           not null,
  VenueTypeDescription  VARCHAR(50)       not null,
  constraint pkVenueType primary key (VenueTypeID)
 ); 

create table Venue (     
  VenueID             INTEGER           not null, 
  VenueTypeID         INTEGER           not null,  
  VenueName           VARCHAR(100)      not null,      
  VenueAddress1       VARCHAR(100),   
  VenueAddress2       VARCHAR(100),   
  VenueCity           VARCHAR(100),   
  VenueState          CHAR(2),
  VenuePostal         VARCHAR(15),
  VenueCountry        VARCHAR(25),
  VenuePhone          VARCHAR(25),
  VenueFax            VARCHAR(25), 
  VenueCateringCost   NUMERIC,
  VenueSleepingRooms  INTEGER, 
constraint pkVenue primary key (VenueID));


create table Meeting (
   MeetingID	        		INTEGER           		not null,
   VenueID						    INTEGER,
   MeetingName			    	VARCHAR(100)      		not null,
   MeetingDateStart				DATE                  not null,
   MeetingDateEnd				  DATE                  not null,
   MeetingHours					  VARCHAR(50),
   MeetingSponsor				  VARCHAR(50),
   MeetingBudget          NUMERIC,
   constraint pkMeeting primary key (MeetingID),
   constraint fkMeetingVenue foreign key (VenueID)
   		references Venue(VenueID)
);

create table EventRoom (
  EventRoomID               INTEGER          not null,
  VenueID                   INTEGER          not null,
  MeetingID                 INTEGER,
  EventRoomName            VARCHAR(50)       not null,
  EventRoomSize            INTEGER,
  EventRoomFunction        VARCHAR(25),
  EventRoomLayout          VARCHAR(500),
  EventRoomCost            NUMERIC,
  constraint pkEventRoom primary key (EventRoomID),
  constraint fkEventRoomVenue foreign key (VenueID) 
      references Venue(VenueID),
  constraint fkEventRoomMeeting foreign key (MeetingID)
      references Meeting(MeetingID)    
  );

create table Equipment (
   EquipmentID					   INTEGER             not null,
   EventRoomID					         INTEGER		   not null,
   EquipmentDescription		 VARCHAR(100)		     not null,
   Quantity			      		 INTEGER					   not null,
   SetupInstructions			 VARCHAR(250),
   OwnedorRental				   CHAR(1),
   DailyRentalPrice				 NUMERIC,
   constraint pkEquipment primary key (EquipmentID),
   constraint fkEquipmentRoom foreign key (EventRoomID)
   		references EventRoom(EventRoomID)
);

create table Topic (
   TopicID	        	    	INTEGER           not null,
   TopicDescription		    	VARCHAR(100)      not null,
   TopicDate                DATE,
   TopicSequence				    INTEGER,
   MeetingID                INTEGER			  not null,
   constraint pkTopic primary key (TopicID),
   constraint fkTopicMeeting foreign key (MeetingID)
   		references Meeting(MeetingID)
);


create table Committee (
   CommitteeID                INTEGER         not null,
   CommitteeDescription       VARCHAR(100)    not null,
   constraint pkCommittee primary key (CommitteeID)
);

create table Participant (
    ParticipantID              	INTEGER       not null,
    OrganizationID				      INTEGER       not null,
    FirstName                   VARCHAR(100)  not null,
    LastName               		  VARCHAR(100)  not null,
    ShortName              		  VARCHAR(50),
    EmailAddress				        VARCHAR(100),
    FY							            VARCHAR(10),
    DietaryNeeds				        VARCHAR(250),
    TeeShirtSize                VARCHAR(20),
    EmergencyContact            VARCHAR(50),
    PreWorkComplete             CHAR(3),
    TeamID						          INTEGER,
    MeetingID					          INTEGER,
    CommitteeID                 INTEGER,
    constraint pkParticipant primary key (ParticipantID),
    constraint fkPartipantOrg foreign key (OrganizationID)
         references Organization (OrganizationID),
    constraint fkPartipantTeam foreign key (TeamID)    
    	 references Team(TeamID),
    constraint fkPartipantMeeting foreign key (MeetingID)
    	 references Meeting(MeetingID),
    constraint fkParticipantCommittee foreign key (CommitteeID)
       references Committee(CommitteeID)   	  
);

create table ExpenseType (
    ExpenseTypeID               INTEGER         not null,
    ExpenseTypeDescription      VARCHAR(50)     not null,
    constraint pfExpenseType primary key (ExpenseTypeID)
);

create table Expense (
    ExpenseID                   INTEGER         not null,
    ParticipantID               INTEGER         not null,
    ExpenseTypeID               INTEGER         not null,
    ExpenseDescription          VARCHAR(50),
    ExpenseAmount               NUMERIC         not null,
    ExpenseDate                 DATE,
    constraint pkExpense primary key (ExpenseID),
    constraint fkExpenseParticipant foreign key (ParticipantID)
        references Participant(ParticipantID),
    constraint fkExpenseType foreign key (ExpenseTypeID) 
        references ExpenseType(ExpenseTypeID)
);

create table Allergy (
    AllergyID                 INTEGER           not null,
    FoodAllergyID             INTEGER           not null,
    ParticipantID             INTEGER           not null,
    constraint pkAllergy primary key (AllergyID),
    constraint fkAllergyFood foreign key (FoodAllergyID)
        references FoodAllergy(FoodAllergyID),
    constraint fkAllergyParticipant foreign key (ParticipantID)
        references Participant(ParticipantID)    
);

create table Facilitator (
   FacilitatorID           		   INTEGER         not null,
   AssociationID				         INTEGER			   not null,
   MeetingID					           INTEGER,
   FacilitatorFN				         VARCHAR(50),
   FacilitatorLN				         VARCHAR(50),
   FacilitatorRole				       VARCHAR(50),
   constraint pkFacilitator primary key (FacilitatorID),
   constraint fkFacilitatorAssociation foreign key (AssociationID)
   		references Association (AssociationID),
   constraint fkFacilitatorMeeting foreign key (MeetingID)
        references Meeting(MeetingID)	
);

create table Resume (
   ResumeID					     INTEGER	        not null,
   FacilitatorID				 INTEGER          not null,
   YearsExperience			 INTEGER	        not null,		
   BackgroundDescription VARCHAR(1500),
   WorkFocus					   VARCHAR(1500),
   Expertise					   VARCHAR(1500),
   CorporateClients			 VARCHAR(1500),
   constraint pkResume primary key (ResumeID),
   constraint FKResumeFacilitator foreign key (FacilitatorID)
   		references Facilitator (FacilitatorID)
);

copy "organization" from '/Users/danieljensen/Desktop/Meeting Manager Files/Organization.csv' delimiter ',' csv HEADER;
copy "association" from '/Users/danieljensen/Desktop/Meeting Manager Files/Association.csv' delimiter ',' csv HEADER;
copy "foodallergy" from '/Users/danieljensen/Desktop/Meeting Manager Files/FoodAllergy.csv' delimiter ',' csv HEADER;
copy "team" from '/Users/danieljensen/Desktop/Meeting Manager Files/Team.csv' delimiter ',' csv HEADER;
copy "venuetype" from '/Users/danieljensen/Desktop/Meeting Manager Files/VenueType.csv' delimiter ',' csv HEADER;
copy "venue" from '/Users/danieljensen/Desktop/Meeting Manager Files/Venue.csv' delimiter ',' csv HEADER;
copy "meeting" from '/Users/danieljensen/Desktop/Meeting Manager Files/Meeting.csv' delimiter ',' csv HEADER;
copy "eventroom" from '/Users/danieljensen/Desktop/Meeting Manager Files/EventRoom.csv' delimiter ',' csv HEADER;
copy "equipment" from '/Users/danieljensen/Desktop/Meeting Manager Files/Equipment.csv' delimiter ',' csv HEADER;
copy "topic" from '/Users/danieljensen/Desktop/Meeting Manager Files/Topic.csv' delimiter ',' csv HEADER;
copy "committee" from '/Users/danieljensen/Desktop/Meeting Manager Files/Committee.csv' delimiter ',' csv HEADER;
copy "participant" from '/Users/danieljensen/Desktop/Meeting Manager Files/participant.csv' delimiter ',' csv HEADER;
copy "expensetype" from '/Users/danieljensen/Desktop/Meeting Manager Files/ExpenseType.csv' delimiter ',' csv HEADER;
copy "expense" from '/Users/danieljensen/Desktop/Meeting Manager Files/Expense.csv' delimiter ',' csv HEADER;
copy "allergy" from '/Users/danieljensen/Desktop/Meeting Manager Files/Allergy.csv' delimiter ',' csv HEADER;
copy "facilitator" from '/Users/danieljensen/Desktop/Meeting Manager Files/Facilitator.csv' delimiter ',' csv HEADER;
copy "resume" from '/Users/danieljensen/Desktop/Meeting Manager Files/Resume.csv' delimiter ',' csv HEADER;
