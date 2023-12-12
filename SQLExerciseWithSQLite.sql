-- Chinook DATABASE

--Exercise 1

-- Q.1 What is the title of the album with AlbumId 67? 
-- solution

select Title 
from album 
where AlbumId = 67 ; 


--  Q.2 Find the name and length (in seconds) of all tracks that have length between 50 and 70 seconds. 
-- solution
SELECT  name  ,
		Milliseconds/1000 as Length_in_seconds 
from Track  ; 


--  Q.3 List all the albums by artists with the word ‘black’ in their name. 
-- solution

SELECT  ab.Title  ,
		ar.name from Album as ab
join Artist as ar 
on ab.ArtistId = ar.ArtistId
where ar.name like "%black%" ; 

 
--   Q.4 Provide a query showing a unique/distinct list of billing countries from the Invoice table 
-- solution

select DISTINCT BillingCountry from Invoice ; 


 --    Q.5 Display the city with highest sum total invoice. 
 -- solution
 
SELECT  BillingCity ,
		sum(total) from Invoice
GROUP BY BillingCity
ORDER  BY sum(total) DESC
limit 1  ; 
 
--   Q.6 Produce a table that lists each country and the number of customers in that country. (You only need to include countries
--  that have customers) in descending order. (Highest count at the top) 
-- solution

SELECT  Country , 
		Count(CustomerId) as TotalCustomers 
from Customer
GROUP BY Country
ORDER BY count(CustomerId) DESC ; 


--  Q.7 Find the top five customers in terms of sales i.e. find the five customers whose total combined invoice amounts
--  are the highest. Give their name, CustomerId and total invoice amount. Use join 
-- solution

SELECT  c.CustomerId ,
		c.FirstName , 
		c.LastName , 
		sum(i.total) 
from Invoice as i 
join Customer as c 
	on c.CustomerId = i.CustomerId
GROUP BY i.BillingCity
ORDER  BY sum(i.total) DESC
limit 5 ; 


--  Q.8 Find out state wise count of customerID and list the names of states with count of 
-- customerID in decreasing order. Note:- do not include where states is null value. 
-- solution

select  State , 
		count(CustomerId) as Total_customers 
from Customer
where state IS NOT NULL
group by State
order by Total_Customers desc ; 


-- Q.9 How many Invoices were there in 2009 and 2011? 
-- solution

SELECT count(InvoiceId) 
from Invoice
where InvoiceDate LIKE "2009%" or InvoiceDate LIKE "2011%" ; 
  
--  Q.10 Provide a query showing only the Employees who are Sales Agents. 
-- solution

select * from Employee
where Title = "Sales Support Agent" ; 


--Exercise 2


 -- Q.1 Display Most used media types: their names and count in descending order. 
 -- solution
 
SELECT  mt.name ,
		count(t.MediaTypeId) as Total_Used  
from MediaType as mt
join Track as t 
on mt.MediaTypeId = t.MediaTypeId
group by mt.MediaTypeId
order by Total_Used desc  ; 



--  Q.2 Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the
--  customer's full name, Invoice ID, Date of the invoice and billing country. 
-- solution

select c.FirstName , 
		c.LastName , 
		i.InvoiceDate , 
		i.InvoiceId  , 
		BillingCountry 
from customer as c 
join invoice as i 
	on c.CustomerId = i.CustomerId
where c.Country = "Brazil" ; 


-- 3 Q.3 Display artist name and total track count of the top 10 rock bands from dataset. 
-- solution

select ar.Name , count (t.TrackId) as Total_tracks from Artist as ar 
join album as ab 
on ar.ArtistId = ab.ArtistId
join track as t 
on ab.AlbumId = t.AlbumId 
group by ar.Name
order by Total_tracks desc
limit 10  ; 


 -- 4 Q.4 Display the Best customer (in case of amount spent). Full name (first name and last name) 
 -- solution
 
select c.FirstName ||" " || c.LastName  as Full_Name, sum(i.total) as Total_spent from Customer as c 
join Invoice as i 
group by i.CustomerId 
order by Total_spent desc 
limit 1  ; 

 -- Q.5 Provide a query showing Customers (just their full names, customer ID and country) who are not in the US. 
-- solution

SELECT CustomerId ,
		FirstName ||" "|| LastName as FullName  , 
		Country from Customer
where Country !="US"  ; 
 

 
 -- Q.6 Provide a query that shows the total number of tracks in each playlist in descending order. The Playlist name should be included on the resultant table. 
 -- solution
 
 select p.Name  , count(pt.TrackId) as Total_tracks from Playlist as p 
 join PlaylistTrack as pt 
 on pt.PlaylistId = p.PlaylistId
 group by pt.PlaylistId 
 order by Total_tracks desc  ; 
 
 
 -- 7  Q.7 Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre. 
 -- solution
 
SELECT
    a.Title , mt.Name ,g.Name FROM Track t
JOIN Album a 
ON a.AlbumId = t.AlbumId
JOIN MediaType mt 
ON mt.MediaTypeId = t.MediaTypeId
JOIN Genre g 
ON g.GenreId = t.GenreId ;

-- Q.8 Provide a query that shows the top 10 bestselling artists. (In terms of earning). 
-- solution

select art.Name as Artist_name ,
		count(InvoiceLineId) as Artist_Total_sales
from invoiceLine as i
    join track as t on i.TrackId = t.TrackId
    join album as a on a.AlbumId= t.AlbumId
    join artist as art on art.ArtistId= a.ArtistId
group by art.ArtistId
order by Artist_Total_sales desc 
limit 10 ;


-- 9 Q.9 Provide a query that shows the most purchased Media Type. 
-- solution

SELECT  MediaType.Name AS MostPurchasedMediaType 
from MediaType
join Track 
	on track.MediaTypeId = MediaType.MediaTypeId 
join InvoiceLine 
	on track.TrackId = InvoiceLine.TrackId
ORDER BY (InvoiceLine.Quantity * InvoiceLine.UnitPrice) desc 
limit 1 ; 


  --- 10 Q.10 Provide a query that shows the purchased tracks of 2013. Display Track name and Units sold.
  -- solution
  
SELECT track.Name , 
		InvoiceLine.Quantity as Units_sold
from Track
join InvoiceLine 
	on InvoiceLine.TrackId = Track.TrackId
join Invoice 
	on invoice.InvoiceId = InvoiceLine.InvoiceId
where Invoice.InvoiceDate = "2013%" ; 
  

