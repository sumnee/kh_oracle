create table student_tbl(
    student_name varchar2(20),
    student_age number,
    student_grade number,
    student_address varchar2(100)
);

--���̺� ����
drop table student_tbl;


--���̺� �����͸� �ִ� ��� (ex.ȸ������)
insert into student_tbl(student_name, student_age,  student_grade, student_address)
values('����', 22, 1, '���α�');
insert into student_tbl
values(' ', '', 2, '������');
insert into student_tbl
values('����', 50, null, null);

--���̺��� �����͸� ����
update student_tbl
set student_age = 99
where student_grade = 2;

--������ ���� (ex.ȸ��Ż��)
delete from student_tbl;
where student_grade = 2

--������ ��ȸ
select student_name, student_age,  student_grade, student_address
from student_tbl
where student_grade = 2;
--select == �� �׸�



create table datatype_tbl(
    moonja char(10),    
    --���ĺ�10�� �ѱ�3��(���� 3byte)
    moonjayeol varchar2(100),
    soo number,
    nall date,
    nalja timestamp
    





