--LAB 5 Abdulkadir Sonmezýsýk 152120201086

--1 'Surly' markasýnýn ürünler? arasýnda bulunan en yüksek ve en düþük model yýllarýný bulunuz.
SELECT MIN(model_year) miny , MAX(model_year) maxy
FROM production.products WHERE brand_id = (SELECT brand_id FROM production.brands WHERE brand_name = 'Surly');

--2 'Comfort B?cycles' kategor?s?ndek? ortalama ürün f?yatýný bulunuz. (left jo?n)
SELECT AVG(p.list_price) ortalama FROM production.products p
LEFT JOIN production.categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Comfort Bicycles'; 

--3 H?ç s?par?þ ed?lmem?þ ürünler?n ?s?mler?n? l?steleley?n?z. (r?ght jo?n) (20p)
SELECT p.product_name FROM sales.order_items oi
RIGHT JOIN production.products p ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;

--4 Hem satýlmamýþ hem de stokta olmayan ürünler?n l?stes?n? oluþturunuz. (full jo?n) (20p) 
SELECT p.product_name FROM production.products p
FULL JOIN production.stocks s ON p.product_id = s.product_id
LEFT JOIN sales.order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL AND s.product_id IS NULL;


--5 F?yatlarý ayný olan fakat farklý markalara a?t ürünler? l?steley?n?z. (self jo?n) (20p)
SELECT p1.product_name AS product1, p2.product_name AS product2
FROM production.products p1, production.products p2
WHERE p1.list_price = p2.list_price AND p1.product_id < p2.product_id AND p1.brand_id <> p2.brand_id;


--6 'Karl Stephens' adlý müþter?n?n tüm s?par?þler?ndek? toplam tutarý hesaplayýnýz. (10p)
SELECT c.first_name, c.last_name, SUM(oi.list_price * oi.quantity * (1 - oi.discount)) AS total_amount
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
JOIN sales.order_items oi ON o.order_id = oi.order_id
WHERE c.first_name = 'Karl' AND c.last_name = 'Stephens'
GROUP BY c.first_name, c.last_name;










