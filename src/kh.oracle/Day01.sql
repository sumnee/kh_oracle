create table student_tbl(
    student_name varchar2(20),
    student_age number,
    student_grade number,
    student_address varchar2(100)
);

--테이블 삭제
drop table student_tbl;


--테이블에 데이터를 넣는 방법 (ex.회원가입)
insert into student_tbl(student_name, student_age,  student_grade, student_address)
values('민지', 22, 1, '종로구');
insert into student_tbl
values(' ', '', 2, '광진구');
insert into student_tbl
values('지민', 50, null, null);

--테이블의 데이터를 변경
update student_tbl
set student_age = 99
where student_grade = 2;

--데이터 삭제 (ex.회원탈퇴)
delete from student_tbl;
where student_grade = 2

--데이터 조회
select student_name, student_age,  student_grade, student_address
from student_tbl
where student_grade = 2;
--select == 볼 항목



create table datatype_tbl(
    moonja char(10),    
    --알파벳10개 한글3개(개당 3byte)
    moonjayeol varchar2(100),
    soo number,
    nall date,
    nalja timestamp
    





