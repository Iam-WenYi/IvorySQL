-- sanity check of system catalog
CREATE TABLE identity_aways (
	id NUMBER GENERATED ALWAYS AS IDENTITY,
	description text
);
INSERT INTO identity_aways (description) VALUES ('Just DESCRIPTION');--ok
INSERT INTO identity_aways (id, description) VALUES (NULL, 'ID=NULL and DESCRIPTION');--error
INSERT INTO identity_aways (id, description) VALUES (999, 'ID=999 and DESCRIPTION');--error
UPDATE identity_aways SET ID=2 WHERE ID=1;--error
SELECT * FROM identity_aways;
DROP TABLE identity_aways;

--by default
CREATE TABLE identity_default (
	id NUMBER GENERATED BY DEFAULT AS IDENTITY,
	description text
);
INSERT INTO identity_default (description) VALUES ('Just DESCRIPTION');--ok
INSERT INTO identity_default (id, description) VALUES (999, 'ID=999 and DESCRIPTION');--ok
INSERT INTO identity_default (id, description) VALUES (NULL, 'ID=NULL and DESCRIPTION');--error
UPDATE identity_default SET ID=2 WHERE ID=1;--ok
UPDATE identity_default SET ID=NULL WHERE ID=2;--error
SELECT * FROM identity_default;
DROP TABLE identity_default;


--BY DEFAULT ON NULL
CREATE TABLE identity_default_null (
	id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
	description text
);
INSERT INTO identity_default_null (description) VALUES ('Just DESCRIPTION');
INSERT INTO identity_default_null (id, description) VALUES (999, 'ID=999 and DESCRIPTION');
INSERT INTO identity_default_null (id, description) VALUES (NULL, 'ID=NULL and DESCRIPTION');
UPDATE identity_default_null SET ID=3 WHERE ID=1;
UPDATE identity_default_null SET ID=NULL WHERE ID=3;--error
SELECT * FROM identity_default_null;
DROP TABLE identity_default_null;

--test identity_option clause
CREATE TABLE identity_3(
	id		  int GENERATED BY DEFAULT AS IDENTITY INCREMENT by 2,
	description text
);
INSERT INTO identity_3 (description) VALUES ('one DESCRIPTION');
INSERT INTO identity_3 (description) VALUES ('second DESCRIPTION');
SELECT * FROM identity_3;
DROP TABLE identity_3;


--test mutiple identity column
CREATE TABLE itest1 (a int generated by default as identity start with 1 increment by 2,
							b text generated always as identity start with 1);--error

--more data type support
CREATE TABLE itest_float (a float generated by default on null as identity start with 1 increment by 2, b text);
CREATE TABLE itest_double (a double precision generated by default on null as identity start with 1 increment by 2, b text);
CREATE TABLE itest_real (a real generated by default on null as identity start with 1 increment by 2, b text);
CREATE TABLE itest_numeric (a numeric generated by default on null as identity start with 1 increment by 2, b text);
CREATE TABLE itest_decimal (a decimal generated by default on null as identity start with 1 increment by 2, b text);

drop table itest_float;
drop table itest_double;
drop table itest_real;
drop table itest_numeric;
drop table itest_decimal;


--test ALTER TABLE
CREATE TABLE itest13 (a int);
ALTER TABLE itest13 ADD (b int GENERATED BY DEFAULT AS IDENTITY);
ALTER TABLE itest13 modify (b DROP IDENTITY);
drop table itest13;

CREATE TABLE itest_alter (a int);
-- add column to empty table
ALTER TABLE itest_alter ADD (b int GENERATED BY DEFAULT AS IDENTITY);
ALTER TABLE itest_alter MODIFY (b GENERATED BY DEFAULT ON NULL AS IDENTITY
(START WITH 1000
INCREMENT BY 3
MAXVALUE 5000
CACHE 20
CYCLE)
);
ALTER TABLE itest_alter MODIFY(b DROP IDENTITY);
insert into itest_alter(a) values (1);
drop table itest_alter;

--Test column type conversion
CREATE TABLE t2 (id smallint GENERATED BY DEFAULT AS IDENTITY START WITH 100 INCREMENT BY 10);
INSERT INTO t2 VALUES(32768);--ok
DROP TABLE t2;

--test partition table
CREATE TABLE pagg_tab1(x int GENERATED ALWAYS AS IDENTITY START WITH 2 INCREMENT BY 10, y int) PARTITION BY RANGE(x);
CREATE TABLE pagg_tab1_p1 PARTITION OF pagg_tab1 FOR VALUES FROM (0) TO (10);
CREATE TABLE pagg_tab1_p2 PARTITION OF pagg_tab1 FOR VALUES FROM (10) TO (20);
insert into pagg_tab1(y) values (1);
insert into pagg_tab1(y) values (1);
SELECT * FROM pagg_tab1_p1;
SELECT * FROM pagg_tab1_p2;
DROP TABLE pagg_tab1;

--test the order/noodrer
CREATE TABLE itest_order (a int generated by default on null as identity start with 1 increment by 2 order, b text);--ok
CREATE TABLE itest_order_noorder (a int generated by default on null as identity start with 1 increment by 2 order noorder, b text);--error
CREATE TABLE itest_muti_order (a int generated by default on null as identity start with 1 increment by 2 order order, b text);--error
CREATE TABLE itest_muti_order (a int generated by default on null as identity start with 1 increment by 2 noorder noorder, b text);--error
DROP TABLE itest_order;
create table cycle2(userid number generated always as identity maxvalue -5 minvalue -10 start with -7  increment by -2 cycle nocache,uname varchar2(20));
create table cycle3(userid number generated BY DEFAULT as identity maxvalue -5 minvalue -10 start with -7  increment by -2 cycle nocache,uname varchar2(20));
create table cycle4(userid number generated BY DEFAULT ON NULL as identity maxvalue -5 minvalue -10 start with -7  increment by -2 cycle nocache,uname varchar2(20));
DROP TABLE cycle2;
DROP TABLE cycle3;
DROP TABLE cycle4;
CREATE TABLE idcol_alter2(userid number generated always as identity  start with 2,uname varchar2(20));
INSERT INTO idcol_alter2 (uname) VALUES ('xiaodong');
ALTER TABLE idcol_alter2 modify userid drop identity;
INSERT INTO idcol_alter2 (uname) VALUES ('xiaohong');
