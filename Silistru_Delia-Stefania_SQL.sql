---------CREAREA TABELELOR-----------------
 
-----CREAREA TABELULUI FIRMA_DSI--------
 
CREATE TABLE FIRMA_DSI
    (id_firma NUMBER(4)
    CONSTRAINT id_firma_nn NOT NULL
    , nume VARCHAR2(25),
    adresa VARCHAR(25)
    );
 

CREATE UNIQUE INDEX id_firma_pk
ON FIRMA_DSI(id_firma);
 
ALTER TABLE FIRMA_DSI
ADD ( CONSTRAINT id_firma_pk
                PRIMARY KEY (id_firma)
    );
 
 
-------CREAREA TABELULUI COLABORATOR_DSI-------
 
 
CREATE TABLE COLABORATOR_DSI
    ( id_colaborator NUMBER(4)
    CONSTRAINT id_colaborator_nn NOT NULL
    , brand VARCHAR2(25),
    telefon NUMBER(4)
    );
    
CREATE UNIQUE INDEX id_colaborator_pk
ON COLABORATOR_DSI(id_colaborator);
 
ALTER TABLE COLABORATOR_DSI
ADD ( CONSTRAINT id_colaborator_pk
                PRIMARY KEY (id_colaborator)
    );
 
-----------CREAREA TABELULUI ANGAJAT_DSI---------
 
CREATE TABLE ANGAJAT_DSI
    (id_angajat NUMBER(4)
    , id_firma NUMBER(4) 
    , nume VARCHAR2(25)
    , prenume VARCHAR2(25)
    , vechime NUMBER(4)
    , id_manager NUMBER(4)
    , id_design NUMBER(4)
    , id_stylist NUMBER(4)
    );
 
CREATE UNIQUE INDEX id_angajat_pk
ON ANGAJAT_DSI (id_angajat);
 
ALTER TABLE ANGAJAT_DSI
ADD ( CONSTRAINT id_angajat_pk
       		 PRIMARY KEY (id_angajat)
    , CONSTRAINT id_firma_fk
       		 FOREIGN KEY (id_firma)
        	  REFERENCES FIRMA_DSI(id_firma) 
    ) ;
 
 
ALTER TABLE ANGAJAT_DSI
ADD salariu NUMBER(4);
 
SELECT *FROM ANGAJAT_DSI;
 
 
-----------CREAREA TABELULUI COLABORARE_DSI------
 
CREATE TABLE COLABORARE_DSI
    (id_colaborare NUMBER(4)
    , id_firma NUMBER(4) 
    , id_colaborator NUMBER(4)
    , id_manager NUMBER(4)
    , data_start DATE
	CONSTRAINT     data_start_nn  NOT NULL
    );
    
CREATE UNIQUE INDEX id_colaborare_pk
ON COLABORARE_DSI (id_colaborare);
 
ALTER TABLE COLABORARE_DSI
ADD ( CONSTRAINT id_colaborare_pk
      PRIMARY KEY (id_colaborare)
    , CONSTRAINT     id_firma_firma_fk
                     FOREIGN KEY (id_firma)
                     REFERENCES FIRMA_DSI(id_firma)
    , CONSTRAINT     id_colaborator_fk
                     FOREIGN KEY (id_colaborator)
                     REFERENCES COLABORATOR_DSI(id_colaborator)
    , CONSTRAINT     id_manager_fk
                     FOREIGN KEY (id_manager)
                     REFERENCES ANGAJAT_DSI(id_angajat) 
    ) ;
 
---------CREARE TABEL PIESA_DSI----
 
CREATE TABLE PIESA_DSI
    (
    id_piesa NUMBER(4)
    , id_colaborare NUMBER(4) 
    , descriere VARCHAR2(25)
	CONSTRAINT     descriere_nn  NOT NULL
    );
 
CREATE UNIQUE INDEX id_piesa_pk
ON PIESA_DSI (id_piesa);
 
ALTER TABLE PIESA_DSI
ADD ( CONSTRAINT id_piesa_pk
       		 PRIMARY KEY (id_piesa)
    , CONSTRAINT id_colaborare_fk
       		 FOREIGN KEY (id_colaborare)
        	  REFERENCES COLABORARE_DSI(id_colaborare) 
    ) ;
 
 
----------CREAREA TABELULUI DEFECT_DSI-----
 
CREATE TABLE DEFECT_DSI
    (
    id_defect NUMBER(4)
    , id_piesa NUMBER(4)
    , id_stylist NUMBER(4)
    , data_descoperire DATE
	CONSTRAINT     data_descoperire_nn  NOT NULL
    , data_rezolvare DATE
    , id_asignat NUMBER(4)
    , id_rezolvat NUMBER(4)
    , id_de_inlocuit NUMBER(4)
    , problema VARCHAR2(25)
	CONSTRAINT     problema_nn  NOT NULL
    );

 
CREATE UNIQUE INDEX id_defect_pk
ON DEFECT_DSI (id_defect);
 
ALTER TABLE DEFECT_DSI
ADD ( CONSTRAINT id_defect_pk
       		 PRIMARY KEY (id_defect)
    , CONSTRAINT id_piesa_fk
       		 FOREIGN KEY (id_piesa)
        	  REFERENCES PIESA_DSI(id_piesa) 
    , CONSTRAINT  id_stylist_fk
            FOREIGN KEY (id_stylist)
            REFERENCES ANGAJAT_DSI(id_angajat) 
    ) ;
 
------CREAREA TABELULUI PROPRUNERE-------
 
CREATE TABLE PROPUNERE_DSI
    (
    id_propunere NUMBER(4)
    , id_defect NUMBER(4)
    , id_designer NUMBER(4)
    , feedback_descriere VARCHAR2(25)
	CONSTRAINT     feedback_descriere_nn  NOT NULL
    );
    
CREATE UNIQUE INDEX id_propunere_pk
ON PROPUNERE_DSI (id_propunere);
 
ALTER TABLE PROPUNERE_DSI
ADD ( CONSTRAINT id_propunere_pk
       		 PRIMARY KEY (id_propunere)
    , CONSTRAINT id_defect_fk
       		 FOREIGN KEY (id_defect)
        	  REFERENCES DEFECT_DSI(id_defect) 
    , CONSTRAINT  id_designer_fk
            FOREIGN KEY (id_designer)
            REFERENCES ANGAJAT_DSI(id_angajat) 
    ) ;
    
-------CREAREA TABELULUI ASIGNEAZA-------
CREATE TABLE ASIGNEAZA_DSI
    ( id_manager NUMBER(4) REFERENCES ANGAJAT_DSI(id_angajat),
      id_designer NUMBER(4) REFERENCES ANGAJAT_DSI(id_angajat),
      id_defect NUMBER(4) REFERENCES DEFECT_DSI(id_defect),
      termen_limita DATE
      CONSTRAINT     termen_limita_nn  NOT NULL,
      primary key(id_manager, id_designer, id_defect));
 
 
--------AM TERMINAT DE CREAT TABELELE----------


-------POPULAREA TABELULUI FIRMA_DSI---------
 
INSERT INTO FIRMA_DSI VALUES (1, 'Dior', 'Paris25');
 
SELECT *FROM FIRMA_DSI;
 
--------POPULAREA TABELULUI COLABORATOR_DSI-----
 
INSERT INTO COLABORATOR_DSI VALUES (1, 'Zara', 2322);
INSERT INTO COLABORATOR_DSI VALUES (2, 'HM', 1222);
INSERT INTO COLABORATOR_DSI VALUES (3, 'Asos', 2533);
INSERT INTO COLABORATOR_DSI VALUES (4, 'Guess', 8333);
INSERT INTO COLABORATOR_DSI VALUES (5, 'Aldo', 1234);
INSERT INTO COLABORATOR_DSI VALUES (6, 'Polo', 6543);
INSERT INTO COLABORATOR_DSI VALUES (7, 'Adidas', 8865);
 
SELECT *FROM COLABORATOR_DSI;
 
-------POPULAREA TABELULUI ANGAJAT_DSI------
 
 
INSERT INTO ANGAJAT_DSI VALUES (1, 1, 'Gavril', 'Bogdan', 5, 1, NULL, NULL, 8900);
INSERT INTO ANGAJAT_DSI VALUES (2, 1, 'Stirbu', 'Denisa', 2, NULL, 1, NULL, 6544);
INSERT INTO ANGAJAT_DSI VALUES (3, 1, 'Trifan', 'Magda', 3, NULL, NULL, 1, 7888);
INSERT INTO ANGAJAT_DSI VALUES (4, 1, 'Urse', 'Ilinca', 7, 1, NULL, NULL, 8300);
INSERT INTO ANGAJAT_DSI VALUES (5, 1, 'Neagu', 'Andi', 6, 1, NULL, NULL, 9212);
INSERT INTO ANGAJAT_DSI VALUES (6, 1, 'Costea', 'Ionut', 1, 1, NULL, NULL, 5643);
INSERT INTO ANGAJAT_DSI VALUES (7, 1, 'Silistru', 'Delia', 9, 1, NULL, NULL, 9999);
INSERT INTO ANGAJAT_DSI VALUES (8, 1, 'Ceausu', 'Corina', 8, NULL, 1, NULL, 9121);
INSERT INTO ANGAJAT_DSI VALUES (9, 1, 'Calin', 'Andrei', 10, NULL, NULL, 1, 8775);
INSERT INTO ANGAJAT_DSI VALUES (10, 1, 'Filip', 'Alexandra', 11, NULL, 1, NULL, 8221);
INSERT INTO ANGAJAT_DSI VALUES (11, 1, 'Dorcioman', 'Razvan', 12, 1, NULL, NULL, 7755);
INSERT INTO ANGAJAT_DSI VALUES (12, 1, 'Bulmaci', 'Raluca', 13, 1, NULL, NULL, 9887);
INSERT INTO ANGAJAT_DSI VALUES (13, 1, 'Panainte', 'Iulia', 14, NULL, NULL, 1, 9812);
INSERT INTO ANGAJAT_DSI VALUES (14, 1, 'Atudore', 'Darius', 15, NULL, 1, NULL, 6574);
INSERT INTO ANGAJAT_DSI VALUES (15, 1, 'Zota', 'Bianca', 20, NULL, 1, NULL, 8751);
INSERT INTO ANGAJAT_DSI VALUES (16, 1, 'Tilici', 'Ioana', 21, NULL, 1, NULL, 7888);
 
SELECT *FROM ANGAJAT_DSI;
 
 
 
-----POPULARE TABEL COLABORARE_DSI----------
 
INSERT INTO COLABORARE_DSI VALUES(1, 1, 1, 1, '01-JAN-19');
INSERT INTO COLABORARE_DSI VALUES(2, 1, 2, 4, '20-NOV-20');
INSERT INTO COLABORARE_DSI VALUES(3, 1, 3, 5, '19-FEB-18');
INSERT INTO COLABORARE_DSI VALUES(4, 1, 4, 6, '17-DEC-19');
INSERT INTO COLABORARE_DSI VALUES(5, 1, 5, 7, '18-MAY-20');
INSERT INTO COLABORARE_DSI VALUES(6, 1, 6, 11, '15-JAN-17');
INSERT INTO COLABORARE_DSI VALUES(7, 1, 7, 12, '15-DEC-15');
 
SELECT *FROM COLABORARE_DSI;
 
 
----POPULARE TABEL PIESA_DSI------
 
INSERT INTO PIESA_DSI VALUES(1, 1, 'top cu maneci bufante');
INSERT INTO PIESA_DSI VALUES(2, 2, 'pantaloni piele naturala');
INSERT INTO PIESA_DSI VALUES(3, 3, 'rochie din paiete');
INSERT INTO PIESA_DSI VALUES(4, 4, 'esarfa matase naturala');
INSERT INTO PIESA_DSI VALUES(5, 5, 'sandale cu toc subtire');
INSERT INTO PIESA_DSI VALUES(6, 6, 'rochie imprimeu floral');
INSERT INTO PIESA_DSI VALUES(7, 7, 'fusta scurta din catifea');
 
SELECT *FROM PIESA_DSI;
 
----POPULARE TABEL DEFECT_DSI--------
 
 
INSERT INTO DEFECT_DSI VALUES(1, 1, 3, '23-JUN-19', 1, NULL, NULL, 'problema simetrie');
INSERT INTO DEFECT_DSI VALUES(2, 3, 9, '12-JAN-20', NULL, 1, NULL, 'paiete lipsa');
INSERT INTO DEFECT_DSI VALUES(3, 7, 13, '10-JAN-19',NULL, 1, NULL, 'material deteriorat');

 
------POPULARE TABEL ASIGNEAZA_DSI--------
 
 
INSERT INTO ASIGNEAZA_DSI VALUES(1, 2, 1, '27-JUL-19');
INSERT INTO ASIGNEAZA_DSI VALUES(4, 8, 2, '18-FEB-20');
INSERT INTO ASIGNEAZA_DSI VALUES(5, 10, 3, '03-DEC-19');
INSERT INTO ASIGNEAZA_DSI VALUES(11, 15, 1, '27-JUL-19');
INSERT INTO ASIGNEAZA_DSI VALUES(7, 14, 1, '27-JUL-19');
INSERT INTO ASIGNEAZA_DSI VALUES(6, 8, 3, '03-DEC-19');
INSERT INTO ASIGNEAZA_DSI VALUES(12, 16, 1, '27-JUL-19');
INSERT INTO ASIGNEAZA_DSI VALUES(6, 15, 3, '03-DEC-19');
INSERT INTO ASIGNEAZA_DSI VALUES(4, 2, 3, '03-DEC-19');
INSERT INTO ASIGNEAZA_DSI VALUES(5, 15, 1, '27-JUL-19');

 
select *from ASIGNEAZA_DSI;
 
-----POPULARE TABEL PROPUNERE_DSI------
 
INSERT INTO PROPUNERE_DSI VALUES(1, 1, 2, 'ajustare maneca');
INSERT INTO PROPUNERE_DSI VALUES(2, 2, 10, 'lipire paiete');
INSERT INTO PROPUNERE_DSI VALUES(3, 3, 15, 'inlocuire material');
 
SELECT *FROM PROPUNERE_DSI;
 
COMMIT;
-----------AM TERMINAT DE POPULAT TABELELE-----------





--- EX 1 ---
--- Definiti un subprogram stocat care sa utilizeze un tip de colectie studiat prin care sa obtineti salariile angajatilor
--- a caror id-uri sunt date ca parametru printr-un vector, precum si procentajul salariului fiecarui angajat din totalul 
--- salariilor acestora.
CREATE OR REPLACE TYPE angajati_ids IS TABLE OF NUMBER;
/

CREATE OR REPLACE PROCEDURE salariile(V_ANGAJATI angajati_ids)
AS
    TYPE SALARII IS TABLE OF NUMBER;
    V_SALARII SALARII := SALARII();
    J NUMBER :=1;
    V_TOTAL NUMBER :=0;
BEGIN
    FOR I IN V_ANGAJATI.FIRST..V_ANGAJATI.LAST LOOP
    V_SALARII.EXTEND(1);
    
    SELECT SALARIU
    INTO V_SALARII(J)
    FROM ANGAJAT_DSI
    WHERE ID_ANGAJAT = V_ANGAJATI(I);
    
    V_TOTAL := V_TOTAL + V_SALARII(J);
    J := J+1;
    END LOOP;
    FOR I IN V_SALARII.FIRST..V_SALARII.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Angajatul cu id-ul ' || V_ANGAJATI(I) || ' are salariul ' || V_SALARII(I) || ' care reprezinta' || 100*V_SALARII(I)/V_TOTAL || '% din totalul salariilor angajatilor dati' );
    END LOOP;

END;
/
SET SERVEROUTPUT ON;

DECLARE
    vt_angajati angajati_ids := angajati_ids();
BEGIN 
    vt_angajati.extend(3);
    vt_angajati(1) := 2;
    vt_angajati(2) := 3;
    vt_angajati(3) := 4;
    salariile(vt_angajati);
END;
/



--- EX 2 ---
--- Definiti un subprogram stocat care sa utilizeze un tip de cursor studiat prin care sa obtineti informatii legate de timpul
---in care designerii au reusit sa rezolve defectul care le-a fost asignate. La final afisati media acestor intervale de timp.



CREATE OR REPLACE PROCEDURE p2
AS
    CURSOR c IS
        (SELECT distinct problema, termen_limita, data_rezolvare
         from defect_dsi d, asigneaza_dsi a 
         where d.id_defect = a.id_defect and id_rezolvat = 1
       );
        v_problema defect_dsi.problema%TYPE;
        v_termen_limita asigneaza_dsi.termen_limita%TYPE;
        v_data_rezolvare defect_dsi.data_rezolvare%TYPE;
        v_diferenta NUMBER;
        v_medie NUMBER := null;
        v_total NUMBER := 0;
        v_nr_elemente NUMBER :=0;
    BEGIN
        OPEN c;
        loop
            fetch c into v_problema, v_termen_limita, v_data_rezolvare;
            exit when c%notfound;
            v_diferenta := v_data_rezolvare - v_termen_limita;
            if v_data_rezolvare > v_termen_limita then
                DBMS_OUTPUT.PUT_LINE('Designerii nu s-au descurcat si au intarziat cu ' || v_diferenta || ' zile in rezolvarea problemei: ' || v_problema );
                    v_total := v_total - v_diferenta;
            elsif v_diferenta > 0 then
                DBMS_OUTPUT.PUT_LINE('Designerii s-au descurcat si au terminat cu ' || v_diferenta || ' zile mai devreme de limita in rezolvarea problemei: ' || v_problema );
                    v_total := v_total + v_diferenta;
            else 
                DBMS_OUTPUT.PUT_LINE('Designerii s-au descurcat si au terminat exact la timp in rezolvarea problemei: ' || v_problema );
            end if;
        end loop;
            select count(*) into v_nr_elemente
            from defect_dsi where id_rezolvat = 1;
            v_medie := v_total / v_nr_elemente;
            DBMS_OUTPUT.PUT_LINE('Media eficientei designerilor este ' || v_medie);  
        close c;
END;
/

begin
    p2;
end;
/

--- EX 3 ---
---Sa se defineasca un subprogram stocat de tip functie care sa afiseze cel mai mare salariu a unui designer care a 
---lucrat la rezolvarea unui defect dat.

CREATE OR REPLACE FUNCTION f1
    (v_defect defect_dsi.id_defect%TYPE)
RETURN NUMBER
IS
maxim NUMBER;
BEGIN 
    SELECT MAX(salariu) INTO maxim
    FROM angajat_dsi an
        JOIN asigneaza_dsi a ON (an.id_angajat = a.id_designer)
        JOIN defect_dsi d ON (a.id_defect = d.id_defect)
    WHERE d.id_defect = v_defect
    GROUP BY d.id_defect;
    RETURN maxim;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista defecte cu acest id');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Alta eroare!');
        
END f1;
/
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('Salariul maxim este ' || f1(3));
END;
/

    







--- EX 4 --- 
--- Sa se afiseze numele stilistului care a lucrat in colaborare cu o companie data.

CREATE OR REPLACE PROCEDURE p3
    (v_brand colaborator_dsi.brand%TYPE)
IS
    v_nume angajat_dsi.nume%TYPE;
BEGIN
    SELECT nume INTO v_nume
    FROM angajat_dsi a JOIN defect_dsi d ON (a.id_angajat = d.id_stylist)
                       JOIN piesa_dsi p ON (p.id_piesa = d.id_piesa)
                       JOIN colaborare_dsi c ON (p.id_colaborare = c.id_colaborare)
                       JOIN colaborator_dsi co ON (c.id_colaborator = co.id_colaborator)
    WHERE co.brand = v_brand;
    
    DBMS_OUTPUT.PUT_LINE('Numele stilistului care lucreaza in colaborare cu ' || v_brand ||' este ' || v_nume);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista firma cu numele dat');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Alta eroare!');
        
END p3;
/
 
 
BEGIN 
    p3('Zara');
END;
/




--- EX 5 --- TRIGGERI LMD LA NIVEL DE COMANDA
--- Definiti un trigger care sa permita lucrul asupra tabelului angajat_dsi (INSERT, UPDATE, DELETE) doar 
--- in intervalul de ora 9:00 - 16:00, de luni pana sambata.
CREATE OR REPLACE TRIGGER trig1
    BEFORE INSERT OR UPDATE OR DELETE ON angajat_dsi
BEGIN
    IF (TO_CHAR(SYSDATE,'D') = 1)
        OR(TO_CHAR(SYSDATE, 'HH24') NOT BETWEEN 9 AND 16)
    THEN 
    RAISE_APPLICATION_ERROR (-20001, 'Tabelul nu poate fi actualizat decat in timpul programului de lucru');
    END IF;
END;
/

UPDATE angajat_dsi set salariu = 8000
where id_angajat = 16;

--- EX 6 ---
--- Definiti un trigger prin care sa nu se permita micsorarea salariilor angajatilor


CREATE OR REPLACE TRIGGER trig2
    BEFORE UPDATE OF salariu ON angajat_dsi
    FOR EACH ROW
BEGIN 
    IF (:NEW.salariu < :OLD.salariu) THEN
    RAISE_APPLICATION_ERROR(-20002, 'Salariul nu poate fi micsorat');
    END IF;
END;
/

UPDATE angajat_dsi
SET salariu = salariu - 100;

--- EX 7 ---
--- Creati un tabel care sa contina campurile utilizator, nume_bd, eveniment, nume_obiect, data
--- Si definiti un trigger care sa introduca date in acest tabel dupa ce utilizatorul a folosit o comanda LDD. 


CREATE TABLE evenimente_dsi
(utilizator VARCHAR2(20),
 nume_bd VARCHAR2(20),
 eveniment VARCHAR2(30),
 nume_obiect VARCHAR2(20) ,
 data           DATE);
 
 
CREATE OR REPLACE TRIGGER trig3
  AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
  INSERT INTO evenimente_dsi
  VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT,
          SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END; 
/
 
CREATE TABLE test(n NUMBER);
 
SELECT * FROM evenimente_dsi;


--- EX 8 ---
--- Definiti un pachet care sa contina toate obiectele definite in cadrul proiectului

CREATE OR REPLACE PACKAGE pachet1 AS
    PROCEDURE salariile(V_ANGAJATI angajati_ids);
    PROCEDURE p2;
    FUNCTION f1 (v_defect defect_dsi.id_defect%TYPE)
        RETURN NUMBER;
    PROCEDURE p3 (v_brand colaborator_dsi.brand%TYPE);
        
END pachet1;
/



CREATE OR REPLACE PACKAGE BODY pachet1 AS
    FUNCTION f1
    (v_defect defect_dsi.id_defect%TYPE)
RETURN NUMBER
IS
maxim NUMBER;
BEGIN 
    SELECT MAX(salariu) INTO maxim
    FROM angajat_dsi an
        JOIN asigneaza_dsi a ON (an.id_angajat = a.id_designer)
        JOIN defect_dsi d ON (a.id_defect = d.id_defect)
    WHERE d.id_defect = v_defect
    GROUP BY d.id_defect;
    RETURN maxim;
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista defecte cu acest id');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Alta eroare!');
        
END f1;

     PROCEDURE salariile(V_ANGAJATI angajati_ids)
AS
    TYPE SALARII IS TABLE OF NUMBER;
    V_SALARII SALARII := SALARII();
    J NUMBER :=1;
    V_TOTAL NUMBER :=0;
BEGIN
    FOR I IN V_ANGAJATI.FIRST..V_ANGAJATI.LAST LOOP
    V_SALARII.EXTEND(1);
    
    SELECT SALARIU
    INTO V_SALARII(J)
    FROM ANGAJAT_DSI
    WHERE ID_ANGAJAT = V_ANGAJATI(I);
    
    V_TOTAL := V_TOTAL + V_SALARII(J);
    J := J+1;
    END LOOP;
    FOR I IN V_SALARII.FIRST..V_SALARII.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Angajatul cu id-ul ' || V_ANGAJATI(I) || ' are salariul ' || V_SALARII(I) || ' care reprezinta' || 100*V_SALARII(I)/V_TOTAL || '% din totalul salariilor angajatilor dati' );
    END LOOP;

END salariile;

PROCEDURE p2
AS
    CURSOR c IS
        (SELECT distinct problema, termen_limita, data_rezolvare
         from defect_dsi d, asigneaza_dsi a 
         where d.id_defect = a.id_defect and id_rezolvat = 1
       );
        v_problema defect_dsi.problema%TYPE;
        v_termen_limita asigneaza_dsi.termen_limita%TYPE;
        v_data_rezolvare defect_dsi.data_rezolvare%TYPE;
        v_diferenta NUMBER;
        v_medie NUMBER := null;
        v_total NUMBER := 0;
        v_nr_elemente NUMBER :=0;
    BEGIN
        OPEN c;
        loop
            fetch c into v_problema, v_termen_limita, v_data_rezolvare;
            exit when c%notfound;
            v_diferenta := v_data_rezolvare - v_termen_limita;
            if v_data_rezolvare > v_termen_limita then
                DBMS_OUTPUT.PUT_LINE('Designerii nu s-au descurcat si au intarziat cu ' || v_diferenta || ' zile in rezolvarea problemei: ' || v_problema );
                    v_total := v_total - v_diferenta;
            elsif v_diferenta > 0 then
                DBMS_OUTPUT.PUT_LINE('Designerii s-au descurcat si au terminat cu ' || v_diferenta || ' zile mai devreme de limita in rezolvarea problemei: ' || v_problema );
                    v_total := v_total + v_diferenta;
            else 
                DBMS_OUTPUT.PUT_LINE('Designerii s-au descurcat si au terminat exact la timp in rezolvarea problemei: ' || v_problema );
            end if;
        end loop;
            select count(*) into v_nr_elemente
            from defect_dsi where id_rezolvat = 1;
            v_medie := v_total / v_nr_elemente;
            DBMS_OUTPUT.PUT_LINE('Media eficientei designerilor este ' || v_medie);  
        close c;
END p2;

PROCEDURE p3
    (v_brand colaborator_dsi.brand%TYPE)
IS
    v_nume angajat_dsi.nume%TYPE;
BEGIN
    SELECT nume INTO v_nume
    FROM angajat_dsi a JOIN defect_dsi d ON (a.id_angajat = d.id_stylist)
                       JOIN piesa_dsi p ON (p.id_piesa = d.id_piesa)
                       JOIN colaborare_dsi c ON (p.id_colaborare = c.id_colaborare)
                       JOIN colaborator_dsi co ON (c.id_colaborator = co.id_colaborator)
    WHERE co.brand = v_brand;
    
    DBMS_OUTPUT.PUT_LINE('Numele stilistului care lucreaza in colaborare cu ' || v_brand ||' este ' || v_nume);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000, 'Nu exista firma cu numele dat');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Alta eroare!');
        
END p3;

END pachet1;
/

BEGIN 
    pachet1.p3('Zara');
END;
/
    