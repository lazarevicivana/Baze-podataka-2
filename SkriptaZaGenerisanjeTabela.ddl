
CREATE TABLE adresa (
    id     NUMBER NOT NULL,
    grad   VARCHAR2(40 CHAR),
    ulica  VARCHAR2(40 CHAR),
    broj   INTEGER,
    drzava VARCHAR2(40 CHAR)
);

ALTER TABLE adresa ADD CONSTRAINT adresa_pk PRIMARY KEY ( id );

CREATE TABLE cena (
    id          NUMBER NOT NULL,
    cenausl     INTEGER,
    cenovnik_id NUMBER
);

ALTER TABLE cena ADD CONSTRAINT cena_pk PRIMARY KEY ( id );

CREATE TABLE cenovnik (
    id   NUMBER NOT NULL,
    datp DATE,
    datk DATE
);

ALTER TABLE cenovnik ADD CONSTRAINT cenovnik_pk PRIMARY KEY ( id );

CREATE TABLE ima_cenu (
    usluga_id NUMBER NOT NULL,
    cena_id   NUMBER NOT NULL
);

ALTER TABLE ima_cenu ADD CONSTRAINT ima_cenu_pk PRIMARY KEY ( usluga_id,
                                                              cena_id );

CREATE TABLE imalicencu (
    kozmeticar_mbr NUMBER NOT NULL,
    mbf            NUMBER NOT NULL,
    usluga_id      NUMBER NOT NULL,
    licenca_id     NUMBER NOT NULL
);

ALTER TABLE imalicencu
    ADD CONSTRAINT imalicencu_pk PRIMARY KEY ( kozmeticar_mbr,
                                               mbf,
                                               usluga_id,
                                               licenca_id );

CREATE TABLE klijent (
    id  NUMBER NOT NULL,
    ime VARCHAR2(20 CHAR),
    prz VARCHAR2(20 CHAR),
    tel VARCHAR2(20 CHAR)
);

ALTER TABLE klijent ADD CONSTRAINT klijent_pk PRIMARY KEY ( id );

CREATE TABLE kozmeticar (
    mbr NUMBER NOT NULL
);

ALTER TABLE kozmeticar ADD CONSTRAINT kozmeticar_pk PRIMARY KEY ( mbr );

CREATE TABLE kozmeticki_salon (
    mbf       NUMBER NOT NULL,
    pib       NUMBER,
    naziv     VARCHAR2(50 CHAR),
    adresa_id NUMBER
);

ALTER TABLE kozmeticki_salon ADD CONSTRAINT kozmeticki_salon_pk PRIMARY KEY ( mbf );

CREATE TABLE kurs (
    drzikurs    NUMBER NOT NULL,
    pohadjakurs NUMBER NOT NULL
);

ALTER TABLE kurs ADD CONSTRAINT kurs_pk PRIMARY KEY ( drzikurs,
                                                      pohadjakurs );

CREATE TABLE licenca (
    id    NUMBER NOT NULL,
    naziv VARCHAR2(50 CHAR)
);

ALTER TABLE licenca ADD CONSTRAINT licenca_pk PRIMARY KEY ( id );

CREATE TABLE menadzer (
    mbr NUMBER NOT NULL
);

ALTER TABLE menadzer ADD CONSTRAINT menadzer_pk PRIMARY KEY ( mbr );

CREATE TABLE nudi (
    mbf       NUMBER NOT NULL,
    usluga_id NUMBER NOT NULL
);

ALTER TABLE nudi ADD CONSTRAINT nudi_pk PRIMARY KEY ( mbf,
                                                      usluga_id );

CREATE TABLE obavlja (
    kozmeticar_mbr NUMBER NOT NULL,
    mbf            NUMBER NOT NULL,
    usluga_id      NUMBER NOT NULL
);

ALTER TABLE obavlja
    ADD CONSTRAINT obavlja_pk PRIMARY KEY ( kozmeticar_mbr,
                                            mbf,
                                            usluga_id );

CREATE TABLE odrzava (
    kozmeticar_mbr NUMBER NOT NULL,
    uredjaj_id     NUMBER NOT NULL
);

ALTER TABLE odrzava ADD CONSTRAINT odrzava_pk PRIMARY KEY ( kozmeticar_mbr,
                                                            uredjaj_id );

CREATE TABLE oprema (
    id           NUMBER NOT NULL,
    kol          INTEGER,
    proiz        VARCHAR2(50 CHAR),
    tip          VARCHAR2(10) NOT NULL,
    naziv        VARCHAR2(50),
    mbf          NUMBER,
    menadzer_mbr NUMBER
);

ALTER TABLE oprema
    ADD CONSTRAINT ch_inh_oprema CHECK ( tip IN ( 'Potrosna', 'Uredjaj' ) );

ALTER TABLE oprema ADD CONSTRAINT oprema_pk PRIMARY KEY ( id );

CREATE TABLE potrosna (
    id NUMBER NOT NULL
);

ALTER TABLE potrosna ADD CONSTRAINT potrosna_pk PRIMARY KEY ( id );

CREATE TABLE radnik (
    mbr       NUMBER NOT NULL,
    ime       VARCHAR2(30 CHAR),
    prz       VARCHAR2(40 CHAR),
    email     VARCHAR2(40 CHAR),
    mbf       NUMBER,
    zan       VARCHAR2(12) NOT NULL,
    adresa_id NUMBER
);

ALTER TABLE radnik
    ADD CONSTRAINT ch_inh_radnik CHECK ( zan IN ( 'Kozmeticar', 'Menadzer' ) );

ALTER TABLE radnik ADD CONSTRAINT radnik_pk PRIMARY KEY ( mbr );

CREATE TABLE recenzija (
    id         NUMBER NOT NULL,
    ocena      INTEGER,
    opis       VARCHAR2(50),
    klijent_id NUMBER NOT NULL
);

ALTER TABLE recenzija ADD CONSTRAINT recenzija_pk PRIMARY KEY ( id,
                                                                klijent_id );

CREATE TABLE termin (
    id         NUMBER NOT NULL,
    datp       DATE,
    datk       DATE,
    klijent_id NUMBER
);

ALTER TABLE termin ADD CONSTRAINT termin_pk PRIMARY KEY ( id );

CREATE TABLE trosi (
    potrosna_id NUMBER NOT NULL,
    termin_id   NUMBER NOT NULL,
    kolpo       INTEGER
);

ALTER TABLE trosi ADD CONSTRAINT trosi_pk PRIMARY KEY ( potrosna_id,
                                                        termin_id );

CREATE TABLE uredjaj (
    id NUMBER NOT NULL
);

ALTER TABLE uredjaj ADD CONSTRAINT uredjaj_pk PRIMARY KEY ( id );

CREATE TABLE usluga (
    id    NUMBER NOT NULL,
    naziv VARCHAR2(50 CHAR)
);

ALTER TABLE usluga ADD CONSTRAINT usluga_pk PRIMARY KEY ( id );

CREATE TABLE vrsi (
    kozmeticar_mbr NUMBER NOT NULL,
    mbf            NUMBER NOT NULL,
    usluga_id      NUMBER NOT NULL,
    termin_id      NUMBER NOT NULL
);

ALTER TABLE vrsi
    ADD CONSTRAINT vrsi_pk PRIMARY KEY ( kozmeticar_mbr,
                                         mbf,
                                         usluga_id,
                                         termin_id );

ALTER TABLE cena
    ADD CONSTRAINT cena_cenovnik_fk FOREIGN KEY ( cenovnik_id )
        REFERENCES cenovnik ( id );

ALTER TABLE ima_cenu
    ADD CONSTRAINT ima_cenu_cena_fk FOREIGN KEY ( cena_id )
        REFERENCES cena ( id );

ALTER TABLE ima_cenu
    ADD CONSTRAINT ima_cenu_usluga_fk FOREIGN KEY ( usluga_id )
        REFERENCES usluga ( id );

ALTER TABLE imalicencu
    ADD CONSTRAINT imalicencu_licenca_fk FOREIGN KEY ( licenca_id )
        REFERENCES licenca ( id );

ALTER TABLE imalicencu
    ADD CONSTRAINT imalicencu_obavlja_fk FOREIGN KEY ( kozmeticar_mbr,
                                                       mbf,
                                                       usluga_id )
        REFERENCES obavlja ( kozmeticar_mbr,
                             mbf,
                             usluga_id );

ALTER TABLE kozmeticar
    ADD CONSTRAINT kozmeticar_radnik_fk FOREIGN KEY ( mbr )
        REFERENCES radnik ( mbr );

ALTER TABLE kozmeticki_salon
    ADD CONSTRAINT kozmeticki_salon_adresa_fk FOREIGN KEY ( adresa_id )
        REFERENCES adresa ( id );

ALTER TABLE kurs
    ADD CONSTRAINT kurs_kozmeticar_fk FOREIGN KEY ( drzikurs )
        REFERENCES kozmeticar ( mbr );

ALTER TABLE kurs
    ADD CONSTRAINT kurs_kozmeticar_fkv1 FOREIGN KEY ( pohadjakurs )
        REFERENCES kozmeticar ( mbr );

ALTER TABLE menadzer
    ADD CONSTRAINT menadzer_radnik_fk FOREIGN KEY ( mbr )
        REFERENCES radnik ( mbr );

ALTER TABLE nudi
    ADD CONSTRAINT nudi_kozmeticki_salon_fk FOREIGN KEY ( mbf )
        REFERENCES kozmeticki_salon ( mbf );

ALTER TABLE nudi
    ADD CONSTRAINT nudi_usluga_fk FOREIGN KEY ( usluga_id )
        REFERENCES usluga ( id );

ALTER TABLE obavlja
    ADD CONSTRAINT obavlja_kozmeticar_fk FOREIGN KEY ( kozmeticar_mbr )
        REFERENCES kozmeticar ( mbr );

ALTER TABLE obavlja
    ADD CONSTRAINT obavlja_nudi_fk FOREIGN KEY ( mbf,
                                                 usluga_id )
        REFERENCES nudi ( mbf,
                          usluga_id );

ALTER TABLE odrzava
    ADD CONSTRAINT odrzava_kozmeticar_fk FOREIGN KEY ( kozmeticar_mbr )
        REFERENCES kozmeticar ( mbr );

ALTER TABLE odrzava
    ADD CONSTRAINT odrzava_uredjaj_fk FOREIGN KEY ( uredjaj_id )
        REFERENCES uredjaj ( id );

ALTER TABLE oprema
    ADD CONSTRAINT oprema_kozmeticki_salon_fk FOREIGN KEY ( mbf )
        REFERENCES kozmeticki_salon ( mbf );

ALTER TABLE oprema
    ADD CONSTRAINT oprema_menadzer_fk FOREIGN KEY ( menadzer_mbr )
        REFERENCES menadzer ( mbr );

ALTER TABLE potrosna
    ADD CONSTRAINT potrosna_oprema_fk FOREIGN KEY ( id )
        REFERENCES oprema ( id );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_adresa_fk FOREIGN KEY ( adresa_id )
        REFERENCES adresa ( id );

ALTER TABLE radnik
    ADD CONSTRAINT radnik_kozmeticki_salon_fk FOREIGN KEY ( mbf )
        REFERENCES kozmeticki_salon ( mbf );

ALTER TABLE recenzija
    ADD CONSTRAINT recenzija_klijent_fk FOREIGN KEY ( klijent_id )
        REFERENCES klijent ( id );

ALTER TABLE termin
    ADD CONSTRAINT termin_klijent_fk FOREIGN KEY ( klijent_id )
        REFERENCES klijent ( id );

ALTER TABLE trosi
    ADD CONSTRAINT trosi_potrosna_fk FOREIGN KEY ( potrosna_id )
        REFERENCES potrosna ( id );

ALTER TABLE trosi
    ADD CONSTRAINT trosi_termin_fk FOREIGN KEY ( termin_id )
        REFERENCES termin ( id );

ALTER TABLE uredjaj
    ADD CONSTRAINT uredjaj_oprema_fk FOREIGN KEY ( id )
        REFERENCES oprema ( id );

ALTER TABLE vrsi
    ADD CONSTRAINT vrsi_obavlja_fk FOREIGN KEY ( kozmeticar_mbr,
                                                 mbf,
                                                 usluga_id )
        REFERENCES obavlja ( kozmeticar_mbr,
                             mbf,
                             usluga_id );

ALTER TABLE vrsi
    ADD CONSTRAINT vrsi_termin_fk FOREIGN KEY ( termin_id )
        REFERENCES termin ( id );

CREATE OR REPLACE TRIGGER arc_fkarc_1_potrosna BEFORE
    INSERT OR UPDATE OF id ON potrosna
    FOR EACH ROW
DECLARE
    d VARCHAR2(10);
BEGIN
    SELECT
        a.tip
    INTO d
    FROM
        oprema a
    WHERE
        a.id = :new.id;

    IF ( d IS NULL OR d <> 'Potrosna' ) THEN
        raise_application_error(-20223, 'FK Potrosna_Oprema_FK in Table Potrosna violates Arc constraint on Table Oprema - discriminator column Tip doesn''t have value ''Potrosna'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_1_uredjaj BEFORE
    INSERT OR UPDATE OF id ON uredjaj
    FOR EACH ROW
DECLARE
    d VARCHAR2(10);
BEGIN
    SELECT
        a.tip
    INTO d
    FROM
        oprema a
    WHERE
        a.id = :new.id;

    IF ( d IS NULL OR d <> 'Uredjaj' ) THEN
        raise_application_error(-20223, 'FK Uredjaj_Oprema_FK in Table Uredjaj violates Arc constraint on Table Oprema - discriminator column Tip doesn''t have value ''Uredjaj'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_kozmeticar BEFORE
    INSERT OR UPDATE OF mbr ON kozmeticar
    FOR EACH ROW
DECLARE
    d VARCHAR2(12);
BEGIN
    SELECT
        a.zan
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr;

    IF ( d IS NULL OR d <> 'Kozmeticar' ) THEN
        raise_application_error(-20223, 'FK Kozmeticar_Radnik_FK in Table Kozmeticar violates Arc constraint on Table Radnik - discriminator column Zan doesn''t have value ''Kozmeticar'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_2_menadzer BEFORE
    INSERT OR UPDATE OF mbr ON menadzer
    FOR EACH ROW
DECLARE
    d VARCHAR2(12);
BEGIN
    SELECT
        a.zan
    INTO d
    FROM
        radnik a
    WHERE
        a.mbr = :new.mbr;

    IF ( d IS NULL OR d <> 'Menadzer' ) THEN
        raise_application_error(-20223, 'FK Menadzer_Radnik_FK in Table Menadzer violates Arc constraint on Table Radnik - discriminator column Zan doesn''t have value ''Menadzer'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            23
-- CREATE INDEX                             0
-- ALTER TABLE                             53
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           4
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
