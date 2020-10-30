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
    bGroup number(4), --�ش� �Խù��� �׷챸�� BID���̶� ����
    bStep number(4), --�׷��� ���� �����̶�� ���� ��.
    bIndent number(4),--��� ����? ������ 0 �߰��ɼ��� +1
    userID varchar2(20)
);