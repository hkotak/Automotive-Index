-- Create a new postgres user named `indexed_cars_user`
CREATE USER indexed_cars_user;

-- Create a new database named `indexed_cars` owned by `indexed_cars_user`
CREATE DATABASE indexed_cars WITH OWNER = indexed_cars_user;

-- Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
    -- **Created the table from car_models.sql** --  
-- Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times** _there should be **223380** rows in `car_models`_
    -- **Inserted the data from car_model_data.sql 10 times into the table to make 223380 rows** -- 

-- ## Timing Select Statements
-- Run a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
    -- 25ms
SELECT make_title FROM car_models WHERE make_code = 'LAM';
-- Run a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
    -- 22ms
SELECT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R';
-- Run a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
    -- 26ms
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';
-- Run a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
    -- 268ms
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015;
-- Run a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
    -- 64ms
SELECT * FROM car_models WHERE year = 2010;

-- ## Indexing
-- Given the current query requirements, "should get all make_titles", "should get a list of all model_titles by the make_code", etc.  
-- Create indexes on the columns that would improve query performance.

-- To add an index:

-- ```
-- CREATE INDEX [index name]
--   ON [table name] ([column name(s) index]);
-- ```

-- Record your index statements in `indexing.sql`

-- Write the following statements in `indexing.sql`

-- Create a query to get a list of all `make_title` values from the `car_models` table where the `make_code` is `'LAM'`, without any duplicate rows, and note the time somewhere. (should have 1 result)
    -- 7ms
CREATE INDEX lambo ON car_models (make_code);
SELECT make_title FROM car_models WHERE make_code = 'LAM';

-- Create a query to list all `model_title` values where the `make_code` is `'NISSAN'`, and the `model_code` is `'GT-R'` without any duplicate rows, and note the time somewhere. (should have 1 result)
    -- 3ms
CREATE INDEX godzilla ON car_models (model_code);
SELECT model_title FROM car_models WHERE make_code = 'NISSAN' AND model_code = 'GT-R';

-- Create a query to list all `make_code`, `model_code`, `model_title`, and year from `car_models` where the `make_code` is `'LAM'`, and note the time somewhere. (should have 1360 rows)
    -- 9ms
CREATE INDEX multi_lam ON car_models (make_code, model_code, model_title, year);
SELECT make_code, model_code, model_title, year FROM car_models WHERE make_code = 'LAM';

-- Create a query to list all fields from all `car_models` in years between `2010` and `2015`, and note the time somewhere (should have 78840 rows)
    -- 291ms
CREATE INDEX years ON car_models (year);
SELECT * FROM car_models WHERE year BETWEEN 2010 AND 2015;

-- Create a query to list all fields from all `car_models` in the year of `2010`, and note the time somewhere (should have 13140 rows)
    -- 52ms
SELECT * FROM car_models WHERE year = 2010;
-- Compare the times of the queries before and after the table has been indexes.  

-- Why are queries #4 and #5 not running faster?

-- ## Indexing on table create

-- 1. Add your recorded indexing statements to the `scripts/car_models.sql`
-- 1. Delete the `car_models` table
-- 1. Run the provided `scripts/car_models.sql` script on the `indexed_cars` database
-- 1. Run the provided `scripts/car_model_data.sql` script on the `indexed_cars` database **10 times**  
--    _there should be **223380** rows in `car_models`_
