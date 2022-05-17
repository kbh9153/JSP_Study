CREATE TABLE freeboard (
	id NUMBER CONSTRAINT PK_freeboard_id PRIMARY KEY,	-- 자동 증가 컬럼
	name varchar2(100) NOT NULL,
	password varchar2(100) NULL,
	email varchar2(100) NULL,
	subject varchar2(100) NOT NULL,	-- 글 제목
	content varchar2(2000) NOT NULL, 	-- 글 내용
	inputdate varchar2(100) NOT NULL,	-- 글 작성일
	masterid NUMBER DEFAULT 0,	-- Q&A 게시판에서 답변글을 그룹핑할 때 사용
	readcount NUMBER DEFAULT 0,		-- 글 조회 수
	replynum NUMBER DEFAULT 0,
	step NUMBER DEFAULT 0
	);
	
-- 답변글이 존재하는 테이블을 출력할 때, masterid와 같은 문의글과 답변글을 그룹핑하는 컬럼을 기준으로 데이터를 읽어야함
-- masterid 컬럼에 중복된 값이 있을 경우, replynum 컬럼을 asc
-- replynum이 중복된 값이 존재할 때, step 컬럼을 asc
-- step이 중복된 값이 존재할 때 id 컬럼을 asc
select * from freeboard
order by masterid desc, replynum, step, id;
	
/*
 * 컬럼 정보
 * 
 * id : 새로운 글이 등록될 때 기존의 id 컬럼의 최대값을 가져와서 + 1 
 *  -> 새로운 글에 번호의 넘버링
 *  -> 답변글을 처리하는 컬럼이 3개 필요 (masterid, replynum, step)
 * masterid : 글의 답변에 대한 그룹핑
 * 	-> id 컬럼의 값이 그대로 입력된 경우, 답변글이 아니라 처음 작성된 글
 * replynum : 하나의 문의글에 대한 답변글 넘버링(1, 2, 3 ...)
 * step : 답변글의 깊이(댓글, 대댓글, 대대댓글과 같음!)
 *  -> 문의글에 대한 답변글 -> 답변글에 대한 답변글 -> 답변글에 대한 답변글에 대한 답변글(1, 2, 3 ...)
 */ 
	