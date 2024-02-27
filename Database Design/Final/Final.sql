-- 1.1
-- Import given bank data into PostgreSQL database.
DROP TABLE IF EXISTS bank_data; 
SET datestyle = 'MDY'; 
CREATE TABLE bank_data(
   id INTEGER,
   date DATE,
   asset INTEGER,
	liability INTEGER,
	idx INTEGER
);

COPY bank_data (id, date, asset, liability, idx) 
FROM 'C:\Users\Public\bank_data-1.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT * FROM bank_data;

-- 1.2
-- Create a primary key for the import table.
ALTER TABLE bank_data
ADD PRIMARY KEY (idx);

-- 1.3
-- Find the highest asset observation for each bank
-- Sort the resulting table according to asset value.
-- Report the first 10 observations of output table.
SELECT bd.id, bd.date, bank_max.max_asset AS asset, bd.liability
FROM bank_data bd
JOIN (
    SELECT id, MAX(asset) AS max_asset
    FROM bank_data
    GROUP BY id
) bank_max ON bd.id = bank_max.id AND bd.asset = bank_max.max_asset
ORDER BY bank_max.max_asset DESC
LIMIT 11;

-- 1.4
-- Show the query plan for question 1.3 using EXPLAIN tool
EXPLAIN
SELECT bd.id, bd.date, bank_max.max_asset AS asset, bd.liability
FROM bank_data bd
JOIN (
    SELECT id, MAX(asset) AS max_asset
    FROM bank_data
    GROUP BY id
) bank_max ON bd.id = bank_max.id AND bd.asset = bank_max.max_asset
ORDER BY bank_max.max_asset DESC
LIMIT 11;

-- 1.5
-- Given the highest asset table from question 1.3, count how many observations are there for
-- each quarter.
SELECT 
    EXTRACT(QUARTER FROM bd.date) AS quarter,
    COUNT(*) AS observation_count
FROM bank_data bd
JOIN (
    SELECT id, MAX(asset) AS max_asset
    FROM bank_data
    GROUP BY id
) bank_max ON bd.id = bank_max.id AND bd.asset = bank_max.max_asset
GROUP BY quarter
ORDER BY quarter;


-- 1.6
-- For the whole sample data, how many observations have asset value higher than 100,000 and
-- liability value smaller than 100,000.
SELECT COUNT(*) AS observation_count
FROM bank_data
WHERE asset > 100000 AND liability < 100000;

-- 1.7
-- Each observation was given an ’idx’ number. Find the average liability of observation with
-- odd ’idx’ number.
SELECT AVG(liability) AS average_liability_odd_idx
FROM bank_data
WHERE idx % 2 <> 0;

-- 1.8
-- Find the average liability of observation with even ’idx’ number. What’s the difference between
-- these two average number.
SELECT AVG(liability) AS average_liability_even_idx
FROM bank_data
WHERE idx % 2 = 0;

SELECT 
  (SELECT AVG(liability) FROM bank_data WHERE idx % 2 <> 0) - 
  (SELECT AVG(liability) FROM bank_data WHERE idx % 2 = 0) AS difference;
  
--1.9
-- For each bank find all records with increased asset
-- Report the first 10 observation of output table.
SELECT b1.id, b1.date, b1.asset
FROM bank_data b1
JOIN bank_data b2 ON b1.id = b2.id
AND EXTRACT(QUARTER FROM b1.date) = EXTRACT(QUARTER FROM b2.date) + 1
AND b1.asset > b2.asset
ORDER BY b1.id, b1.date
LIMIT 10;


-- 3.4
SELECT * FROM asset_growth_rates;


