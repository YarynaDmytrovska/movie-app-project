CREATE DATABASE Cinematica;


CREATE DOMAIN public.text_no_digits AS text
CHECK (VALUE ~ '^[^0-9]*$'::text);

CREATE DOMAIN public.phone_number AS text 
CHECK (VALUE ~* '^\+\d{12}$'::text);

CREATE DOMAIN email AS VARCHAR(256)
CHECK (VALUE ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$');

CREATE DOMAIN password AS VARCHAR(255)
CHECK (VALUE ~* '^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+|~=`{}\[\]:";\'<>?,.\/]).{8,}$');

CREATE DOMAIN list AS character varying(50) NOT NULL
CHECK (VALUE::text = ANY (ARRAY['Watching'::character varying::text, 'Want to watch'::character varying::text, 'Wached'::character varying::text]));

CREATE DOMAIN rating AS character varying(50) NOT NULL
CHECK (VALUE::text = ANY (ARRAY['0'::character varying::text, '1'::character varying::text, '2'::character varying::text, '3'::character varying::text,'4'::character varying::text, '5'::character varying::text]));


CREATE TABLE Users (
UserID integer NOT NULL,
Email email UNIQUE NOT NULL,
Phone phone_number,
Password password NOT NULL,
Username VARCHAR(50) UNIQUE NOT NULL,
Avatar VARCHAR(255),
Description TEXT
PRIMARY KEY (UserID)
);

CREATE TABLE UserMovie (
SubscriberID integer NOT NULL,
FOREIGN KEY (UserID) REFERENCES Users(UserID), ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (SubscriberID)
);

CREATE TABLE Subscribers (
UserID integer NOT NULL,
SubscriberID integer NOT NULL,
FOREIGN KEY  (SubscriberID) REFERENCES UserMovie(SubscriberID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (UserID) REFERENCES Users(UserID), ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (UserID, SubscriberID)
);

CREATE TABLE MovieGenres (
GenreID integer NOT NULL,
GenreName text_no_digits NOT NULL,
PRIMARY KEY (GenreID)
);

CREATE TABLE Movies(
MovieID integer NOT NULL,
Title VARCHAR(50) UNIQUE NOT NULL,
Poster VARCHAR(255),
ReleaseYear integer ,
Duration  VARCHAR(50) NOT NULL,
Director text_no_digits NOT NULL,
Country  text_no_digits NOT NULL,
Plot TEXT,
PRIMARY KEY (MovieID)
);

CREATE TABLE MovieGenres_Movies (
MovieID integer NOT NULL,
GenreID integer NOT NULL,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,

FOREIGN KEY (GenreID) REFERENCES MovieGenres(GenreID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (MovieID, GenreID)
);

CREATE TABLE MovieLists (
ListID integer NOT NULL,
FOREIGN KEY (UserID) INT REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE CASCADE,
Status list NOT NULL,
PRIMARY KEY (ListID)
);

CREATE TABLE MovieInLists (
ID integer NOT NULL,
FOREIGN KEY (ListID) REFERENCES MovieLists(ListID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (ID)
);

CREATE TABLE Actor (
ActorID integer NOT NULL,
Name VARCHAR(50) UNIQUE NOT NULL,
Avatar VARCHAR(255),
BirthDate DATE NOT NULL,
DeathDate DATE ,
Nominations  VARCHAR(300) ,
Height  VARCHAR(80) ,
CountryOfBirth  text_no_digits,
ActingCareer TEXT NOT NULL,
Biography TEXT,
PRIMARY KEY (ActorID)
);

CREATE TABLE Actor_Movie (
ActorID integer NOT NULL,
MovieID integer NOT NULL,
FOREIGN KEY (ActorID) REFERENCES Actor(ActorID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (ActorID, MovieID)
);

CREATE TABLE Rewies (
RewiesID integer NOT NULL,
Comment TEXT,
FOREIGN KEY (UserID) INT REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (RewiesID)
);

CREATE TABLE RewiesLikes (
RewiesLikesID integer NOT NULL,
FOREIGN KEY (UserID) INT REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (RewiesID) REFERENCES Rewies(RewiesID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (RewiesLikesID)
);

CREATE TABLE Rating (
RatingID integer NOT NULL,
FOREIGN KEY (MovieID) REFERENCES Movies(MovieID) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (UserID) REFERENCES Users(UserID) ON UPDATE CASCADE ON DELETE CASCADE,
Rating rating,
PRIMARY KEY (RatingID)
);

CREATE TABLE NotificationType (
NotificationTypeID integer NOT NULL,
Type TEXT,
PRIMARY KEY (NotificationTypeID)
);

CREATE TABLE Notifications (
NotificationID integer NOT NULL,
UserID INT REFERENCES Users(UserID),
FOREIGN KEY (NotificationTypeID) REFERENCES NotificationType(NotificationTypeID) ON UPDATE CASCADE ON DELETE CASCADE,
PRIMARY KEY (NotificationID)
);