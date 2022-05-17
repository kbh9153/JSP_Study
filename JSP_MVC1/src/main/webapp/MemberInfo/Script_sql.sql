-- 회원 정보를 저장하는 테이블
CREATE TABLE mbTbl(
	idx NUMBER NOT NULL,	-- 시퀀스 부착, 자동 증가 컬럼
	id varchar2(100) NOT NULL,
	pass varchar2(100) NOT NULL,
	name varchar2(100) NOT NULL,
	email varchar2(100)	NOT NULL,
	city varchar2(100) NULL,
	phone varchar2(100) NULL
	);

SELECT * FROM mbTbl;

ALTER TABLE mbTbl
ADD CONSTRAINT mbTbl_id_PK PRIMARY KEY(id);
	
CREATE SEQUENCE seq_mbTbl_idx
	INCREMENT BY 1
	START WITH 1
	nocache;
	
-- 더미 데이터 입력
INSERT INTO mbTbl (idx, id, pass, name, email, city, phone)
	VALUES (seq_mbTbl_idx.nextval, 'admin', '1234', '관리자', 'kosmo@kosmo.com', '서울', '010-1111-1111');