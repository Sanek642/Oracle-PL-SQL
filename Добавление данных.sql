--Заполняем таблицу граждан

INSERT ALL 
	INTO x#user (id_user, C_FIO) VALUES (1,'Низов, Эмир, Ермолаевич')
	INTO x#user (id_user, C_FIO) VALUES (2,'Лекомцев, Иннокентий, Артемович')
	INTO x#user (id_user, C_FIO) VALUES (3,'Ермолова, Малика, Ефимовна')
	INTO x#user (id_user, C_FIO) VALUES (4,'Комраков, Мирослав, Артурович')
	INTO x#user (id_user, C_FIO) VALUES (5,'Копылов, Всеслав, Прокофиевич')
	INTO x#user (id_user, C_FIO) VALUES (6,'Макушев, Стефан, Моисеевич')
	INTO x#user (id_user, C_FIO) VALUES (7,'Лобанова, Полина, Павеловна')
	INTO x#user (id_user, C_FIO) VALUES (8,'Егорова, Татьяна, Юлиевна')
	INTO x#user (id_user, C_FIO) VALUES (9,'Валиева, Кира, Владленовна')
	INTO x#user (id_user, C_FIO) VALUES (10,'Кизюрина, Агата, Данисовна')
SELECT * FROM DUAL;
COMMIT;

-- всегда проверяю после добавления
SELECT * FROM x#user;

-- заполняем таблицу адресов
INSERT ALL 
	INTO x#address (id_address, c_address) VALUES (1, 'г. Озёры, пр. Ладыгина-93, кв. 1, 522228')
	INTO x#address (id_address, c_address) VALUES (2, 'г. Домодедово, пл. Гоголя-78, кв. 2, 139472')
	INTO x#address (id_address, c_address) VALUES (3, 'г. Дорохово, проезд Ладыгина-76, кв. 3, 049546')
	INTO x#address (id_address, c_address) VALUES (4, 'г. Шаховская, бульвар Косиора-4, кв. 4, 710994')
	INTO x#address (id_address, c_address) VALUES (5, 'г. Лотошино, пр. Бухарестская-48, 849533')
	INTO x#address (id_address, c_address) VALUES (6, 'г. Сергиев Посад, спуск Чехова-65, 049792')
	INTO x#address (id_address, c_address) VALUES (7, 'г. Коломна, въезд Славы-53, кв. 11, 609235')
	INTO x#address (id_address, c_address) VALUES (8, 'г. Волоколамск, наб. Будапештсткая-01, кв. 12, 854438')
	INTO x#address (id_address, c_address) VALUES (9, 'г. Волоколамск, пр. Космонавтов-97, кв. 145, 689997')
	INTO x#address (id_address, c_address) VALUES (10, 'г. Шатура, бульвар Будапештсткая-75, 615367')
	INTO x#address (id_address, c_address) VALUES (11, 'г. Можайск, ул. Будапештсткая-81, кв. 13, 694193')
	INTO x#address (id_address, c_address) VALUES (12, 'г. Видное, спуск Гоголя-35, 587956')
SELECT * FROM DUAL;
COMMIT;

SELECT * FROM x#address;

-- заполняем таблицу "прописки"

INSERT ALL
	-- добавим 2 адреса один действующий, другой нет
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (1, 1, 1, to_date('28.9.1981','dd.mm.yyyy'), to_date('28.9.1991','dd.mm.yyyy'))
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (2, 1, 2, to_date('29.9.1991','dd.mm.yyyy'), NULL)
	-- добавим граждан с действующими адресами
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (3, 2, 3, to_date('01.6.2011','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (4, 3, 4, to_date('02.7.2009','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (5, 4, 5, to_date('03.8.2008','dd.mm.yyyy'), NULL)
	-- добаим 2 действующих адреса 2 гражданам плюс адрес такой же максимальной датой
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (6, 5, 6, to_date('07.8.2013','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (7, 5, 7, to_date('05.12.2016','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (8, 6, 8, to_date('15.8.2016','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (9, 6, 9, to_date('27.12.2018','dd.mm.yyyy'), NULL)
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (10, 6, 10, to_date('27.12.2018','dd.mm.yyyy'), NULL)
	--Добавим гражданина с одним адресом, но не дейтсвующим
	INTO x#user_on_adress (id_reg, c_user_id, c_address_id, c_begin, c_end) VALUES (11, 7, 11, to_date('27.12.2019','dd.mm.yyyy'), to_date('27.12.2020','dd.mm.yyyy'))
SELECT * FROM DUAL;
COMMIT;

SELECT * FROM x#user_on_adress;