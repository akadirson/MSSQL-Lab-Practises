--soru 1 -Ürünler tablosundan model yýlý 2016 olan tüm ürünlerin adýný, marka kimliðini ve liste fiyatýný
--listelemek için bir SELECT sorgusu yazýnýz.
Select product_name, brand_id, list_price from production.products where model_year = 2016

--soru 2 Ürünler tablosundaki kategorisi 6 olan tüm benzersiz marka numaralarýný listeleyiniz

SELECT distinct brand_id from production.products where category_id = 6

--soru 3 Þipariþler tablosunda, sipariþ durumu 'Tamamlanmýþ' (4) olan veya 'Reddedilmiþ' (3) olan
--sipariþlerin sipariþ numarasýný, müþteri kimliðini ve sipariþ durumunu listeleyiniz.
SELECT order_id, customer_id, order_status from sales.orders where order_status= 4 or order_status= 3

--soru 4 -Maðazalar tablosuna yeni bir maðaza ekleyin. Maðaza adý 'New Store', e-posta adresi
--'newstore@email.com' ancak telefon numarasý ve adres bilgileri olmadan.

INSERT INTO sales.stores (store_name, email) values ('New Store', 'newstore@email.com')

--soru 5
--a  Ürünler tablosunda, ürün adý 'NewProductName' olan ve model yýlý 2016 olan ürünün liste
--fiyatýný '3500' olarak güncelleyiniz.
Update production.products SET list_price = 3500  where  product_name = 'NewProductName' and model_year = 2016
--b Maðazalar tablosuna yeni eklenen maðazayý siliniz. Maðaza adý 'New Store', e-posta adresi
--'newstore@email.com', sonra ürün listesini SELECT sorgusu ile çekiniz.
DELETE from sales.stores where product_name = 'NewProductName' and model_year = 2016
SELECT * from sales.stores where product_name = 'NewProductName' and model_year = 2016