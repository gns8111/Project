Create TABLE tblmember(
id VARCHAR(20),
name VARCHAR(20) NOT NULL,
nick CHAR(20) NOT NULL,
pwd CHAR(20) NOT NULL,
birthday CHAR(20) NOT NULL,
email CHAR(30) NOT NULL,
profile CHAR(30),
hp CHAR(20) NOT NULL,
zipcode CHAR(40) NOT NULL,
address CHAR(40) NOT NULL,
detailAddress CHAR(50) NOT NULL,
gender VARCHAR(10) DEFAULT NULL,
intro CHAR(100),
withdrawal tinyint(1) DEFAULT NULL,
UNIQUE (nick, email)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

CREATE TABLE tblpost(
p_index INT,
id VARCHAR(20),
p_contents CHAR(255),
photo1 CHAR(40) NOT NULL,
photo2 CHAR(40),
photo3 CHAR(40),
p_date CHAR(40),
tag CHAR(255) NOT NULL,
notify tinyint(1) DEFAULT NULL,
hide tinyint(1) DEFAULT NULL,
p_likeN INT,
FOREIGN KEY(id) REFERENCES tblmember(id)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

CREATE TABLE tblblock(

id VARCHAR(20),
bid VARCHAR(20),
n_date CHAR(40),
FOREIGN KEY (id) REFERENCES tblmember (id),
FOREIGN KEY (bid) REFERENCES tblmember (id)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

CREATE TABLE tblfollow(
giveId VARCHAR(20),/*팔로우 한사람*/
takeId VARCHAR(20),/*팔로우 당한사람*/
f_date CHAR(40),/*언제 팔로우 했냐*/
checkMod TINYINT(1) DEFAULT NULL,
/*BLOCK tinyint(1) DEFAULT NULL,사람끼리 차단*/

PRIMARY KEY(giveId, takeId),
FOREIGN KEY (giveId) REFERENCES tblmember(id),
FOREIGN KEY (takeId) REFERENCES tblmember(id)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;


CREATE TABLE tblCOMMENT(
c_index INT,
p_index INT,
id VARCHAR(20),
c_date CHAR(40),
c_contents CHAR(255),
c_like INT,
FOREIGN KEY(p_index) REFERENCES tblpost(p_index),
FOREIGN KEY(id) REFERENCES tblmember(id)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

CREATE TABLE `tbllike` (
	`p_index` INT(11) NOT NULL,
	`lid` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`p_index`, `lid`),
	INDEX `lid` (`lid`),
	CONSTRAINT `tbllike_ibfk_1` FOREIGN KEY (`p_index`) REFERENCES `tblpost` (`p_index`),
	CONSTRAINT `tbllike_ibfk_2` FOREIGN KEY (`lid`) REFERENCES `tblmember` (`id`)
)
COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

CREATE TABLE tblreply(
r_index INT,
c_index INT,
id VARCHAR(20),
r_contents CHAR(255),
r_date CHAR(40),
r_likeN INT,
FOREIGN KEY(c_index) REFERENCES tblCOMMENT(c_index)
)COLLATE='euckr_korean_ci'
ENGINE=InnoDB
;

DROP DATABASE groovy;
create DATABASE groovy;