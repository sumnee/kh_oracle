-- 사용자 계정 생성, 권한부여 및 해제

create user student identified by student;
grant connect to student;
grant resource to student;

create user kh identified by kh;
grant connect, resource to kh;





