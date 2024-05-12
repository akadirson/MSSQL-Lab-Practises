--1 Her bir yöneticinin (manager) kimliði (staff_id), adý (first_name), soyadý (last_name) ve
--yönettiði çalýþanlarýn (staff) sayýsýný içeren sorguyu yazýnýz (25p).
SELECT m.staff_id, m.first_name, m.last_name, COUNT(s.staff_id) AS count
FROM sales.staffs s INNER JOIN sales.staffs m ON s.manager_id = m.staff_id
GROUP BY m.staff_id, m.first_name, m.last_name;


--2 Belirli bir maðazada (stores) stokta (stocks) bulunan ve stok miktarý (quantity) tam olarak
--26 olan tüm ürünlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ALL kullanarak yapýnýz!
SELECT product_name
FROM production.products
WHERE product_id = ALL (SELECT product_id
						FROM production.stocks
						WHERE quantity = 26);


--3) Belirli bir maðazada (stores) stokta (stocks) bulunan miktarý (quantity) 26’dan fazla olan
--ürünlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ANY kullanarak yapýnýz!
SELECT production.products.product_name
FROM production.products
WHERE EXISTS ( 
	SELECT 1
    FROM production.stocks
    WHERE stocks.product_id = products.product_id
    AND stocks.quantity > 26
    AND stocks.store_id = ANY (SELECT store_id FROM sales.stores)
);
--4 Stokta (Stocks) miktarý (quantity) tam olarak 30 olan ve ayný zamanda ürün (products) fiyatý
--(list_price) 3000’den düþük olan en az bir ürünün (products) bulunduðu maðazalarýn
--(stores) isimlerini (store_name) listeleyiniz (15p). EXISTS kullanarak yapýnýz!
SELECT DISTINCT s.store_name
FROM sales.stores s
WHERE EXISTS (
    SELECT 1
    FROM production.stocks stok
    INNER JOIN production.products p ON stok.product_id = p.product_id
    WHERE stok.store_id = s.store_id
    AND stok.quantity = 30
    AND p.list_price < 3000
);

--5) “Baldwin Bikes” adlý maðazadan (stores) alýþveriþ (orders) yapan her bir þehirdeki (city)
--müþteri (customers) sayýsýný hesaplayýnýz. Müþteri (customers) sayýsý 10’dan az olan
--þehirleri (city) seçiniz ve bu þehirleri (city) müþteri (customers) sayýsýna göre artan sýrayla
--listeleyiniz (15p). HAVING kullanarak yapýnýz!
SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY COUNT(c.customer_id) ASC;



--6) “Santa Cruz Bikes” adlý maðazadan (stores) sipariþ (orders) vermeyen müþterilerin
--(customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (15p). EXCEPT kullanarak yapýnýz!
SELECT first_name, last_name
FROM sales.customers
EXCEPT( SELECT c.first_name, c.last_name
        FROM sales.customers c
		INNER JOIN sales.orders o ON c.customer_id = o.customer_id
		INNER JOIN sales.stores s ON o.store_id = s.store_id
		WHERE s.store_name = 'Santa Cruz Bikes');