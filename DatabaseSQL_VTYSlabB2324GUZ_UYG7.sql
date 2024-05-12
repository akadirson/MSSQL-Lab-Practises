-- Soru 1: Belirli bir eyaletteki tüm müþterilerin e-posta adreslerini listeleyen bir saklý yordam yazýn. Yordam, eyalet adýný parametre olarak almalýdýr. Exec komutu ile yordamý çaðýrýnýz. (15p)
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


-- Soru 2: Önceki saklý yordamý güncelleyerek; Toplam sipariþ deðeri en yüksek olan ilk 5 müþteriyi listeleyen bir saklý yordam yazýn. Exec komutu ile yordamý çaðýrýnýz. (15p)
-- Saklý yordamý güncelle
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



-- Soru 3: Belirli bir kategoriye ait tüm ürünleri, sadece stokta olanlarý listeleyecek þekilde, listelenen bir saklý yordam yazýn. Yordam, kategori kimliðini parametre olarak almalýdýr. Exec komutu ile yordamý çaðýrýnýz. (20p)
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


-- Soru 4: Belirli bir tarih aralýðýnda yapýlan tüm sipariþlerin detaylarýný (müþteri adý, sipariþ numarasý, ürün adý, miktar, fiyat) gösteren bir saklý yordam yazýnýz. Yordam, baþlangýç ve bitiþ tarihlerini parametre olarak almalýdýr. Exec komutu ile yordamý çaðýrýnýz. (20p)
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


-- Soru 5: Çalýþanlar (staff) tablosundaki aktif olmayan (active deðeri 0 olan) personellerin durumunu güncelleyen ve belirli bir tarihten önce iþe alýnanlarý silen bir saklý yordamý yazýnýz. Yordam, güncellenmesi gereken yeni durumu active state’i alýcaktýr. Exec komutu ile yordamý çaðýrýnýz. (20p)
CREATE PROCEDURE UpdateInactiveStaffStatus
    @NewActiveState TINYINT -- Yeni durumu belirlemek için
AS
BEGIN
    -- Çalýþanlarý güncelle
    UPDATE sales.staffs
    SET active = @NewActiveState
    WHERE active = 0;
END;
GO

-- Saklý yordamý çaðýrma
EXEC UpdateInactiveStaffStatus @NewActiveState = 1;


-- Soru 6: Oluþturulan son saklý yordamý siliniz. (10p)
DROP PROCEDURE IF EXISTS UpdateInactiveStaffStatus;