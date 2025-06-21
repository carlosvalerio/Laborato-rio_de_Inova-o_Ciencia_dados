USE mmdtribunal;

INSERT INTO mmdtribunal.fato_processo (
  Cod_assuntos, Cod_ultima_classe, Cod_formato, Cod_orgao, 
  Cod_status, Cod_tempo, Cod_tribunal, Qt_Processos, Qt_dias_antiguidade
)
SELECT 
  da.Cod_assuntos,
  dc.Cod_ultima_classe,
  df.Cod_formato,
  dg.Cod_orgao,
  ds.Cod_status,
  dtemp.Cod_tempo,
  dt.Cod_tribunal,
  COUNT(stg.Processos) AS Qt_Processos,
  SUM(stg.dias_antiguidade) AS Qt_dias_antiguidade
FROM stgtribunal.processostribunais stg
INNER JOIN mmdtribunal.dim_assuntos da ON stg.Nome_assuntos = da.Nome_assuntos
INNER JOIN mmdtribunal.dim_classe dc ON stg.Nome_ultima_classe = dc.Nome_ultima_classe
INNER JOIN mmdtribunal.dim_formato df ON stg.Nome_formato = df.Nome_formato
INNER JOIN mmdtribunal.dim_orgao dg ON stg.Nome_orgao = dg.Nome_orgao
INNER JOIN mmdtribunal.dim_status ds ON stg.Status = ds.Status
INNER JOIN mmdtribunal.dim_tempo dtemp ON stg.Data = dtemp.Data
INNER JOIN mmdtribunal.dim_tribunal dt ON stg.Nome_tribunal = dt.Nome_tribunal
GROUP BY 
  da.Cod_assuntos,
  dc.Cod_ultima_classe,
  df.Cod_formato,
  dg.Cod_orgao,
  ds.Cod_status,
  dtemp.Cod_tempo,
  dt.Cod_tribunal;
