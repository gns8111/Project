CREATE TABLE MEMBER(
	userID VARCHAR(20),
	userPWD VARCHAR(20),
	userNAME VARCHAR(20),
	userGender VARCHAR(20),
	userEmail VARCHAR(50),
	PRIMARY KEY(userID)
);

CREATE TABLE BBS(
    bID number(4) PRIMARY KEY,
    bName varchar2(20),
    bTitle  varchar2(100),
    bContent varchar2(2048),
    bDate date default SYSDATE,
    bHit number(4) default 0,
    bGroup number(4), --해당 게시물의 그룹구별 BID값이랑 동일
    bStep number(4), --그룹은 동일 계층이라고 보면 됨.
    bIndent number(4),--답글 갯수? 기존은 0 추가될수록 +1
    userID varchar2(20)
);