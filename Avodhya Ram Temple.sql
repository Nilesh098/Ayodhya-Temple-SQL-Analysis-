
# Create database with name as Ayodhya_Ram_Temple

Create database Ayodhya_Ram_temple;

use Ayodhya_Ram_temple;

# Adding Tables 

-- Table for Deity

CREATE TABLE Deity(
		DeityID int primary key,
		Name varchar(255) not null ,
		Description Text
        );

-- Table for Temple
CREATE TABLE Temple(
		TempleID int primary key ,
		Name Varchar(255) not null ,
		Location varchar(255) ,
		construction_Start_Date Date,
		Expected_Completion_Date Date 
		);
        
-- Table for ConstructionPhase

Create Table Construction_Phase(
			PhaseID int primary key , 
			TempleID Int , 
			PhaseName varchar(255) not null ,
			Start_Date Date ,
			Completion_Date Date,
			Constraint  fk_temple Foreign key (TempleID) References Temple(TempleID)
			);

-- Table For Architecture 

Create Table Architecture(
				 ArchitectureID  int Primary key ,
				 TempleID Int , 
				 Architect_name varchar(255) not null ,
				 Description text ,
				 constraint fk_temple_architecure foreign key (TempleID) references temple(TempleID)
				 );

-- Table For Donations

Create Table Donations(
		DonationID int primary key,
		DonorName varchar(255) not null,
		Amount Decimal(10,2) not null,
		Donation_Date Date,
		TempleID int,
		constraint fk_temple_donations foreign key (TempleID) references Temple(TempleID)
				);
                
-- Table for Events
 
 create Table Events (
				 EventID int primary key ,
				 EventName varchar(255) not null,
				 EventDate date ,
				 Description Text
				 );
                 
                 
-- Table  for TempleEvents

Create Table TempleEvents(
					TempleID Int,
					EventID  int , 
					constraint fk_temple_events_temple foreign key (TempleID) references Temple(TempleID),
					constraint fk_temple_events_event foreign key (EventID) references Events(EventID),
                    Primary Key (TempleID ,EventID)
					);



-- Inserting Values into Deity Table 

Insert into Deity
(DeityID  , Name ,Description)
values
(1 ,"Ram" , 'An incernation of Vishnu , a principal deity of Hinduism born in Ayodhya.'),
(2 ,"Ram Lalla Virajman" , "The infant form of Rama ,the  presiding deity of the Ram Mandir temple.");

-- Inserting values into the Temple Table


Insert into Temple
(TempleID  ,  Name  , Location , Construction_start_date ,Expected_completion_date)
values
(1 , "Ram Mandir" ,"Ayodhya ,Uttar Pradesh ,India" , "2020-03-01" , "2024-01-22");


-- Example values for ConstructionPhase table

Insert into Construction_Phase 
( PhaseID ,TempleID ,PhaseName,Start_Date ,Completion_date)
values
( 1 , 1 , "Phase 1" , "2020-03-01" ,"2020-05-15"),
(2 , 1, "Phase 2" ,"2020-06-01" ,"2020-08-30" ),
(3,1 , "Phase 3","2021-01-10" ,"2021-03-25"),
(4 , 1 , "Phase 4" , "2021-06-15","2022-02-28"); 

-- Inserting Values into the Architecture Table.

Insert into Architecture 
( ArchitectureID , TempleID , Architect_name , Description)
values
(1, 1 , "Chandrakant Sompura" , "Chief architect of the temple"),
(2, 1 , "Nikhil Sompura" , "Assistant architect"),
(3,1,"Ashish Sompura","Assistantt architect");


-- Inserting sample data for Donations

Insert into Donations
( DonationID ,DonorName ,Amount ,Donation_Date ,TempleID )
values 
(1 , "Ram Nath Kovind" , 501000.00 , "2021-01-15",1),
(2, "Anonymous Donor" , 100.00 , "2021-02-01" , 1),
(3 , "Leadership Council" , 1000000.00 ,"2021-03-10", 1),
(4 , "H.D. Kumaraswamy" , 5000.00 ,"2021-05-01" ,1),
(5 ,"Siddaramaish" ,20000.00 , "2021-05-15",1),
(6 , "VHP Activist 1" , 50.00 ,"2021-06-01",1 ),
(7 , "VHP Activist 2",75.00 ,"2021-06-15",1),
(8 , "Muslim Community Member",1000.00,"2021-07-01",1),
(9 , "Christian Community Member" , 500.00 ,"2021-07-15",1),

(10 , "Anonymous Supporter" ,200.00 , "2021-08-01" ,1);


-- Inserting sample values into Events table

Insert into Events 
(EventID , EventName ,Eventdate ,description)
values
(1,"Commencement Ceremony","2020-08-05","Ceremony celebrating the commencement of Ram Mandir construction by PM Narendra Modi"),
(2 , "Bhoomi Pujan Ceremony" , "2020-08-05","Ground-breaking ceremony with Vedic ritual and foundation stone laying by PM Narendra Modi"),
(3 , "Vijay Mahamantra Jaap Anushthan ", "2020-04-06" , "Chanting of Vijay Mahamantra for victory over hurdles in temple construction"),
(4 , "Pran Pratishtha Ceremony" ,"2024-01-22","consecration ceremony scheduled for the installation of Lord Ram idol in the garbhagriha");

-- Insert values into TempleEvents table

Insert into TempleEvents 
(TempleID,EventID)
values
(1,1),  -- Assuming TempleID 1 and EventID 1 are associated
(1,2),  -- Assuming TempleID 1 and EventID 2 are associated
(1,3),  -- Assuming TempleID 1 and EventID 4 are associated
(1,4);  -- Assuming TempleID 1 and EventID 5 are associated



-- Q1) Retrieve information about the Ram Mandir?

select * from temple;

-- Q2) List all construction phases for the Ram Mandir ?

select cp.TempleID ,cp.PhaseName ,cp.Start_Date ,cp.Completion_Date  from 
construction_phase as cp
left join temple as t
on cp.TempleID = t.TempleID
where t.Name="Ram Mandir"; 

-- Q3) Find the total amount of Donations received for the Ram Mandir?

select concat("₹",sum(amount))
from Donations as d
join temple as t
on t.TempleID = d.TempleID
where T.Name like "Ram Mandir";

-- Q4) Get details about architecture of Ram Mandir?

select a.ArchitectureID , a.TempleID ,a.Architect_name ,a.Description
from architecture as a
join temple as t
on a.TempleID = t.TempleID
where t.name like "Ram Mandir";

-- Q5) Retrieve events associated with the Ram Mandir ?

select e.EventName ,e.EventDate ,e.Description
from
events as e
join templeevents as te
on e.EventID = te.EventID
join temple as t
on te.TempleID = t.TempleID
where t.name like "Ram Mandir";

-- Q6) Find donors who contribute more than 50000 towards the Ram Mandir ?

select d.DonorName 
from donations as d
join temple as t
on t.TempleID =d.TempleID
where t.Name like "Ram Mandir" and d.amount >50000;

-- Q7) Retrieve Details about a specific deity (e.g Rama)

select * 
from deity 
where description like "%Rama%";

-- Q8) Find the start and end date of the construction phase for the Ram Mandir ?

select  cp.Start_date ,cp.Completion_Date ,T.Name
from construction_phase as cp
join temple as t
on t.TempleID = cp.TempleID 
where t.Name like "Ram Mandir";

-- Q9) Count the number of events associated with each temple ?

select count(e.eventID)
from events as e
join templeevents as te
on e.EventID = te.EventID
group by te.TempleID ;

-- Q10) Find the donors who  made contributions on or after 2021-06-01 ?

select * from donations
where Donation_date >="2021-06-01";