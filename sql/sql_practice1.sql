#
#데이터베이스 사용자 테이블 조회
desc mysql.user;
describe mysql.user;

show full columns from mysql.user;

#mysql.user - 테이블명 / User, Host- 필드명
select User, Host 
	from mysql.user;

#로컬 PC에서만 접속 사능한 사용자 만들기 / 사용 중인 노트북에서만 가능
#localhost - 로컬 PC
#create user '아이디'@'접근가능한 주소'identified by '비밀번호';
create user 'test'@'localhost' identified by '1234';

#어디서든 접속 가능(%)한 사용자 만들기
# % - wildcard
create user 'anywhere'@'%'identified by '1234';

#특정 IP대역(192.168.0.X)에서만 접속 가능한 사용자
create user 'test2'@'192.168.0.%' identified by '1234';
select user, host from mysql.user;
#나중에 프로젝트할 때 실제 비밀번호를 입력했으면 git hub에 올리지 않도록 주의 ! -> git ignore

#이미 존재하는 사용자 이름을 삭제하고 다시 만들기 - or replace
create or replace user '
test'@'localhost' identified by '1234';
select user, host from mysql.user;

#같은 이름의 사용자가 없을 때만 사용자 추가 - if not exists
create user if not exists 'test'@'localhost'identified by '1234';
SELECT User, Host FROM mysql.user;

#사용자 이름 변경하기 - rename A to B
RENAME USER 'test2'@'192.168.0.%'TO 'test3'@'%';
SELECT User, Host FROM mysql.user;

#사용자 비밀번호 변경 
#비밀번호 조회 기능은 없어서 변경만 가능
SET PASSWORD FOR 'test3'@'%' = PASSWORD('12345');
SELECT User, Host FROM mysql.user;

#사용자 삭제 - drop
DROP USER 'test3'@'%';
SELECT User, Host FROM mysql.user;

#사용자 조건에 따라 삭제 - if exist
#존재할 경우에만 사용자 삭제되도록
DROP USER IF EXISTS 'anywhere'@'%';

#사용자에게 권한 부여하기 
#기존 권한 확인
SHOW GRANTS FOR 'test'@'localhost';

#데이터베이스 test의 모든 테이블 *에 대해서 사용자 권한 부여
GRANT ALL PRIVILEGES ON test.*TO 'test'@'localhost';

flush privileges;

#사용자 권한 제거 
REVOKE ALL on test.*FROM 'test'@'localhost';
flush privileges;
SHOW GRANTS FOR 'test'@'localhost';

#데이터베이스 목록 조회
show databases; 

#데이터베이스 TEST라는 이름으로 생성
create database test;

#가지고 있는 모든 데이터베이스 목록 조회
SHOW DATABASES;

#같은 이름의 데이터베이스가 존재하지 않을 때만 데이터베이스 생성
create databases if not exists test;

#특수문자가 함되는 경우에 에러 발생
#억음부호 혹은 grave(`)를 사용해서 생성
CREATE DATABASE `test.test`;

#데이터베이스 삭제
DROP DATABASE `test.test`;
SHOW DATABASES;

#데이터베이스 명칭 변경
#사실 애초에 데이터 명칭을 잘 지어야 함
mysqldump -u root -p test > test.sql;

#변경할 명칭으로 데이터베이스 생성
create database if not exists test1;

mysqldump -u root -p test < test.sql


#테이블 만들기 준비
#python이라는 데이터 베이스 생성
CREATE DATABASE python;
#앞으로 테이블은 python 안에서 찾으면 된다는 명령
USE python;

#테이블 만들기
#table1이란 명칭의 테이블 생성
#column이 하나도 없으면 만들어 지지 않아서 적어도 하나의 column을 입력
CREATE TABLE table1 (column1 VARCHAR(100));

#위에use라는 명령어 쓰지 않았으면
CREATE TABLE python.table1 (column1 VARCHAR(100));

#테이블 목록 조회
#테이블을 확인 전에 사용중인 데이터 베이스를 먼저 확인 해야함
#사용중인 데이터베이스 확인
SELECT DATABASE();

#테이블 목록 조회
SHOW TABLES;

#테이블 이름 변경
RENAME TABLE table1 TO table2;
SHOW TABLES;

#테이블 삭제
DROP TABLE table2;
SHOW TABLES;

#테이블 생성 - 열 추가, 삭제 등 해볼 테스트 테이블
CREATE TABLE test_table(
	test_column1 INT,
    test_column2 INT,
    test_column3 INT
);
#만든 테이블의 필드 조회
desc test_table;

#테이블에 column 추가하기 / 제일 뒤에 추가됨
ALTER TABLE test_table
ADD test_column4 INT;

DESC test_table;

#여러개의 column을 한 번에 추가
ALTER TABLE test_table
ADD(
    test_column5 INT,
    test_column6 INT,
    test_column7 INT
);

#테이블에서 column 삭제
ALTER TABLE test_table 
DROP test_column1;
DESC test_table;

#column 순서 변경(맨 앞)- modify
ALTER TABLE test_table
MODIFY test_column7 int
FIRST;
DESC test_table;

#특정 열 뒤로 이동
alter table test_table 
modify test_column7 int;
after test_colunm6;

desc test_table;

#테이블 column 이름 변경 
alter table test_table 
change test_column2 test_column0 int;

desc test_table;

#column 데이터 타입 변경 - varchar(10)으로
alter table test_table 
change test_column0 test_column0 varchar(10);

desc test_table;

#column 이름과 데이터 타입 동시에 변경
alter table test_table
change test_column0 test_column2 int;

desc test_table;
    