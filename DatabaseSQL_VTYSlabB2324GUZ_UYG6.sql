--1 Her bir y�neticinin (manager) kimli�i (staff_id), ad� (first_name), soyad� (last_name) ve
--y�netti�i �al��anlar�n (staff) say�s�n� i�eren sorguyu yaz�n�z (25p).
SELECT m.staff_id, m.first_name, m.last_name, COUNT(s.staff_id) AS count
FROM sales.staffs s INNER JOIN sales.staffs m ON s.manager_id = m.staff_id
GROUP BY m.staff_id, m.first_name, m.last_name;


--2 Belirli bir ma�azada (stores) stokta (stocks) bulunan ve stok miktar� (quantity) tam olarak
--26 olan t�m �r�nlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ALL kullanarak yap�n�z!
SELECT product_name
FROM production.products
WHERE product_id = ALL (SELECT product_id
						FROM production.stocks
						WHERE quantity�=�26);


--3) Belirli bir ma�azada (stores) stokta (stocks) bulunan miktar� (quantity) 26�dan fazla olan
--�r�nlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ANY kullanarak yap�n�z!
SELECT production.products.product_name
FROM production.products
WHERE EXISTS ( 
	SELECT 1
    FROM production.stocks
    WHERE stocks.product_id = products.product_id
    AND stocks.quantity > 26
    AND stocks.store_id = ANY (SELECT store_id FROM sales.stores)
);
--4 Stokta (Stocks) miktar� (quantity) tam olarak 30 olan ve ayn� zamanda �r�n (products) fiyat�
--(list_price) 3000�den d���k olan en az bir �r�n�n (products) bulundu�u ma�azalar�n
--(stores) isimlerini (store_name) listeleyiniz (15p). EXISTS kullanarak yap�n�z!
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

--5) �Baldwin Bikes� adl� ma�azadan (stores) al��veri� (orders) yapan her bir �ehirdeki (city)
--m��teri (customers) say�s�n� hesaplay�n�z. M��teri (customers) say�s� 10�dan az olan
--�ehirleri (city) se�iniz ve bu �ehirleri (city) m��teri (customers) say�s�na g�re artan s�rayla
--listeleyiniz (15p). HAVING kullanarak yap�n�z!
SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM sales.customers c
INNER JOIN sales.orders o ON c.customer_id = o.customer_id
INNER JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY COUNT(c.customer_id) ASC;



--6) �Santa Cruz Bikes� adl� ma�azadan (stores) sipari� (orders) vermeyen m��terilerin
--(customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (15p). EXCEPT kullanarak yap�n�z!
SELECT first_name, last_name
FROM sales.customers
EXCEPT( SELECT c.first_name, c.last_name
        FROM sales.customers c
		INNER JOIN sales.orders o ON c.customer_id = o.customer_id
		INNER JOIN sales.stores s ON o.store_id = s.store_id
		WHERE s.store_name = 'Santa Cruz Bikes');