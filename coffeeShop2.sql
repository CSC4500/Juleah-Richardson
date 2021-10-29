-- ********************************************
-- CREATE THE coffeeShop DATABASE
-- *******************************************

-- create the database
DROP DATABASE IF EXISTS coffeeShop;
CREATE DATABASE coffeeShop;

-- select the database
USE coffeeShop;

-- create the tables
CREATE TABLE rewards_program
(
  rewards_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  date_created     date    NOT NULL,
  account_status       CHAR(50)            NOT NULL,
  current_points   INT        NOT NULL
    
);
CREATE TABLE customer
(
  cust_id        INT            PRIMARY KEY AUTO_INCREMENT,
  cust_fName   CHAR(50)    NOT NULL,
  cust_lName   CHAR(50)    NOT NULL,
  cust_address               VARCHAR(50)     NOT NULL,
  cust_city                   VARCHAR(50)    NOT NULL,
  cust_state                  CHAR(2)        NOT NULL,
  cust_zip_code               VARCHAR(20)    NOT NULL,
  rewards_id      INT,       
CONSTRAINT    cust_rewards_fk    FOREIGN KEY(rewards_id)   REFERENCES rewards_program(rewards_id)


);

CREATE TABLE payment_method
(
  payment_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  cust_id        INT     NOT NULL,
  card_type                  CHAR(50)        NOT NULL,
  payment_total               DECIMAL(6,2)    NOT NULL,
CONSTRAINT    payment_method_cust_id_fk    FOREIGN KEY(cust_id)   REFERENCES customer(cust_id)
);

CREATE TABLE cafe_drink
(
  drink_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  drink_size        CHAR(50)     NOT NULL,
  drink_type                  CHAR(50)        NOT NULL,
  drink_price               DECIMAL(4,2)    NOT NULL
);

CREATE TABLE cafe_food
(
  food_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  food_type                  CHAR(50)        NOT NULL,
  food_price               DECIMAL(4,2)    NOT NULL
);

CREATE TABLE store_location
(
  store_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  store_address               VARCHAR(50)     NOT NULL,
  store_city                   VARCHAR(50)    NOT NULL,
  store_state                  CHAR(2)        NOT NULL,
  store_zip_code               VARCHAR(20)    NOT NULL
);

CREATE TABLE employee
(
  emp_id                     INT            PRIMARY KEY   AUTO_INCREMENT,
  emp_name                   VARCHAR(50)    NOT NULL      UNIQUE,
  emp_address               VARCHAR(50),
  vemp_city                   VARCHAR(50)    NOT NULL,
  emp_state                  CHAR(2)        NOT NULL,
  emp_zip_code               VARCHAR(20)    NOT NULL,
  store_id              INT,
  CONSTRAINT emp_store_fk
    FOREIGN KEY (store_id)    REFERENCES store_location (store_id)
);

CREATE TABLE ticket_order
(
  order_id                     INT            PRIMARY KEY   AUTO_INCREMENT,
  store_id                    INT    NOT NULL,
  cust_id        INT     NOT NULL,
  payment_id        INT     NOT NULL,
  drink_id        INT     NOT NULL,
  food_id        INT     NOT NULL,
  order_time               TIME    NOT NULL,
  CONSTRAINT ticket_order_store_id_fk
    FOREIGN KEY (store_id)
    REFERENCES store_location (store_id),
  CONSTRAINT ticket_order_cust_id_fk
    FOREIGN KEY (cust_id)
    REFERENCES customer (cust_id),
CONSTRAINT ticket_order_payment_id_fk
    FOREIGN KEY (payment_id)
    REFERENCES payment_method (payment_id),
CONSTRAINT ticket_order_drink_id_fk
    FOREIGN KEY (drink_id)
    REFERENCES cafe_drink (drink_id),
CONSTRAINT ticket_order_food_id_fk
    FOREIGN KEY (food_id)
    REFERENCES cafe_food (food_id)
);