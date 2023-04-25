-- Select everything from sales table

select * from sales;

-- Show just a few columns from sales table

select SaleDate, Amount, Customers from sales;
select Amount, Customers, GeoID from sales;

-- Adding a calculated column with SQL

Select SaleDate, Amount, Boxes, Amount / boxes  from sales;

-- Naming a field with AS in SQL

Select SaleDate, Amount, Boxes, Amount / boxes as 'Amount per box'  from sales;

-- Using WHERE Clause in SQL

select * from sales
where amount > 10000;

-- Showing sales data where amount is greater than 10,000 by descending order
select * from sales
where amount > 10000
order by amount desc;

-- Showing sales data where geography is g1 by product ID &
-- descending order of amounts

select * from sales
where geoid='g1'
order by PID, Amount desc;

-- Working with dates in SQL

Select * from sales
where amount > 10000 and SaleDate >= '2022-01-01';

-- Using year() function to select all data in a specific year

select SaleDate, Amount from sales
where amount > 10000 and year(SaleDate) = 2022
order by amount desc;

-- BETWEEN condition in SQL with < & > operators

select * from sales
where boxes >0 and boxes <=50;

-- Using the between operator in SQL

select * from sales
where boxes between 0 and 50;

-- Using weekday() function in SQL

select SaleDate, Amount, Boxes, weekday(SaleDate) as 'Day of week'
from sales
where weekday(SaleDate) = 4;

-- Working with People table

select * from people;

-- OR operator in SQL

select * from people
where team = 'Delish' or team = 'Jucies';

-- IN operator in SQL

select * from people
where team in ('Delish','Jucies');

-- LIKE operator in SQL

select * from people
where salesperson like 'B%';

select * from people
where salesperson like '%B%';

select * from sales;

-- Using CASE to create branching logic in SQL

select 	SaleDate, Amount,
		case 	when amount < 1000 then 'Under 1k'
				when amount < 5000 then 'Under 5k'
                when amount < 10000 then 'Under 10k'
			else '10k or more'
		end as 'Amount category'
from sales;

-- GROUP BY in SQL

select team, count(*) from people
group by team


-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100

select * from sales
where Amount > 2000 and Boxes <100;


-- How many shipments (sales) each of the sales persons had in the month of January 2022

select Salesperson,count(*) as count_sales
from sales
join people
on people.SPID = sales.SPID
where SaleDate between '2022-1-1' and '2022-1-31'
group by Salesperson;


-- Which product sells more boxes? Milk Bars or Eclairs?

select Product,sum(Boxes) as Total_box_quantity
from sales
join products
on sales.PID = products.PID
where products.Product in ('Milk Bars' ,'Eclairs')
group by Product
order by Total_box_quantity desc
limit 1;


--  Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs?

select products.Product,sum(sales.Boxes) as Total_box_quantity
from sales
join products
on sales.PID = products.PID
where products.Product in ('Milk Bars' ,'Eclairs') and SaleDate between '2022-2-1' and '2022-2-7'
group by Product
order by Total_box_quantity desc
limit 1;


-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?

select SPID,Customers,Boxes,
      case 
          when weekday(saledate)=2 then 'Wednesday Shipment'
	      else ''
      end as 'W Shipment'
from sales
where customers < 100 and boxes < 100 and weekday(SaleDate) = 2;


-- What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

select distinct p.Salesperson
from sales s
join people p on p.spid = s.SPID
where s.SaleDate between '2022-01-01' and '2022-01-07';

-- Which salespersons did not make any shipments in the first 7 days of January 2022?
select salesperson
from people
where spid not in(
select spid from sales where SaleDate between '2022-01-01' and '2022-01-07' );


-- How many times we shipped more than 1,000 boxes in each month?

select monthname(SaleDate)as month_name,count(*) as sales_count
 from sales
 where Boxes > 1000
 group by month_name;

-- Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?

 set @product_name = 'After Nines';
set @country_name = 'New Zealand';

select year(saledate) 'Year', month(saledate) 'Month',
if(sum(boxes)>1, 'Yes','No') 'Status'
from sales s
join products pr on pr.PID = s.PID
join geo g on g.GeoID=s.GeoID
where pr.Product = @product_name and g.Geo = @country_name
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);
 
 
 -- India or Australia? Who buys more chocolate boxes on a monthly basis?


 
 select year(saledate) 'Year', month(saledate) 'Month',
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) 'India Boxes',
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) 'Australia Boxes'
from sales s
join geo g on g.GeoID=s.GeoID
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);
 
 
 
 
 
 
 
 
 
 
 



















