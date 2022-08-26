WITH kv AS (
           SELECT 'Аналитик:1#Разработчик:12#Тестировщик:10#Менеджер:3' str FROM dual),
	       y AS (
           SELECT regexp_count(str,'#')+1 cr FROM kv), -- находим количество решеток
	       z AS (
		   SELECT LEVEL mm FROM y -- счетчик решеток
		   CONNECT BY LEVEL <= y.cr)

select REGEXP_SUBSTR(q1.KEY,'[^:]+') as Ключ, TO_NUMBER(REGEXP_SUBSTR(q1.KEY, '(\d+)$')) as Значение from 	
(SELECT regexp_substr(kv.str,'[^#]+',1,z.mm) KEY
FROM kv, z) q1
ORDER BY Значение desc;

