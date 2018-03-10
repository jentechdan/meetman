
create table Organization (
   OrganizationID	        		INTEGER           	not null,
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

create table Team (
   TeamID	        		INTEGER       not null,
   TeamLetter 				CHAR(1)    			  not null,
   TeamColor					VARCHAR(15)				not null,			
   TeamSpiritName			VARCHAR(50),
   TeamPoints					INTEGER,
   TeamRank						INTEGER,
   constraint pkTeam primary key (TeamID)
);

create table Venue (
   VenueID	        	 		INTEGER       			not null,
   VenueName				 	VARCHAR(100)			not null,		
   VenueAddress1           		VARCHAR(100),
   VenueAddress2           		VARCHAR(100),
   VenueCity				 	VARCHAR(100),
   VenueState				 	CHAR(2),
   constraint pkVenue primary key (VenueID)
);

create table Meeting (
   MeetingID	        		INTEGER           		not null,
   VenueID						INTEGER,
   MeetingName			    	VARCHAR(100)      		not null,
   MeetingDateStart				DATE                    not null,
   MeetingDateEnd				DATE                    not null,
   MeetingHours					VARCHAR(50),
   MeetingSponsor				VARCHAR(50),
   MeetingRoomName				VARCHAR(50),
   constraint pkMeeting primary key (MeetingID),
   constraint fkMeetingVenue foreign key (VenueID)
   		references Venue(VenueID)
);


create table Equipment (
   EquipmentID					INTEGER           not null,
   MeetingID					INTEGER					    not null,
   EquipmentDescription		VARCHAR(100)		not null,
   Quantity			      		INTEGER					not null,
   SetupInstructions			VARCHAR(250),
   OwnedorRental				CHAR(1),
   DailyRentalPrice				NUMERIC,
   constraint pkEquipment primary key (EquipmentID),
   constraint fkEquipmentMeeting foreign key (MeetingID)
   		references Meeting(MeetingID)
);

create table Topic (
   TopicID	        	    	INTEGER           not null,
   TopicDescription		    	VARCHAR(100)      not null,
   TopicDate                 	DATE,
   TopicSequence				INTEGER,
   MeetingID                    INTEGER			  not null,
   constraint pkTopic primary key (TopicID),
   constraint fkTopicMeeting foreign key (MeetingID)
   		references Meeting(MeetingID)
);


create table Participant (
    ParticipantID              	INTEGER           		not null,
    OrganizationID				INTEGER                 not null,
    FirstName                   VARCHAR(100)     		not null,
    LastName               		VARCHAR(100)     		not null,
    ShortName              		VARCHAR(50),
    EmailAddress				VARCHAR(100),
    FY							    VARCHAR(10),
    DietaryNeeds				VARCHAR(250),
    TeamID						INTEGER,
    MeetingID					INTEGER,
    constraint pkParticipant primary key (ParticipantID),
    constraint fkPartipantOrg foreign key (OrganizationID)
         references Organization (OrganizationID),
    constraint fkPartipantTeam foreign key (TeamID)    
    	 references Team(TeamID),
    constraint fkPartipantMeeting foreign key (MeetingID)
    	 references Meeting(MeetingID)	  
);


create table Facilitator (
   FacilitatorID           		INTEGER         not null,
   AssociationID				INTEGER			not null,
   MeetingID					INTEGER,
   FacilitatorFN				VARCHAR(50),
   FacilitatorLN				VARCHAR(50),
   FacilitatorRole				VARCHAR(50),
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
   WorkFocus					 VARCHAR(1500),
   Expertise					 VARCHAR(1500),
   CorporateClients				 VARCHAR(1500),
   constraint pkResume primary key (ResumeID),
   constraint FKResumeFacilitator foreign key (FacilitatorID)
   		references Facilitator (FacilitatorID)
);






