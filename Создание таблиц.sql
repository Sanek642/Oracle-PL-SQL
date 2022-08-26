-- Для выполнения задания использовал sqlfiddle версия СУБД 11gR2, к сожалению IDENTITY пока еще не доступен id ввожу вручную
-- создаем таблицы
-- Таблица граждан
CREATE TABLE x#user
(
  id_user number PRIMARY KEY, -- идентификатор гражданина
  C_FIO varchar2(100) NOT NULL /* ФИО гражданина – формат строки: 
                                * фамилия, имя, отчество через запятую
                                */
);

-- Таблица адресов
CREATE TABLE x#address
(
  id_address number primary key, -- идентификатор адреса прописки
  c_address varchar2(4000) NOT NULL /* формат адреса: город, улица, дом, 
                                     * квартира, почтовый индекс в указанном 
                                     * порядке через запятую
                                     */
);

-- Таблица прописок
CREATE TABLE x#user_on_adress
(
  id_reg number primary key, -- идентификатор прописки
  c_user_id number not null, -- идентификатор гражданина
  c_address_id number not null, -- идентификатор адреса прописки
  c_begin date not null, -- дата прописки
  c_end date, -- дата выписки
  -- создаем ограничения для внешних ключей
  CONSTRAINT fk_user FOREIGN KEY (c_user_id) REFERENCES x#user(id_user),
  CONSTRAINT fk_address FOREIGN KEY (c_address_id) REFERENCES x#address(id_address)                                                 
);