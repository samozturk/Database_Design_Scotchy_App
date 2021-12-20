CREATE DATABASE Scotchy;

/* ############### TABLE CREATION ############### */
CREATE TABLE Users(
    UserID INT NOT NULL AUTO_INCREMENT,
    UserName VARCHAR(255),
    UserSurname VARCHAR(255),
    UserEmail VARCHAR(255) NOT NULL, /* User can not register without e-mail */
    UserPhone VARCHAR(255),
    UserAddress VARCHAR(255) NOT NULL, /* Order can not be delivered without address */
    PRIMARY KEY (UserID)
);

CREATE TABLE Drivers(
    DriverID INT NOT NULL AUTO_INCREMENT,
    DriverName VARCHAR(255),
    DriverSurname VARCHAR(255),
    DriverEmail VARCHAR(255),
    DriverPhone VARCHAR(255),
    VehicleInfo VARCHAR(255),
    VehicleID INT NOT NULL, /* Driver must have a vehicle */
    PRIMARY KEY (DriverID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);

CREATE TABLE Vehicles(
    VehicleID INT NOT NULL AUTO_INCREMENT,
    VehicleLocation POINT,
    PRIMARY KEY (VehicleID)
);

CREATE TABLE Restaurants(
    RestaurantID INT NOT NULL AUTO_INCREMENT,
    RestaurantName VARCHAR(255),
    MealID VARCHAR(255) NOT NULL, /* Restaurant must have at least one menu to serve food*/
    ResturantAddress VARCHAR(255) NOT NULL, /* Resturant must have an address to serve food */
    RestaurantLocation POINT,
    PRIMARY KEY (RestaurantID)
);

CREATE TABLE Menus(
    MealID INT NOT NULL AUTO_INCREMENT,
    RestaurantID INT NOT NULL, /* This is not neccesary but exists for computational concerns */
    MealName VARCHAR(255),
    Price FLOAT DEFAULT 0.0,
    PRIMARY KEY (MealID)
);

ALTER TABLE Restaurants ADD FOREIGN KEY (MealID) REFERENCES Menus(MealID);
ALTER TABLE Menus ADD FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID);

CREATE TABLE TransportOrder(
    OrderID INT NOT NULL AUTO_INCREMENT,
    UserID INT NOT NULL, /* User must be present for an order */
    DriverID INT, /* Can be null, system may not be able to find available driver */
    OrderTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* Warning! Timestamp data type only extends to year 2038 */
    UserStartLocation POINT NOT NULL,
    DestinationLocation POINT NOT NULL,
    Cost FLOAT NOT NULL,
    TransactionID INT NOT NULL,
    UserRating TINYINT,
    DriverRating TINYINT,
    PRIMARY KEY (OrderID)
    FOREIGN KEY (UserID) REFERENCES Users (UserID),
    FOREIGN KEY (DriverID) REFERENCES Drivers (DriverID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions (TransactionID),
    CHECK (UserRating BETWEEN 5 AND 0),
    CHECK (DriverRating BETWEEN 5 AND 0)
);


CREATE TABLE MealOrder(
    OrderID INT NOT NULL AUTO_INCREMENT,
    UserID INT NOT NULL,
    DriverID INT NOT NULL,
    RestaurantID INT NOT NULL,
    MealID INT NOT NULL, 
    Quantity INT NOT NULL,
    TransactionID INT, /* Can be null, order can be cancalled */
    OrderTime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, /* Warning! Timestamp data type only extends to 2038 */
    PRIMARY KEY (OrderID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID), 
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    CHECK (Quantity > 0)
);

CREATE TABLE Transactions(
    TransactionID INT NOT NULL AUTO_INCREMENT,
    UserID INT NOT NULL,
    AMOUNT FLOAT, /* Order may be cancelled so this can be null */
    PRIMARY KEY (TransactionID),
    FOREIGN KEY(UserID) REFERENCES Users(UserID)
);

/* ############### VALUE INSERTATION ############### */

INSERT INTO Users (UserName, UserSurname, UserEmail, UserPhone, UserAddress)
            VALUES('Samet', 'Ozturk', 'ozturksa21@itu.edu.tr', '+905398258347', 'Samatya, Istanbul');

INSERT INTO Vehicles (VehicleID, VehicleLocation)
            VALUES(POINT(50.0755381, 14.4378005));

INSERT INTO Drivers (DriverName, DriverSurname, DriverEmail, DriverPhone, VehicleInfo, VehicleID)
            VALUES('Ezgi', 'Deren', 'ezgi_deren@yahoo.com', '+904252352562', 'Honda CBR 250', '1');

INSERT INTO Restaurants (RestaurantName, MealID, ResturantAddress, RestaurantLocation)
            VALUES('Meat Burger', '1', 'Maslak XYZ', POINT(53.0755381, 20.4378005));

INSERT INTO Menus (RestaurantID, MealName, Price)
            VALUES(1, 'Burger', 52.50);

INSERT INTO Transactions (UserID)
            VALUES (1),
                   (1);

INSERT INTO TransportOrder(UserID, DriverID, UserStartLocation, DestinationLocation, Cost,
                           TransactionID, UserRating, DriverRating)
            VALUES(1, 1, POINT(53.0755381, 20.4378005), POINT(59.0755381, 40.4378005), 78.90,
                   1, 4, 5);

INSERT INTO MealOrder (UserID, DriverID, RestaurantID, MealID, Quantity, TransactionID)
            VALUES(1, 1, 1, 1, 4, 1);


/* ############### CREATING INDEXES ############### */

CREATE INDEX idx_UserID
ON Users (UserID);

CREATE INDEX idx_DriverID
ON Users (DriverID);
