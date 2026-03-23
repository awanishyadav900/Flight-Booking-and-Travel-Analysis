
---- Creating table Booking.
drop table if exists booking;
create table booking(
Booking_ID varchar(50) primary key,
Ticket_Price float,
Distance_km float,
Flight_Duration_hr float,
Passenger_Age int,
Airline varchar(50),
Travel_Class varchar(50),
Departure_City varchar(50),
Payment_Method varchar(50)
);

--- inserting dataset
select * from booking;

---SQL Questions – Flight Booking Analysis

-- 1. Retrieve all records from the flight bookings table.
    select * from booking;
 
-- 2. Select all bookings where the ticket price is greater than 3000.
    select * from booking where ticket_price > 3000
 
-- 3. Find all bookings made using 'Credit Card'.
    select * from booking where payment_method ='Credit Card';
	
-- 4. Display booking IDs and ticket prices sorted in descending order.
     select booking_id, ticket_price from booking 
	   order by booking_id desc, ticket_price desc;
---

-- ## Aggregate Functions

-- 5. Find the total number of bookings.
    select count(distinct booking_id) as total_booking from booking;
	
-- 6. Calculate the average ticket price.
     select avg(ticket_price) as avg_price from booking;
	 
-- 7. Find the minimum and maximum ticket price.
   select min(ticket_price)as minimum_price,
          max(ticket_price)as maximum_price from booking;

-- 8. Count how many bookings were made from each departure city.
      select departure_city, count(booking_id) as total_booking from booking group by(departure_city);
	  
--- ##  Group By & Filtering

-- 9. Find the average ticket price for each departure city.
   select departure_city, avg(ticket_price)as avg_price from booking group by(departure_city); 
 
-- 10. List cities having more than 20 bookings.
    select departure_city, count(booking_id) as total_booking from booking group by (departure_city)
	having count(booking_id) > 20;

-- 11. Find the total revenue generated from each city.
     select departure_city,sum(ticket_price)as total_revenue from booking group by(departure_city);

--- ##  Intermediate Queries

-- 12. Find the top 5 most expensive bookings.
       select *,ticket_price from booking order by ticket_price desc limit 5;

-- 13. Retrieve bookings where ticket price is above the average ticket price.
      select booking_id,ticket_price,avg_price,airline,travel_class,departure_city from  
	  ( select *,avg(ticket_price) over(order by booking_id asc) as avg_price from booking)
	   where ticket_price > avg_price;

-- 14. Find the most frequently used payment method.
     select payment_method, count(*) as most_payment from booking group by(payment_method)
	 order by most_payment desc limit 1;
 

-- ##  Advanced Queries

-- 15. Rank bookings based on ticket price (highest to lowest).
      select ticket_price, rank() over(order by ticket_price desc) as rnk from booking;

---16. Find the percentage of bookings for each payment method.
SELECT 
    payment_method,
    COUNT(*) AS to_bookings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM booking), 2) AS percentage
    FROM booking
    GROUP BY payment_method
    ORDER BY percentage DESC;
	
-- 17. Identify the city contributing the highest revenue.
   select departure_city, sum(ticket_price)as total_revenue
   from booking group by(departure_city) order by sum(ticket_price) desc limit 1;
   
-- 18. Create a query to segment customers into price categories.
 
   select 
   booking_id,
   ticket_price,
   case 
      when ticket_price < 1500 then 'Budget'
	  when ticket_price between 1500 and 3500 then 'Mid-range'
	  else 'Premium'
	   end as price_category 
	   from booking;
   
