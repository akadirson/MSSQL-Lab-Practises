--Abdulkadir S�nmez���k 152120201086
--Soru 1: Bir m��teri silindi�inde bu m��teriye ait t�m sipari�lerin otomatik olarak silinmesini
--sa�layan tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n�
--yaz�n�z.
CREATE TRIGGER trg_1
ON sales.customers
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM sales.orders
    WHERE customer_id IN (SELECT customer_id FROM deleted);
END;

--test 1
INSERT INTO sales.customers (first_name, last_name, email) VALUES ('testn', 'tests', 'test@example.com');
INSERT INTO sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id) VALUES (SCOPE_IDENTITY(), 1, GETDATE(), GETDATE(), 1, 1);

DELETE FROM sales.customers WHERE customer_id = SCOPE_IDENTITY(); --m��teri sil

SELECT * FROM sales.orders; --sipari� silme kontrol


-- Soru 2: Bir sipari� kalemi eklenirken ilgili �r�n�n stok miktar�n�n otomatik olarak azalt�lmas�n� 
-- sa�layarak sipari� i�lemi ger�ekle�ti�inde stok seviyelerini ger�ek zamanl� olarak g�ncelleyen 
-- tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z.
CREATE TRIGGER trg_222
ON sales.order_items
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.stocks
    SET quantity = production.stocks.quantity - i.quantity
    FROM inserted i
    WHERE production.stocks.store_id = 1 AND production.stocks.product_id = i.product_id;
END;


-- Sipari� kalemi eklemek (item_id ile birlikte)
INSERT INTO sales.order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 1, 2, 50.00, 0.05);

-- Stok seviye kontrol
SELECT * FROM production.stocks;

--Soru 3: Bir �r�n silindi�inde bu �r�ne ait stok bilgilerinin de otomatik olarak silinmesini
--sa�layan tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n�
--yaz�n�z.
CREATE TRIGGER trg_33
ON production.products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM production.stocks
    WHERE product_id IN (SELECT product_id FROM deleted);
END;

--test SQL sorgular�-3
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price)
VALUES ('Test product', 1, 1, 2018, 369.99);
 
DELETE FROM production.products WHERE product_id = 1; -- �r�n� sil

SELECT * FROM production.stocks; --kontrol

--Soru 4: Yeni bir �r�n ekledi�inizde t�m ma�azalarda stok kayd� olu�turan tetikleyici kodunu
--yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL sorgular�n� yaz�n�z. 

CREATE TRIGGER trg_4
ON production.products
AFTER INSERT
AS
BEGIN
    INSERT INTO production.stocks (store_id, product_id, quantity)
    SELECT store_id, inserted.product_id, 0
    FROM sales.stores, inserted;
END;


--test
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('New Product', 1, 2, 2018, 500);

SELECT * FROM production.stocks WHERE product_id = (SELECT MAX(product_id) FROM production.products);

--Soru 5: Bir kategori silindi�inde, silinen kategoriye ait �r�nlerin kategori bilgilerini NULL
--olarak g�ncelleyen tetikleyici kodunu yaz�n�z (20p). �lgili tetikleyici kodunu test eden SQL
--sorgular�n� yaz�n�z.
CREATE TRIGGER trg_5
ON production.categories
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE production.products
    SET category_id = NULL
    FROM production.products p
    JOIN deleted d ON p.category_id = d.category_id;
END;


-- �nce bir kategori ve �r�n ekleyelim
INSERT INTO production.categories (category_name) VALUES ('Computer');
INSERT INTO production.products (product_name, brand_id, category_id, model_year, list_price) VALUES ('Keyboard', 1, SCOPE_IDENTITY(), 2018, 379.99);

DELETE FROM production.categories WHERE category_id = SCOPE_IDENTITY();

-- kontrol
SELECT * FROM production.products;