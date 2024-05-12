-- Soru 1: Belirli bir eyaletteki t�m m��terilerin e-posta adreslerini listeleyen bir sakl� yordam yaz�n. Yordam, eyalet ad�n� parametre olarak almal�d�r. Exec komutu ile yordam� �a��r�n�z. (15p)
CREATE PROCEDURE ListCustomersByEmailByState3
    @state VARCHAR(25)
AS
BEGIN
    SELECT
        email
    FROM
        sales.customers
    WHERE
        state = @state;
END;


EXEC ListCustomersByEmailByState3 @state = 'CA';


-- Soru 2: �nceki sakl� yordam� g�ncelleyerek; Toplam sipari� de�eri en y�ksek olan ilk 5 m��teriyi listeleyen bir sakl� yordam yaz�n. Exec komutu ile yordam� �a��r�n�z. (15p)
-- Sakl� yordam� g�ncelle
--2
ALTER PROCEDURE ListCustomersByEmailByState3
AS
BEGIN
    SELECT TOP 5 
        c.first_name, 
        c.last_name, 
        SUM(oi.quantity * oi.list_price) AS total_order_value
    FROM 
        sales.customers c
    INNER JOIN 
        sales.orders o ON c.customer_id = o.customer_id
    INNER JOIN 
        sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.first_name, c.last_name
    ORDER BY 
        total_order_value DESC;
END;

Go
EXEC ListCustomersByEmailByState3;



-- Soru 3: Belirli bir kategoriye ait t�m �r�nleri, sadece stokta olanlar� listeleyecek �ekilde, listelenen bir sakl� yordam yaz�n. Yordam, kategori kimli�ini parametre olarak almal�d�r. Exec komutu ile yordam� �a��r�n�z. (20p)
CREATE PROCEDURE ListProductsInCategoryWithStock
    @categoryID INT
AS
BEGIN
    SELECT
        p.product_name,
        s.quantity
    FROM
        production.products p
    JOIN
        production.stocks s ON p.product_id = s.product_id
    WHERE
        p.category_id = @categoryID
        AND s.quantity > 0;
END;


EXEC ListProductsInCategoryWithStock @categoryID = 1;


-- Soru 4: Belirli bir tarih aral���nda yap�lan t�m sipari�lerin detaylar�n� (m��teri ad�, sipari� numaras�, �r�n ad�, miktar, fiyat) g�steren bir sakl� yordam yaz�n�z. Yordam, ba�lang�� ve biti� tarihlerini parametre olarak almal�d�r. Exec komutu ile yordam� �a��r�n�z. (20p)
CREATE PROCEDURE ListOrderDetailsByDateRange
    @startDate DATE,
    @endDate DATE
AS
BEGIN
    SELECT
        c.first_name + ' ' + c.last_name AS customer_name,
        o.order_id,
        p.product_name,
        oi.quantity,
        oi.list_price
    FROM
        sales.orders o
    JOIN
        sales.customers c ON o.customer_id = c.customer_id
    JOIN
        sales.order_items oi ON o.order_id = oi.order_id
    JOIN
        production.products p ON oi.product_id = p.product_id
    WHERE
        o.order_date BETWEEN @startDate AND @endDate;
END;
 
EXEC ListOrderDetailsByDateRange @startDate = '2016-06-06', @endDate = '2016-12-12';


-- Soru 5: �al��anlar (staff) tablosundaki aktif olmayan (active de�eri 0 olan) personellerin durumunu g�ncelleyen ve belirli bir tarihten �nce i�e al�nanlar� silen bir sakl� yordam� yaz�n�z. Yordam, g�ncellenmesi gereken yeni durumu active state�i al�cakt�r. Exec komutu ile yordam� �a��r�n�z. (20p)
CREATE PROCEDURE UpdateInactiveStaffStatus
    @NewActiveState TINYINT -- Yeni durumu belirlemek i�in
AS
BEGIN
    -- �al��anlar� g�ncelle
    UPDATE sales.staffs
    SET active = @NewActiveState
    WHERE active = 0;
END;
GO

-- Sakl� yordam� �a��rma
EXEC UpdateInactiveStaffStatus @NewActiveState = 1;


-- Soru 6: Olu�turulan son sakl� yordam� siliniz. (10p)
DROP PROCEDURE IF EXISTS UpdateInactiveStaffStatus;