USE OgrenciBilgiSistemi
CREATE TABLE Ogretmen(
	OgretmenID int PRIMARY KEY NOT NULL,
	Ad varchar(50) NOT NULL,
	Soyad varchar(50) NOT NULL,
	Brans varchar(50),
	Email varchar(100),
	Telefon varchar(15)
);
CREATE TABLE Ders(
	DersID int PRIMARY KEY NOT NULL,
	DersAdi varchar(100) NOT NULL,
	Kredi int,
	Bolum varchar(50),
	OgretmenID int NOT NULL, --FOREIGN key
	CONSTRAINT FK_ogretmen_id FOREIGN KEY (OgretmenID) REFERENCES Ogretmen (OgretmenID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ogrenci(
	OgrenciID int PRIMARY KEY NOT NULL,
	Ad varchar(50) NOT NULL,
	Soyad varchar(50) NOT NULL,
	DogumTarihi date,
	Cinsiyet char(1),
	Telefon varchar(15),
	Email varchar(100),
	Adres varchar(255)
);
CREATE TABLE SinavSonuclarý(
	SonucID int PRIMARY KEY NOT NULL,
	OgrenciID int NOT NULL, --FOREIGN key
	DersID int NOT NULL, --FOREIGN key
	SinavTarihi date,
	Puan int,
	CONSTRAINT FK_ogrenci_id FOREIGN KEY (OgrenciID) REFERENCES Ogrenci (OgrenciID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_ders_id FOREIGN KEY (DersID) REFERENCES Ders (DersID) ON DELETE CASCADE ON UPDATE CASCADE
);