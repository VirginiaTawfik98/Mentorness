USE [hotel ]
GO

SELECT [Booking_ID]
      ,[no_of_adults]
      ,[no_of_children]
      ,[no_of_weekend_nights]
      ,[no_of_week_nights]
      ,[type_of_meal_plan]
      ,[room_type_reserved]
      ,[lead_time]
      ,[arrival_date]
      ,[market_segment_type]
      ,[avg_price_per_room]
      ,[booking_status]
  FROM [dbo].['Hotel Reservation Dataset$']

GO


alter table [dbo].['Hotel Reservation Dataset$'] alter column [booking_id] varchar(10) not null
go
alter table [dbo].['Hotel Reservation Dataset$'] alter column [no_of_adults] tinyint null
alter table [dbo].['Hotel Reservation Dataset$'] alter column [no_of_children] tinyint
alter table [dbo].['Hotel Reservation Dataset$'] alter column [no_of_weekend_nights] tinyint
alter table [dbo].['Hotel Reservation Dataset$'] alter column [no_of_week_nights] tinyint
alter table [dbo].['Hotel Reservation Dataset$'] alter column[type_of_meal_plan] varchar(20)
alter table [dbo].['Hotel Reservation Dataset$'] alter column [room_type_reserved] varchar(20)
alter table [dbo].['Hotel Reservation Dataset$'] alter column [lead_time] smallint
alter table [dbo].['Hotel Reservation Dataset$']alter column[arrival_date] date
alter table [dbo].['Hotel Reservation Dataset$'] alter column[market_segment_type] varchar(20)
alter table [dbo].['Hotel Reservation Dataset$'] alter column[avg_price_per_room] smallmoney
alter table [dbo].['Hotel Reservation Dataset$'] alter column[booking_status] varchar(20)
go
ALTER TABLE [dbo].['Hotel Reservation Dataset$'] ADD PRIMARY KEY (Booking_ID)
go

--counting the total number of reservations in the dataset
SELECT COUNT(Booking_ID) FROM [dbo].['Hotel Reservation Dataset$']
go

--calculating mode of types of meals
SELECT COUNT(type_of_meal_plan),
(type_of_meal_plan)
FROM [dbo].['Hotel Reservation Dataset$']
GROUP BY [type_of_meal_plan]
ORDER BY COUNT(type_of_meal_plan) DESC;
go
   

 --average price per room for reservations involving children
select(no_of_children),(avg_price_per_room)from [dbo].['Hotel Reservation Dataset$']
go

SELECT AVG(avg_price_per_room) as avg_price_per_room_with_children
FROM [dbo].['Hotel Reservation Dataset$']
where (no_of_children) > 0
go

--calc # of reservations for each year (2017/2018)
select count (arrival_date) from [dbo].['Hotel Reservation Dataset$']
where (arrival_date) like '2017%' 
go

select  count (arrival_date) from [dbo].['Hotel Reservation Dataset$'] 
where (arrival_date) like '2018%' 
go

--calculating mode of booked room types
SELECT COUNT(room_type_reserved),
(room_type_reserved)
FROM [dbo].['Hotel Reservation Dataset$']
GROUP BY [room_type_reserved]
ORDER BY COUNT(room_type_reserved) DESC;
go

--How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select count (no_of_weekend_nights) from [dbo].['Hotel Reservation Dataset$']
where (no_of_weekend_nights) > 0 
go


--What is the highest and lowest lead time for reservations?
select min(lead_time) from [dbo].['Hotel Reservation Dataset$']
go
select max(lead_time) from [dbo].['Hotel Reservation Dataset$']
go

--What is the most common market segment type for reservations?
SELECT COUNT(market_segment_type),
(market_segment_type)
FROM [dbo].['Hotel Reservation Dataset$']
GROUP BY [market_segment_type]
ORDER BY COUNT(market_segment_type) DESC;
go


--How many reservations have a booking status of "Confirmed"?
select count(booking_id) from [dbo].['Hotel Reservation Dataset$']
where (booking_status) = 'Not_Canceled'
go

--What is the total number of adults and children across all reservations?
select sum(no_of_adults) as total_adults,
sum(no_of_children) as total_children
from [dbo].['Hotel Reservation Dataset$']
go

-- average number of weekend nights for reservations involving children?
select avg (no_of_weekend_nights) from [dbo].['Hotel Reservation Dataset$']
where(no_of_weekend_nights) > 0 and (no_of_children) > 0 
go

--calac reservations made in each month of the year? 
 select 
 month (arrival_date) as 'month_nr' , count (*) as nr_of_res_per_month 
 from [dbo].['Hotel Reservation Dataset$'] 
 group by month (arrival_date)
 order by (month_nr)


 --avg # of nights (both weekend and weekday) spent by guests for each room type?

 select (room_type_reserved),avg ((no_of_weekend_nights) + (no_of_week_nights)) as avg_of_nights
 from [dbo].['Hotel Reservation Dataset$']
 group by (room_type_reserved)


 --For reservations involving children,
 --most common room type and average price for that room type?
 
 select COUNT(room_type_reserved),
(room_type_reserved),
avg (avg_price_per_room)
FROM [dbo].['Hotel Reservation Dataset$']

where(no_of_children) >0 
GROUP BY (room_type_reserved)
ORDER BY COUNT(room_type_reserved) DESC;
go


--Find the market segment type that generates the highest average price per room.
select
(market_segment_type),avg(avg_price_per_room) as avg_price
From [dbo].['Hotel Reservation Dataset$']
group by (market_segment_type)
order by avg_price 
go

