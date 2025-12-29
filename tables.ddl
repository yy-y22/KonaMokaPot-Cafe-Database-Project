-- 1. Create CUSTOMER table
CREATE TABLE CUSTOMER (
    CustomerID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    ContactNumber VARCHAR2(15) 
);

-- 2. Create PRODUCT table
CREATE TABLE PRODUCT (
    ProductID VARCHAR2(10) PRIMARY KEY,
    ProductName VARCHAR2(50) NOT NULL,
    UnitPrice NUMBER(10, 2),
    AvailableStatus VARCHAR2(20) 
);

-- 3. Create INVENTORY table
CREATE TABLE INVENTORY (
    ItemID VARCHAR2(10) PRIMARY KEY,
    ItemName VARCHAR2(50) NOT NULL,
    QuantityAvailable NUMBER(10),
    ReorderLevel NUMBER(10),
    LastUpdatedDate DATE 
);

-- 4. Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    EmployeeID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    EmploymentType VARCHAR2(20),
    HireDate DATE,
    HourlyRate NUMBER(10, 2),
    ProbationStatus VARCHAR2(20),
    ContactNumber VARCHAR2(15) 
);

-- 5. Create ROLE table
CREATE TABLE ROLE (
    RoleID VARCHAR2(10) PRIMARY KEY,
    RoleName VARCHAR2(50) NOT NULL 
);

-- 6. Create ORDER table
CREATE TABLE ORDERS (
    OrderID VARCHAR2(10) PRIMARY KEY,
    CustomerID VARCHAR2(10) REFERENCES CUSTOMER(CustomerID),
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID),
    OrderType VARCHAR2(20),
    OrderMethod VARCHAR2(20),
    OrderStatus VARCHAR2(20),
    TotalAmount NUMBER(10, 2) 
);

-- 7. Create ATTENDANCE table
CREATE TABLE ATTENDANCE (
    AttendanceID VARCHAR2(10) PRIMARY KEY,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID),
    WorkDate DATE,
    CheckInTime TIMESTAMP,
    CheckOutTime TIMESTAMP,
    Shift VARCHAR2(20) 
);

-- 8. Create PAYROLL table
CREATE TABLE PAYROLL (
    PayrollID VARCHAR2(10) PRIMARY KEY,
    Month VARCHAR2(20),
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID),
    PaymentDate DATE,
    TotalPay NUMBER(10, 2),
    TotalHours NUMBER(10, 2) 
);

-- 9. Create EMPLOYEE_ROLE table (Intersection for Many-to-Many)
CREATE TABLE EMPLOYEE_ROLE (
    EmployeeRoleID VARCHAR2(10) PRIMARY KEY,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID),
    RoleID VARCHAR2(10) REFERENCES ROLE(RoleID) 
);

-- 10. Create ORDERITEM table
CREATE TABLE ORDERITEM (
    OrderItemID VARCHAR2(10) PRIMARY KEY,
    OrderID VARCHAR2(10) REFERENCES ORDERS(OrderID),
    ProductID VARCHAR2(10) REFERENCES PRODUCT(ProductID),
    Quantity NUMBER(10),
    UnitPrice NUMBER(10, 2),
    Subtotal NUMBER(10, 2) 
);

-- 11. Create PAYMENT table
CREATE TABLE PAYMENT (
    PaymentID VARCHAR2(10) PRIMARY KEY,
    OrderID VARCHAR2(10) REFERENCES ORDERS(OrderID),
    PaymentMethod VARCHAR2(30),
    PaymentAmount NUMBER(10, 2),
    PaymentDate DATE 
);

-- 12. Create INVENTORY_TRANSACTION table
CREATE TABLE INVENTORY_TRANSACTION (
    TransactionID VARCHAR2(10) PRIMARY KEY,
    ItemID VARCHAR2(10) REFERENCES INVENTORY(ItemID),
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID),
    TransactionType VARCHAR2(20),
    QuantityChanged NUMBER(10),
    TransactionDate DATE 
);
