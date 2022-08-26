-- Для нуменрации используем оконную функцию ROW_NUMBER()
-- Что бы разделить индекс и остальную часть адреса используем регулярные выражения 
-- Для нахождения максимальной даты и исключеия ситуации когда у одного человека 2 действующих адреса с одинаковой датой

    SET SERVEROUTPUT ON
    DECLARE
    -- объявляем запись и массив для хранения результата динамического запроса
    --TYPE row_g IS record(Rn x#USER.id_user%TYPE, Fio x#user.C_FIO%TYPE, Adres x#address.c_address%TYPE, Index_adr x#address.c_address%TYPE);
    TYPE row_g IS record(Fio x#user.C_FIO%TYPE, Adres x#address.c_address%TYPE);
    TYPE tblGet IS TABLE OF row_g INDEX BY BINARY_INTEGER;
    tmp tblGet;
    
    
    sql_str VARCHAR2(1000);
    f_where_str VARCHAR2(1000);
    
    p_mode PLS_INTEGER := 1; 
    
    begin
    
        --EXECUTE IMMEDIATE 'CREATE TABLE TEMPORARY bonus (id NUMBER, amt NUMBER)';
        --EXECUTE IMMEDIATE 'DROP TABLE table_temp';
        sql_str := 'SELECT x#user.C_FIO as ФИО, 
                    x#address.c_address as АДРЕС
                    FROM x#user LEFT JOIN x#user_on_adress t1 ON t1.c_user_id = x#user.id_user
                    LEFT JOIN x#address ON t1.c_address_id=x#address.id_address ';
        if p_mode = 1 then
            f_where_str:= ' WHERE t1.c_end is null and (t1.c_begin, t1.id_reg)=(SELECT max(t2.c_begin), max(t2.id_reg)                    
                                          FROM x#user_on_adress t2 where t2.c_user_id = t1.c_user_id)';
            -- Соединяем таблицы, ищем максимальную дату адреса регистраии для гражданина
            -- Если одинаковых дат несколько, то берем с послденим id
        elsif p_mode = -1 then
            f_where_str:= ' WHERE c_address is null';
            -- Соединяем таблицы с помощью left join (что бы попали все записи из таблицы пользователей)
            -- выбираем граждан без адреса
        elsif p_mode = 0 then
            f_where_str:= ' WHERE (t1.c_begin, t1.id_reg)=(SELECT max(t2.c_begin), max(t2.id_reg)                    
                                          FROM x#user_on_adress t2 where t2.c_user_id = t1.c_user_id)';
            -- как понял необходимо вывести граждан без у которых есть адрес(но независимо от того действительный он или не действительный)
            -- запрос для всех граждан включая граждан без определенного места жительства на всякий случай привел ниже
        end if;
    -- Создадим временную таблицу для хранения значений
    
    EXECUTE IMMEDIATE 'CREATE GLOBAL TEMPORARY TABLE table_temp(Fio varchar2(100), Adres varchar2(4000))';
    
    EXECUTE IMMEDIATE sql_str||f_where_str BULK COLLECT
    INTO tmp;
 
    FOR m IN 1 .. tmp.COUNT LOOP
		-- записываем данные в таблицу
        EXECUTE IMMEDIATE 'INSERT INTO table_temp VALUES (:1, :2)' USING tmp(m).Fio, tmp(m).Adres;
    END LOOP;
        
    end;
		-- выводим содержимое временной таблицы и удаляем ее чтобы код можно было запустить повторно с другим значением p_mode
    SELECT ROW_NUMBER() OVER (ORDER BY Fio) as " ",Fio, REGEXP_REPLACE(Adres,'(,)([^,]*$)','') as АДРЕС, REGEXP_SUBSTR(Adres, '\s+(\S+)$') as ИНДЕКС
    FROM table_temp;
    DROP TABLE table_temp;
	
	--delete from x#user where rowid in (select a.rowid from x#user a, x#user b where a.rowid>b.rowid and a.C_FIO=b.C_FIO)