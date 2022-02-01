# Database_Design_Scotchy_App
Database Design of Scotchy App

</br>
Scotchy is a location based application. In this app, users can buy two kind services:

1) Transportation

2) Food Delivery

For transportation, when user(client) request a driver, app creates an order called TransportOrder. It first get user's ID and location; finds closest vehicle and therefore driver. After driver takes user, trip starts and when they get to destination point trip ends. Afterwards, transaction happens and then they can rate each other.

For food delivery, user enters his/her address, requested meal(s) from requested restaurants menu. The closest driver gets assigned to the order and transaction happens. Then driver brings the order to the user's address.

### **Tables**:

Users

Drivers

Vehicles

Restaurants

Menus

MealOrder

Transactions

### Columns:

Users.UserID: Primary key of the table. Unique id for each user

Users.UserName: Name of the user

Users.UserSurname: Surname of the user

Users.UserEmail: Mail of the user

Users.UserPhone: Phone number of the user

Users.UserAddress: User's address for delivery

Drivers.DriverID: Primary key of the table. Unique id for each driver

Drivers.DriverName: Driver's Name

Drivers.DriverSurname: Driver's Surname

Drivers.DriverPhone: Driver's phone number

Drivers.Vehicle_Info: Driver's Vehicle Info. This can be used for availability metrics(range, speed etc.)

Drivers.VehicleID: Driver's vehicle ID to join "Vehicles" table

Vehicles.VehicleID: Primary key of the table. Unique id for each vehicle

Vehicles.Vehicle_Location: Vehicle's current location. Can be used to find closest vehicle by comparing TransportOrder.User_Start_Location or Restaurants.Restaurant_Location

Restaurants.RestaurantID: Primary key of the table. Unique id for each restaurant

Restaurants.Restaurant_Name: Restaurant's name

Restaurants.MenuID: Menu's ID

Restaurants.Address: Restaurant's Adress

Restaurants.Restaurant_Location: Restaurant's coordinates, used to match closest vehicle

Menus.MealID: Primary key of the table. Unique id for each menu

Menus.RestaurantID: Restaurant's ID which menu belongs to

Menus.MealName: Meal's name

Menus.Price: Meal's Price

TransportOrder.OrderID: Primary key of the table. Unique id for each order

TransportOrder.UserID: User's ID who created the order

TransportOrder.DriverID: Driver's ID who will do the transportation

TransportOrder.Timestamp: Timestamp of order's creation

TransportOrder.User_Start_Location: User's location who created the order. This will be used to find closest vehicle and driver

TransportOrder.Destination_Location: The location where user will travel.

TransportOrder.Cost: Price of the travel

TransportOrder.TransactionID: TransactionID of order

 MealOrder.OrderID: Primary key of the table. Unique id for each order

MealOrder.UserID: User's ID who created the order

MealOrder.DriverID: Driver's ID who will bring the order

MealOrder.RestaurantID: Ordered restaurant's ID

MealOrder.MenuID: Ordered restaurant's menu's ID

MealOrder.Meal_Name: Ordered meal's name

MealOrder.Price: Ordered meal's price

MealOrder.Quantity: Ordered meal's quantity

MealOrder.Timestamp: Timestamp of order's creation

MealOrder.TransactionID: TransactionID of order

Transactions.TransactionID: Primary key of the table. Unique id for each transaction

Transactions.UserID: User's ID who created the transaction

### Indexes:

idx_UserID: UserID is used on most of the tables as foreign key and joining relevant table. It is also crucial data which we do not insert(or upsert) often yet usually retrieve. Thus this field is chosen to be indexed.

idx_idx_DriverID: Yet another important field with same functionality as UserID. It is not used much for inserting; only when new Driver joins. So it is chosen to be indexed too.

idx_RestaurantID: It is used similar to other indexes; for joining tables when a food delivery order comes. Restaurant is not inserted so often so it is chosen to be indexed too.

### Stored Procedures:

Get_Mean_User_Ratings: Gets average of all user ratings. This information is used for user's profile when he/she requested a transport order. Driver sees user's mean rating.

Get_Mean_Driver_Ratings: Gets average of all driver ratings. This information is used for driver's profile when user requested a transport order. User sees driver's mean rating. 

User_Total_Transaction: This show how much money a user spent on app. Some promotions may be offered to users with high monetary value.
