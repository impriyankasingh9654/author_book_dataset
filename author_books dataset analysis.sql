create table books(
Book_ID serial primary key,
Title varchar(50),
Author varchar(50),
Genre varchar(20),
Published_Year int,
Price numeric(10,2),
Stock int
);
select * from books

create table bookorders(
Order_ID serial primary key not null,
Customer_ID int ,
Book_ID	int,
Order_Date date,
Quantity int,
Total_Amount numeric (10,2)
);

select * from bookorders

drop table if exists customers;
create table customers (
Customer_ID serial primary key,
Name varchar(30),
Email varchar(100),
Phone varchar(20),
City varchar(20),
Country varchar(150)
);
select * from customers
 alter table customers
 alter column country type varchar (150);

 ------------------Basic Quaries---------------------------

 -- retrieve all books in the "fiction" genre:
 
 select * from books
 where genre ='Fiction';
 
-- find books published after 1950?
select * from books
where published_year>1950;
-- list all the customers from canada?

select * from customers
where country= 'Canada'; 

-- show order placed in novembwer 2023;
select * from bookorders
where Order_Date between '2023-11-01' and '2023-11-30';

-- retrieve the total stocks of books available?
select sum(stock)as total_stock
from books;

-- find the details of most expensive books?
select * from books
order by Price desc;

-- show all customers who ordered more than 1 quantity of book?
select * from bookorders
where Quantity>7;

-- retrieve all orders where the total amount exceeds $20;

select sum(total_amount) as total_amount
from bookorders
where total_amount>20;

--list all genra available in the book table?
select distinct genre from books
 
-- find the book with low stocks avilable
select * 
from books
order by stock asc
limit 3 ;

--------------- Advance Quaries----------------------
-- calculated the total revenue generated from all orders?
select sum(total_amount) as revenue 
from oders;

--retrieve the total numbers in books sold for each genra?
select b.Genre,
sum(bookorders.Quantity) as total_book_sold,
from bookorders o
join books b
on b.Book_id= bookorders.book_id ;  
group by b.genre
   
SELECT b.Genre, sum(o.Quantity) as total_book_sold
FROM bookorders o
JOIN books b
ON b.Book_id = o.Book_id
group by b.genre;

--find the average price of books in the "fantasy"genre?
select avg(price) as avg_price
from books
where genre = 'fantasy';

-- list customers who have placed at least 2 orders?

SELECT o.Customer_Id,c.name, COUNT(o.order_id) AS order_count
FROM bookorders o
join customers c
on o.customer_id =c.customer_id
GROUP BY o.customer_id, c. name
HAVING COUNT(order_id) >= 2;

-- find the most frequently ordered booked?
select book_id ,count(order_id) as order_count
from bookorders
group by book_id
order by order_count desc
limit 1;

-- show the top 3 most expensive books of 'fantasy' genre?
select * from books
where genre = 'Fantasy'
order by price desc
limit 3;

-- retrieve the total quantity of books sold by each author?
select b.Author,sum(o.quantity) as total_book_sold
from bookorders o
join books b
on b.book_id=o.book_id
group by b.Author;

--calculating the stocks remaining after fulfilling all orders?
select b.book_id ,b.title ,b.stock ,coalesce(sum(quantity),0) as order_quantity,
b.stock - coalesce(sum(quantity),0) as remaining_stock
from books b
left join bookorders o
on o.book_id=b.book_id
group by b.book_id
order by b.book_id;


