-- 1. Create CUSTOMER table
CREATE TABLE CUSTOMER (
    CustomerID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    ContactNumber VARCHAR2(15) NOT NULL
);

-- 2. Create PRODUCT table
CREATE TABLE PRODUCT (
    ProductID VARCHAR2(10) PRIMARY KEY,
    ProductName VARCHAR2(50) NOT NULL,
    UnitPrice NUMBER(10, 2) NOT NULL, 
    AvailableStatus VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_unit_price CHECK (UnitPrice > 0)
);

-- 3. Create INVENTORY table
CREATE TABLE INVENTORY (
    ItemID VARCHAR2(10) PRIMARY KEY,
    ItemName VARCHAR2(50) NOT NULL,
    QuantityAvailable NUMBER(10) NOT NULL,
    ReorderLevel NUMBER(10) NOT NULL,
    LastUpdatedDate DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT chk_reorder_lvl CHECK (ReorderLevel >= 0)
);

-- 4. Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    EmployeeID VARCHAR2(10) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    EmploymentType VARCHAR2(20) NOT NULL,
    HireDate DATE NOT NULL,
    HourlyRate NUMBER(10, 2) NOT NULL,
    ProbationStatus VARCHAR2(20) NOT NULL,
    ContactNumber VARCHAR2(15), -- Optional, can stay nullable
    CONSTRAINT chk_emp_type CHECK (EmploymentType IN ('Full-time', 'Part-time', 'Casual'))
);

-- 5. Create ROLE table
CREATE TABLE ROLE (
    RoleID VARCHAR2(10) PRIMARY KEY,
    RoleName VARCHAR2(50) NOT NULL
);

-- 6. Create ORDER table
CREATE TABLE ORDERS (
    OrderID VARCHAR2(10) PRIMARY KEY,
    CustomerID VARCHAR2(10) REFERENCES CUSTOMER(CustomerID) NOT NULL,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID) NOT NULL,
    OrderType VARCHAR2(20) NOT NULL,
    OrderMethod VARCHAR2(20) NOT NULL,
    OrderStatus VARCHAR2(20) NOT NULL,
    TotalAmount NUMBER(10, 2) NOT NULL,
    CONSTRAINT chk_order_method CHECK (OrderMethod IN ('Counter', 'Foodpanda'))
);

-- 7. Create ATTENDANCE table
CREATE TABLE ATTENDANCE (
    AttendanceID VARCHAR2(10) PRIMARY KEY,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID) NOT NULL,
    WorkDate DATE NOT NULL,
    CheckInTime TIMESTAMP NOT NULL,
    CheckOutTime TIMESTAMP, 
    Shift VARCHAR2(20) NOT NULL,
    CONSTRAINT chk_shift CHECK (Shift IN ('Morning', 'Evening'))
);

-- 8. Create PAYROLL table
CREATE TABLE PAYROLL (
    PayrollID VARCHAR2(10) PRIMARY KEY,
    Month VARCHAR2(20) NOT NULL,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID) NOT NULL,
    PaymentDate DATE NOT NULL,
    TotalPay NUMBER(10, 2) NOT NULL,
    TotalHours NUMBER(10, 2) NOT NULL,
    CONSTRAINT chk_tot_hours CHECK (TotalHours >= 0)
);

-- 9. Create EMPLOYEE_ROLE table (Intersection for Many-to-Many)
CREATE TABLE EMPLOYEE_ROLE (
    EmployeeRoleID VARCHAR2(10) PRIMARY KEY,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID) NOT NULL,
    RoleID VARCHAR2(10) REFERENCES ROLE(RoleID) NOT NULL
);

-- 10. Create ORDERITEM table
CREATE TABLE ORDERITEM (
    OrderItemID VARCHAR2(10) PRIMARY KEY,
    OrderID VARCHAR2(10) REFERENCES ORDERS(OrderID) NOT NULL,
    ProductID VARCHAR2(10) REFERENCES PRODUCT(ProductID) NOT NULL,
    Quantity NUMBER(10) NOT NULL,
    UnitPrice NUMBER(10, 2) NOT NULL,
    Subtotal NUMBER(10, 2) NOT NULL
);

-- 11. Create PAYMENT table
CREATE TABLE PAYMENT (
    PaymentID VARCHAR2(10) PRIMARY KEY,
    OrderID VARCHAR2(10) REFERENCES ORDERS(OrderID) NOT NULL,
    PaymentMethod VARCHAR2(30) NOT NULL,
    PaymentAmount NUMBER(10, 2) NOT NULL,
    PaymentDate DATE NOT NULL,
    CONSTRAINT chk_pay_meth CHECK (PaymentMethod IN ('POS Terminal', 'QR Code', 'Cash')),
    CONSTRAINT chk_pay_amt CHECK (PaymentAmount > 0)
);

-- 12. Create INVENTORY_TRANSACTION table
CREATE TABLE INVENTORY_TRANSACTION (
    TransactionID VARCHAR2(10) PRIMARY KEY,
    ItemID VARCHAR2(10) REFERENCES INVENTORY(ItemID) NOT NULL,
    EmployeeID VARCHAR2(10) REFERENCES EMPLOYEE(EmployeeID) NOT NULL,
    TransactionType VARCHAR2(20) NOT NULL,
    QuantityChanged NUMBER(10) NOT NULL,
    TransactionDate DATE NOT NULL,
    CONSTRAINT chk_trans_type CHECK (TransactionType IN ('Restock', 'Handover', 'Damage'))
);
