--1) Ürünler(products) tablosundaki yer alan ürünlerden en düþük ürün fiyatýný ve en yüksek
--ürün fiyatýný ekrana listeleyiniz (10p).
Select min(list_price) from production.products ;
Select max(list_price) from production.products ;

--2) Ürünler(products) tablosundaki yer alan ürünlerin toplam sayýsýný, toplam fiyatýný ve
--ortalama fiyatýný ekrana listeleyiniz (10p).
SELECT COUNT(product_id) [Toplam Urun Sayisi],
SUM(list_price) [Toplam Fiyat], 
AVG(list_price) [Ortalama Fiyat] 
from production.products ;

--3) 'Baldwin Bikes' maðazasýndan(stores) sipariþ(orders) alan 5 adet çalýþan(staffs) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazdýrýnýz (20p).
Select top(5) first_name, last_name from sales.staffs C
Inner join sales.orders O on O.staff_id = C.staff_id 
Inner join sales.stores St on St.store_id = O.store_id where ST.store_name = 'Baldwin Bikes'

--4) Adýnýn son harfi S ve soyadýnýn üçüncü harfi A olan tüm müþterileri(customers) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazdýrýnýz (20p).
Select first_name, last_name from sales.customers where first_name LIKE '%S' and last_name LIKE '__A%'

--5) Model yýlý 2015 ve 2017 dahil olmak üzere bu yýllar arasýndaki ürünleri(products) sipariþ
--almýþ (order_items & orders) çalýþanlarý(customers) listeleyiniz. Ad ve soyad bilgilerini
--eþsiz olarak ekrana yazdýrýnýz (20p). Bu soruyu gerçekleþtirirken BETWEEN kullanýnýz.
Select distinct first_name, last_name from sales.staffs S 
Inner join sales.orders O on S.staff_id = O.staff_id
Inner join sales.order_items OI on OI.order_id = O.order_id
Inner join  production.products P on P.product_id = OI.product_id
where P.model_year between 2015 and 2017

--6) 'Rowlett Bikes' ve 'Baldwin Bikes' maðazalarýndan(stores) sipariþ(orders) alan 10 adet
--çalýþaný(staffs) listeleyiniz. Ad ve soyad bilgilerini ekrana listeleyiniz (20p). Ad ve soyad
--bilgilerini ekrana yazdýrýnýz. Bu soruyu gerçekleþtirirken IN kullanýnýz.
Select distinct top(10) first_name, last_name from sales.staffs Staff
Inner join sales.orders O on Staff.staff_id = O.staff_id
Inner join sales.stores Store on Store.store_id = O.store_id
where store_name IN('Rowlett Bikes','Baldwin Bikes')


