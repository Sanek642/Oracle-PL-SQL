-- Вывести одним запросом латинский алфавит в виде строчных букв, каждая буква - отдельная строка, без использования union.
-- Иcпользуем рекурсивный запрос UNION ALL часть синтаксиса

WITH alf (let) AS

(
  SELECT CHR(ASCII('a')) from dual -- получаем код символа для того чтобы было легче итерировать
  UNION ALL						   -- символическое объединение шагов
  SELECT CHR(ASCII(let)+1)		   			-- переходим к следующей букве и сохраняем ее как букву
    FROM alf WHERE ASCII(let) < ASCII('z')  -- условия выхода из рекурсии дошли до последней буквы
)

SELECT alf.let as БУКВЫ FROM alf;			-- выводим полученную таблицу

-- Можно так же решить циклом
begin
	FOR let IN ASCII('a')..ASCII('z')
		LOOP
			dbms_output.put_line(CHR(let));   
		END LOOP;
end;