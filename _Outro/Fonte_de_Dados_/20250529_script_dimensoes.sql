/*DROP TABLE IF EXISTS dimtempo;
CREATE TABLE Temp_dimtempo (
        idDimtempo         INTEGER PRIMARY KEY,  -- year*10000+month*100+day
        data                DATE NOT NULL,
        ano                 INTEGER NOT NULL,
        mes                 INTEGER NOT NULL, -- 1 to 12
        dia                 INTEGER NOT NULL, -- 1 to 31
        bimestre            INTEGER NOT NULL, -- 1 to 4
        semestre            INTEGER NOT NULL, -- 1 to 4
        NomeDia             VARCHAR(9) NOT NULL, -- 'Monday', 'Tuesday'...
        NomeMes             VARCHAR(9) NOT NULL, -- 'January', 'February'...
        FinaldeSemana       CHAR(1) DEFAULT 'F' CHECK (finaldesemana in ('T', 'F'))
) Engine=InnoDB;
*/
DROP PROCEDURE IF EXISTS carga_dimensao_tempo;
DELIMITER //
CREATE PROCEDURE carga_dimensao_tempo(IN startdate DATE,IN stopdate DATE)
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
            DATE_FORMAT(currentdate,'%M'),
            CASE DAYOFWEEK(currentdate) WHEN 1 THEN 'T' WHEN 7 then 'T' ELSE 'F' END
            );
        SET currentdate = ADDDATE(currentdate,INTERVAL 1 DAY);
    END WHILE;
END
//
DELIMITER ; 

-- delete from  dimtempo;
CALL carga_dimensao_tempo('1991-01-01','2025-12-31');

Select * from mmdtribunal.dim_tempo limit 1000;

-- select * from mmdtribunal.dim_status;

-- carga dim_assuntos
truncate table mmdtribunal.dim_assuntos;
insert into mmdtribunal.dim_assuntos (Nome_assuntos)
select distinct trim((descricao_assunto))
from stgtribunal.dim_assuntos;
-- select distinct (Status) from stgtribunal.Processos_Tribunais;

-- carga dim_classe
truncate table mmdtribunal.dim_classe;
insert into mmdtribunal.dim_classe (Nome_ultima_classe)
select distinct trim((nome_da_ultima_classe))
from stgtribunal.dim_classe;
-- select distinct (tribunal) from stgtribunal.Processos_Tribunais;

-- carga dim_formato
truncate table mmdtribunal.dim_formato;
insert into mmdtribunal.dim_formato (Nome_formato)
select distinct trim((formato))
from stgtribunal.dim_formato;

-- carga dim_orgao
truncate table mmdtribunal.dim_orgao;
insert into mmdtribunal.dim_orgao (Nome_Orgao)
select distinct trim((nome_orgao))
from stgtribunal.dim_orgao;

-- carga dim_status
truncate table mmdtribunal.dim_status;
insert into mmdtribunal.dim_status (Status)
select distinct trim((status))
from stgtribunal.dim_status;

-- carga dim_tribunal 
truncate table mmdtribunal.dim_tribunal;
insert into mmdtribunal.dim_tribunal (Nome_tribunal)
select distinct trim((tribunal))
from stgtribunal.dim_tribunal;

