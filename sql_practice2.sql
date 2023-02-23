show databases;

use python;

#자동으로 증가하는 column 만들기 -auto_increment
#column 이름은 id, 데이터 타입은 정수(int)로 만들기
#primary key없으면 오류 뜸
create table test(
    id int auto_increment primary key
);
desc test;

#auto_increment columm에 데이터 추가하기
#auto_increment가 지정된 column은 데이터 추가할 때 값()을 지정 하지 않아도 1부터 자동으로 값 생성
insert into test values ();

select * from test;

#auto_increment columm에 값을 지정하여 데이터 추가
insert into test values (100);
#값이 없는 데이터 입력하면 이전 데이터에서 1추가
insert into test values ();

select * from test;

#id column에서 특정 값을 가지는 행 삭제 
delete from test where id = 101;    #삭제 조건 -> where id = 101
select * from test;

#id column에서 한번 삭제된 값은 다시 사용하지 않음 -> 삭제된 값의 다음 데이터 생성
insert into test values ();
select * from test;

#test테이블의 모든 데이터 삭제
delete from test;
select * from test;

#다 삭제 되고 데이터 추가되면 이전 데이터 이후 값부터 추가됨
insert into test values ();
select * from test;

#auto_increment 초기화 또는 시작 번호 지정
show table status where name = 'test';

#테이블에 데이터가 1개도 없어야
alter table test auto_increment = 1;


insert into test values (25);
select * from test;

#값 수정하기 -  1부터 정렬하기
#데이터 분석할 때는 사용하는 일이 크게는 없어서 정말 필요한 상황에서 사용
set @count = 0 ;
update test set id = @count:=@count+1;

#테이블에 데이터 추가 - .inset

create table table1(
column1 varchar(100),
column2 varchar(100),
column3 varchar(100)
);
desc table1;
#null = yes 는 null 값도 들어갈 수 있다는 의미

#데이터 추가 - . insert
insert into table1 (column1,column2, column3) values ('a','aa','aaa');
select * from table1;
#테이블의 전체 컬럼이면 생략가능
insert into table1 values ('a','aa','aaa');

#데이터 추가 - 일부 컬럼만
insert into table1 (column1,column2) values ('b','bb');
select * from table1;

#데이터 수정 - update
#column1의 모든 데이터가 z로 수정
update table1 set column1 = 'z';
select * from table1 ;

#컬럼의 특정 데이터만 수정
update table1 set column1 ='x' where column2 ='aa';
select * from table1;

#여러개의 컬럼 수정
update table1
	set column1 = 'y'
	    ,column2 ='yy'
where column3 = 'aaa';
select * from table1;

#데이터 삭제 - delete
delete from table1 where column1 = 'y';
select * from table1;

#모든 데이터 삭제 -> 사용할 때 신중하게
delete from table1;
select * from table1;

#테스트용 테이블 생성
#기존 테이블 삭제(테이블 존재시)
drop table if exists day_visitor_realtime;

#테이블 생성
create table if not exists day_visitor_realtime(
ipaddress varchar(16),
iptime_first datetime,
before_url varchar(250),
device_info varchar(40),
os_info varchar(40),
session_id varchar(80));

#데이터 타입의 길이에 맞게 데이터를 삽입할 때
insert into day_visitor_realtime(
	ipaddress,iptime_first,before_url,device_info
)
values ('192.168.0.1', '2023-02-23 11:34:28' , 'localhost','PC')
	, ('192.168.0.2','2023-02-23 11:34:31','localhost','iphone');

select * from  day_visitor_realtime;
desc day_visitor_realtime;

#데이터 타입의 길이를 초과해서 데이터를 삽입할 때
insert into day_visitor_realtime(
	ipaddress,iptime_first,before_url,device_info
)
#varchar(16)
values('1234565663345242611','2023-02-23 11:34:28' , 'localhost','PC');
#varchar(16)에 17자리의 값을 넣어서 오류 발생

#데이터 삽입
INSERT INTO `python`.`day_visitor_realtime`(`session_id`) VALUES
(12345.567890);
INSERT INTO `python`.`day_visitor_realtime` (`session_id`) VALUES
('1234.567890');
INSERT INTO `python`.`day_visitor_realtime` (`session_id`) VALUES ('123');
INSERT INTO `python`.`day_visitor_realtime` (`session_id`) VALUES ('1234');
INSERT INTO `python`.`day_visitor_realtime` (`session_id`) VALUES ('12345');

select * from day_visitor_realtime;

#무결성 제약조건
#무결성 : 데이터베이스에 데이터의 정확성(일관성)
#종류로는 NOT NULL,UNIQUE,PRIMARY KEY,FOREIGN KEY,CHECK,DEFAULT

#not null
#해당 컬럼 값에 null이 오지 못하도록 /  null은 파이썬의 none과 같음
drop table if exists day_visitor_realtime;
create table if not exists day_visitor_realtime(
ipaddress varchar(16) not null,
iptime_first datetime,
before_url varchar(250),
device_info varchar(40),
os_info varchar(40),
session_id varchar(80));

#null
#insert시 값을 넣지 않으면 null로 표시
insert into day_visitor_realtime(
/*ipaddress*/
iptime_first,before_url,device_info,os_info
/*session*/
)
values(
now(),'aa','asdf','aa'
);

#primary key
#기본키 설정 - 하나의 테이블에 있는 데이터들을 고유하게 식별하는 제약조건
#한 개의 테이블에 하나만 생성가능 / 중복 불가, null값 불가

#기존 테이블 지우고 primary가 포함된 새 테이블 만들기
DROP TABLE IF EXISTS day_visitor_realtime;
CREATE TABLE day_visitor_realtime (
id INT,
ipaddress varchar(16),
iptime_first datetime,
before_url varchar(250),
device_info varchar(40),
os_info varchar(40),
session_id varchar(80),
PRIMARY KEY(id)
)

#primary key에 같은 값을 두번 넣으면 오류 발생
insert into day_visitor_realtime(
 id,ipaddress,iptime_first,before_url,device_info,os_info
 /*session_id*/
)
VALUES (1, 'asdf', NOW(), 'aa', 'asdf', 'aa')
, (1, 'asdf2', NOW(), 'aa2', 'asdf2', 'aa2');
# Error Code: 1062. Duplicate entry '1' for key 'PRIMARY' 오류 발생

#forelgn key - 왜래키
# 참조할 테이블
select database();
CREATE TABLE IF NOT exists orders (
order_id INT,
customer_id INT,
order_date DATETIME,
PRIMARY KEY(order_id)
);
show tables;
desc orders;
select * from orders;
insert into orders values(1,1,now());
insert into orders values(2,1,now());
insert into orders values(3,1,now());
select * from orders;

#참조 테이블의 기본키 orders(order_id)에 있는 값만 외래키인 order_detail (order_id)에 올 수있음
desc order_detail;
CREATE TABLE order_detail (
order_id INT,
product_id INT,
product_name VARCHAR(200),
order_date DATETIME,
CONSTRAINT FK_ORDERS_ORDERID FOREIGN KEY (order_id) REFERENCES
orders(order_id),
PRIMARY KEY(order_id, product_id)
);

insert into order_detail (order_id,product_id,product_name)
values(1,102,'iphone')
	  ,(1,103,'ipad');
select * from order_detail;

use employees;

#delete , update문 사용시 주의사항
#where 조건을 잘 설정해야하기 때문에
#먼저 select * from table where 조건 실행해서 삭제하려는 데이터들이 맞는지 확인하기!


select title, count(*)
	from titles
where to_date = '9999-01-01' #현재의 title
group by 1
;






