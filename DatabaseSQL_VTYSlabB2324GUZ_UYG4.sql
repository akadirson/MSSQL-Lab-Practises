--1) �r�nler(products) tablosundaki yer alan �r�nlerden en d���k �r�n fiyat�n� ve en y�ksek
--�r�n fiyat�n� ekrana listeleyiniz (10p).
Select min(list_price) from production.products ;
Select max(list_price) from production.products ;

--2) �r�nler(products) tablosundaki yer alan �r�nlerin toplam say�s�n�, toplam fiyat�n� ve
--ortalama fiyat�n� ekrana listeleyiniz (10p).
SELECT COUNT(product_id) [Toplam Urun Sayisi],
SUM(list_price) [Toplam Fiyat], 
AVG(list_price) [Ortalama Fiyat] 
from production.products ;

--3) 'Baldwin Bikes' ma�azas�ndan(stores) sipari�(orders) alan 5 adet �al��an(staffs) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazd�r�n�z (20p).
Select top(5) first_name, last_name from sales.staffs C
Inner join sales.orders O on O.staff_id = C.staff_id 
Inner join sales.stores St on St.store_id = O.store_id where ST.store_name = 'Baldwin Bikes'

--4) Ad�n�n son harfi S ve soyad�n�n ���nc� harfi A olan t�m m��terileri(customers) listeleyiniz.
--Ad ve soyad bilgilerini ekrana yazd�r�n�z (20p).
Select first_name, last_name from sales.customers where first_name LIKE '%S' and last_name LIKE '__A%'

--5) Model y�l� 2015 ve 2017 dahil olmak �zere bu y�llar aras�ndaki �r�nleri(products) sipari�
--alm�� (order_items & orders) �al��anlar�(customers) listeleyiniz. Ad ve soyad bilgilerini
--e�siz olarak ekrana yazd�r�n�z (20p). Bu soruyu ger�ekle�tirirken BETWEEN kullan�n�z.
Select distinct first_name, last_name from sales.staffs S 
Inner join sales.orders O on S.staff_id = O.staff_id
Inner join sales.order_items OI on OI.order_id = O.order_id
Inner join  production.products P on P.product_id = OI.product_id
where P.model_year between 2015 and 2017

--6) 'Rowlett Bikes' ve 'Baldwin Bikes' ma�azalar�ndan(stores) sipari�(orders) alan 10 adet
--�al��an�(staffs) listeleyiniz. Ad ve soyad bilgilerini ekrana listeleyiniz (20p). Ad ve soyad
--bilgilerini ekrana yazd�r�n�z. Bu soruyu ger�ekle�tirirken IN kullan�n�z.
Select distinct top(10) first_name, last_name from sales.staffs Staff
Inner join sales.orders O on Staff.staff_id = O.staff_id
Inner join sales.stores Store on Store.store_id = O.store_id
where store_name IN('Rowlett Bikes','Baldwin Bikes')


