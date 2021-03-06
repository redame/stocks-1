CREATE OR REPLACE FUNCTION public.f_comm(qua BIGINT)
  RETURNS NUMERIC
AS
$BODY$
SELECT GREATEST(1.5, qua * .005);
$BODY$
LANGUAGE SQL VOLATILE;


CREATE OR REPLACE FUNCTION public.f_comm_qua(amt NUMERIC, dist NUMERIC)
  RETURNS BIGINT
AS
$BODY$
SELECT CASE
       WHEN dist > 0
         THEN FLOOR(LEAST((amt - 1.5) / dist, amt / (dist + 0.005))) :: BIGINT
       ELSE CEIL(GREATEST((amt - 1.5) / dist, amt / (dist - 0.005))) :: BIGINT
       END
$BODY$
LANGUAGE SQL VOLATILE;