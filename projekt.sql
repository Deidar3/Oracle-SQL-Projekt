-- Projekt: sklep z obuwiem

-- Projekt zakłada stworzenie bazy danych dla sklepu z obuwiem. 
-- Sklep ten oferuje różnorodne rodzaje obuwia, takie jak buty sportowe, klasyczne, letnie, zimowe.
-- Każde obuwie posiada różne cechy, takie jak rozmiar, kolor, marka, oraz cenę. Klienci sklepu mogą dokonywać zakupów, 
-- a także zapisywać się do programu lojalnościowego.

DROP TABLE PROGRAM_LOJALNOSCIOWY;
DROP TABLE ZAMOWIONE_PRODUKTY;
DROP TABLE ZAMOWIENIA;
DROP TABLE KLIENCI;
DROP TABLE PRODUKTY;
DROP TABLE MARKI;
DROP TABLE KATEGORIE;

-- Tabela KATEGORIE
CREATE TABLE KATEGORIE (
    KATEGORIA_ID NUMBER PRIMARY KEY,
    NAZWA_KATEGORII VARCHAR2(50) NOT NULL UNIQUE,
    OPIS VARCHAR2(255),
    RODZAJ_OBUWIA VARCHAR2(80),
    SEZON VARCHAR2(30),
    POPULARNOSC VARCHAR2(50)
);

-- Tabela MARKI
CREATE TABLE MARKI (
    MARKA_ID NUMBER PRIMARY KEY,
    NAZWA_MARKI VARCHAR2(50) NOT NULL UNIQUE,
    KRAJ_POCHODZENIA VARCHAR2(30) NOT NULL,
    DATA_ZALOZENIA TIMESTAMP,
    POPULARNOSC VARCHAR2(50)
);

-- Tabela PRODUKTY
CREATE TABLE PRODUKTY (
    PRODUKT_ID NUMBER PRIMARY KEY,
    NAZWA VARCHAR2(255) NOT NULL,
    CENA NUMBER(10, 2) NOT NULL,
    ROZMIAR NUMBER NOT NULL,
    KOLOR VARCHAR2(50) NOT NULL,
    ILOSC NUMBER NOT NULL CHECK (ILOSC >= 0),
    KATEGORIA_ID NUMBER NOT NULL,
    MARKA_ID NUMBER NOT NULL,
    FOREIGN KEY (KATEGORIA_ID) REFERENCES KATEGORIE(KATEGORIA_ID),
    FOREIGN KEY (MARKA_ID) REFERENCES MARKI(MARKA_ID)
);

-- Tabela KLIENCI
CREATE TABLE KLIENCI (
    KLIENT_ID NUMBER PRIMARY KEY,
    IMIE VARCHAR2(30) NOT NULL,
    NAZWISKO VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL UNIQUE,
    NR_TEL VARCHAR2(30) NOT NULL,
    ADRES VARCHAR2(30) NOT NULL
);

-- Tabela ZAMOWIENIA
CREATE TABLE ZAMOWIENIA (
    ZAMOWIENIE_ID NUMBER PRIMARY KEY,
    KLIENT_ID NUMBER NOT NULL,
    DATA_ZAMOWIENIA DATE NOT NULL,
    STATUS_ZAMOWIENIA VARCHAR2(255) NOT NULL,
    SUMA_ZAMOWIENIA NUMBER(10, 2) NOT NULL CHECK (SUMA_ZAMOWIENIA >= 0),
    FOREIGN KEY (KLIENT_ID) REFERENCES KLIENCI(KLIENT_ID)
);

-- Tabela ZAMOWIONE_PRODUKTY
CREATE TABLE ZAMOWIONE_PRODUKTY (
    ZAMOWIENIE_PRODUKT_ID NUMBER PRIMARY KEY,
    ZAMOWIENIE_ID NUMBER NOT NULL,
    PRODUKT_ID NUMBER NOT NULL,
    ILOSC NUMBER NOT NULL CHECK (ILOSC >= 0),
    CENA NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (ZAMOWIENIE_ID) REFERENCES ZAMOWIENIA(ZAMOWIENIE_ID),
    FOREIGN KEY (PRODUKT_ID) REFERENCES PRODUKTY(PRODUKT_ID)
);

-- Tabela PROGRAM_LOJALNOSCIOWY
CREATE TABLE PROGRAM_LOJALNOSCIOWY (
    PROGRAM_ID NUMBER PRIMARY KEY,
    KLIENT_ID NUMBER NOT NULL,
    PUNKTY NUMBER NOT NULL CHECK (PUNKTY >= 0),
    DATA_ZDOBYCIA_PUNKTOW DATE NOT NULL,
    DATA_WYGASNIECIA_PUNKTOW DATE NOT NULL,
    FOREIGN KEY (KLIENT_ID) REFERENCES KLIENCI(KLIENT_ID)
);

-- Tabela KATEGORIE
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (1, 'Sportowe', 'Buty do aktywnosci sportowej', 'Sneakersy', 'Wiosna/Lato', 'Wysoka');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (2, 'Eleganckie', 'Buty na specjalne okazje', 'Eleganckie', 'Caloroczne', 'Srednia');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (3, 'Letnie', 'Sandalay i klapki', 'Sandalay', 'Lato', 'Srednia');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (4, 'Zimowe', 'Buty na zime', 'Trapery', 'Zima', 'Wysoka');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (5, 'Trampki', 'Buty casualowe', 'Trampki', 'Caloroczne', 'Srednia');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (6, 'Buty trekkingowe', 'Buty na spacery i wedrowki', 'Trekkingowe', 'Wiosna/Lato', 'Wysoka');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (7, 'Buty do biegania', 'Buty sportowe do biegania', 'Biegowe', 'Caloroczne', 'Wysoka');
INSERT INTO KATEGORIE (KATEGORIA_ID, NAZWA_KATEGORII, OPIS, RODZAJ_OBUWIA, SEZON, POPULARNOSC) VALUES (8, 'Polbuty', 'Eleganckie polbuty', 'Polbuty', 'Caloroczne', 'Srednia');

-- Tabela MARKI
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (1, 'Nike', 'USA', TO_DATE('25-01-1971', 'DD-MI-YYYY'), 'Wysoka');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (2, 'Adidas', 'Niemcy', TO_DATE('18-08-1949', 'DD-MI-YYYY'), 'Wysoka');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (3, 'Puma', 'Niemcy', TO_DATE('01-10-1948', 'DD-MI-YYYY'), 'Srednia');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (4, 'Timberland', 'USA', TO_DATE('01-01-1952', 'DD-MI-YYYY'), 'Srednia');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (5, 'Converse', 'USA', TO_DATE('31-05-1908', 'DD-MI-YYYY'), 'Wysoka');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (6, 'Salomon', 'Francja', TO_DATE('01-07-1947', 'DD-MI-YYYY'), 'Srednia');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (7, 'New Balance', 'USA', TO_DATE('15-03-1906', 'DD-MI-YYYY'), 'Wysoka');
INSERT INTO MARKI (MARKA_ID, NAZWA_MARKI, KRAJ_POCHODZENIA, DATA_ZALOZENIA, POPULARNOSC) VALUES (8, 'Ecco', 'Dania', TO_DATE('01-01-1963', 'DD-MI-YYYY'), 'Srednia');

-- Tabela PRODUKTY
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (1, 'Air Max 90', 199.99, 42, 'Czerwony', 50, 1, 1);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (2, 'Stan Smith', 149.99, 38, 'Bialy', 30, 2, 2);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (3, 'Leadcat', 59.99, 39, 'Czarny', 20, 3, 3);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (4, '6-Inch Premium Boot', 249.99, 40, 'Brazowy', 15, 4, 4);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (5, 'Chuck Taylor All Star', 69.99, 41, 'Granatowy', 40, 5, 5);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (6, 'XA Pro 3D', 139.99, 45, 'Zielony', 25, 6, 6);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (7, 'Fresh Foam 1080', 179.99, 44, 'Pomaranczowy', 35, 7, 7);
INSERT INTO PRODUKTY (PRODUKT_ID, NAZWA, CENA, ROZMIAR, KOLOR, ILOSC, KATEGORIA_ID, MARKA_ID) VALUES (8, 'Soft 7', 129.99, 39, 'Czarny', 28, 8, 8);

-- Tabela KLIENCI
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (20, 'Jan', 'Kowalski', 'jan.kowalski@email.com', '123-456-7890', 'ul. Kwiatowa 1, Warszawa');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (21, 'Anna', 'Nowak', 'anna.nowak@email.com', '987-654-3210', 'ul. Ogrodowa 5, Krakow');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (22, 'Piotr', 'Wisniewski', 'piotr.wisniewski@email.com', '555-123-4567', 'ul. Lesna 10, Gdansk');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (23, 'Karolina', 'Dabrowska', 'karolina.dabrowska@email.com', '111-222-3333', 'ul. Sloneczna 8, Poznan');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (24, 'Adam', 'Lis', 'adam.lis@email.com', '444-555-6666', 'ul. Blawatna 12, Wroclaw');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (25, 'Katarzyna', 'Wojcik', 'katarzyna.wojcik@email.com', '777-888-9999', 'ul. Zielona 7, Lodz');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (26, 'Marek', 'Jankowski', 'marek.jankowski@email.com', '333-222-1111', 'ul. Gorska 3, Katowice');
INSERT INTO KLIENCI (KLIENT_ID, IMIE, NAZWISKO, EMAIL, NR_TEL, ADRES) VALUES (27, 'Ewa', 'Kaminska', 'ewa.kaminska@email.com', '666-777-8888', 'ul. Kwiatowa 4, Gdynia');

-- Tabela ZAMOWIENIA
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (10, 20, TO_DATE('15-01-2023 18:30', 'dd-mm-yyyy hh24:mi'), 'Nowe', 120.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (11, 21, TO_DATE('20-02-2023 02:45', 'dd-mm-yyyy hh24:mi'), 'W trakcie realizacji', 200.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (12, 22, TO_DATE('25-03-2023 19:20', 'dd-mm-yyyy hh24:mi'), 'Dostarczone', 90.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (13, 23, TO_DATE('05-04-2023 21:10', 'dd-mm-yyyy hh24:mi'), 'Nowe', 150.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (14, 24, TO_DATE('12-05-2023 03:30', 'dd-mm-yyyy hh24:mi'), 'W trakcie realizacji', 180.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (15, 25, TO_DATE('18-06-2023 08:45', 'dd-mm-yyyy hh24:mi'), 'Dostarczone', 210.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (16, 26, TO_DATE('22-07-2023 10:20', 'dd-mm-yyyy hh24:mi'), 'Nowe', 130.00);
INSERT INTO ZAMOWIENIA (ZAMOWIENIE_ID, KLIENT_ID, DATA_ZAMOWIENIA, STATUS_ZAMOWIENIA, SUMA_ZAMOWIENIA) VALUES (17, 27, TO_DATE('30-08-2023 15:15', 'dd-mm-yyyy hh24:mi'), 'W trakcie realizacji', 160.00);

-- Tabela ZAMOWIONE_PRODUKTY
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (10, 10, 1, 2, 199.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (11, 11, 1, 2, 59.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (12, 12, 2, 3, 149.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (13, 13, 5, 2, 69.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (14, 14, 4, 1, 249.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (15, 15, 6, 2, 139.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (16, 16, 7, 1, 179.99);
INSERT INTO ZAMOWIONE_PRODUKTY (ZAMOWIENIE_PRODUKT_ID, ZAMOWIENIE_ID, PRODUKT_ID, ILOSC, CENA) VALUES (17, 17, 8, 3, 129.99);

-- Tabela PROGRAM_LOJALNOSCIOWY
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (1, 20, 50, TO_DATE('10-01-2023 08:00', 'dd-mm-yyyy hh24:mi'), TO_DATE('10-07-2023 08:00', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (2, 21, 30, TO_DATE('20-02-2023 10:30', 'dd-mm-yyyy hh24:mi'), TO_DATE('20-08-2023 10:30', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (3, 22, 80, TO_DATE('15-03-2023 12:45', 'dd-mm-yyyy hh24:mi'), TO_DATE('15-09-2023 12:45', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (4, 23, 20, TO_DATE('02-04-2023 09:00', 'dd-mm-yyyy hh24:mi'), TO_DATE('18-11-2023 03:20', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (5, 24, 60, TO_DATE('18-05-2023 03:20', 'dd-mm-yyyy hh24:mi'), TO_DATE('21-12-2023 05:40', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (6, 25, 40, TO_DATE('22-06-2023 11:10', 'dd-mm-yyyy hh24:mi'), TO_DATE('22-12-2023 11:10', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (7, 26, 75, TO_DATE('28-07-2023 02:30', 'dd-mm-yyyy hh24:mi'), TO_DATE('28-01-2024 02:30', 'dd-mm-yyyy hh24:mi'));
INSERT INTO PROGRAM_LOJALNOSCIOWY (PROGRAM_ID, KLIENT_ID, PUNKTY, DATA_ZDOBYCIA_PUNKTOW, DATA_WYGASNIECIA_PUNKTOW) VALUES (8, 27, 25, TO_DATE('31-08-2023 01:45', 'dd-mm-yyyy hh24:mi'), TO_DATE('29-02-2024 01:45', 'dd-mm-yyyy hh24:mi'));                                                                                        