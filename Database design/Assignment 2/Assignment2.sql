
-- Question 1
DROP TABLE IF EXISTS world;
CREATE TABLE 
IF NOT EXISTS world (name VARCHAR,
					 continent VARCHAR, area BIGINT, 
					 population BIGINT,gdp BIGINT);
ALTER TABLE world 
ADD CONSTRAINT PK_world PRIMARY KEY (name); 

INSERT INTO world
VALUES ('Afghanistan','Asia',652230,25500100,20343000000),
	   ('Albania','Europe',28748,2831741,12960000000),
	   ('Algeria','Africa',2381741,37100000,188681000000),
	   ('Andorra','Europe',468,78115,3712000000),
	   ('Angola','Africa',1246700,20609294,100990000000);

SELECT *
FROM world;

SELECT name, population, area 
FROM world
WHERE area > 3000000 
OR population > 25000000;

-- Question 2
DROP TABLE IF EXISTS products;
CREATE TYPE fats AS ENUM('Y', 'N');
CREATE TYPE rec AS ENUM('Y', 'N');
CREATE TABLE 
IF NOT EXISTS products (
    product_id int,
    low_fats fats,
    recyclable rec);

ALTER TABLE products 
ADD CONSTRAINT PK_products PRIMARY KEY (product_id);

INSERT INTO products
VALUES (0,'Y','N'),
	   (1,'Y','Y'),
	   (2,'N','Y'),
	   (3,'Y','Y'),
	   (4,'N','N');
	   
SELECT *
FROM products;

SELECT product_id 
FROM products
WHERE low_fats='Y' 
AND recyclable='Y';
