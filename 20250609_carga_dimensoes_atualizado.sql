/*DROP TABLE IF EXISTS dim_tempo;
CREATE TABLE Temp_dimtempo (
        idDimtempo         INTEGER PRIMARY KEY,  -- year*10000+month*100+day
        data                DATE NOT NULL,
        ano                 INTEGER NOT NULL,
        mes                 INTEGER NOT NULL, -- 1 to 12
        dia                 INTEGER NOT NULL, -- 1 to 31
        bimestre            INTEGER NOT NULL, -- 1 to 4
        semestre            INTEGER NOT NULL, -- 1 to 4
        NomeDia             VARCHAR(9) NOT NULL, -- 'Monday', 'Tuesday'...
        NomeMes             VARCHAR(9) NOT NULL -- 'January', 'February'...
) Engine=InnoDB;
*/
DROP PROCEDURE IF EXISTS carga_dim_tempo;
DELIMITER //
CREATE PROCEDURE carga_dim_tempo(IN startdate DATE,IN stopdate DATE)
BEGIN
    DECLARE currentdate DATE;
    SET currentdate = startdate;
    WHILE currentdate <= stopdate DO
        INSERT INTO dim_tempo VALUES (
            YEAR(currentdate)*10000+MONTH(currentdate)*100 + DAY(currentdate),
            currentdate,
            YEAR(currentdate),
            MONTH(currentdate),
            DAY(currentdate),
			FLOOR(1 + (month(currentdate) - 1) / 2), #bimestre
            FLOOR(1 + (month(currentdate) - 1) / 6), #semestre
            DATE_FORMAT(currentdate,'%W'),
            DATE_FORMAT(currentdate,'%M')
            );
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END
//
DELIMITER ; 

-- delete from  dimtempo;
CALL carga_dim_tempo('1991-01-01','2025-12-31');

Select * from mmdtribunal.dim_tempo limit 1000;

-- select * from mmdtribunal.dim_status;

-- carga dim_assuntos
delete from mmdtribunal.dim_assuntos; 
insert into mmdtribunal.dim_assuntos (Nome_assuntos)
select distinct trim((Nome_assuntos))
from stgtribunal.processostribunais;
-- select distinct (Status) from stgtribunal.Processos_Tribunais;

-- carga dim_classe
delete from mmdtribunal.dim_classe;
insert into mmdtribunal.dim_classe (Nome_ultima_classe)
select distinct trim((Nome_ultima_classe))
from stgtribunal.processostribunais;
-- select distinct (tribunal) from stgtribunal.Processos_Tribunais;

-- carga dim_formato
delete from mmdtribunal.dim_formato;
insert into mmdtribunal.dim_formato (Nome_formato)
select distinct trim((Nome_formato))
from stgtribunal.processostribunais;

-- carga dim_orgao
delete from mmdtribunal.dim_orgao;
insert into mmdtribunal.dim_orgao (Nome_Orgao)
select distinct trim((Nome_Orgao))
from stgtribunal.processostribunais;

-- carga dim_status
delete from mmdtribunal.dim_status;
insert into mmdtribunal.dim_status (Status)
select distinct trim((Status))
from stgtribunal.processostribunais;

-- carga dim_tribunal 
delete from mmdtribunal.dim_tribunal;
insert into mmdtribunal.dim_tribunal (Nome_tribunal)
select distinct trim((Nome_tribunal))
from stgtribunal.processostribunais;

select *
from processostribunais;

select *
from dim_assuntos;

select *
from dim_classe;

select *
from dim_formato;

select *
from dim_orgao;

select *
from dim_status;

select *
from dim_tempo;

select * 
from dim_tribunal;

select *
from fato_processo;

select count(*) from processostribunais;




