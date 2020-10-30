package com.groovy.backdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import com.groovy.DBConnectionMgr;

public class BackDataPost {

	DBConnectionMgr pool;
	Random r;
	String contents[] = { "안녕하세요 반갑습니다.", "부산에 IT학원을 다니는 학생입니다.", "아프리카 BJ입니다.", "게임 유튜버 입니다.", "뷰티 유튜버 입니다.",
			"연예인 유튜버 입니다.", "서울대학교 학생입니다.", "메이플을 좋아합니다.", "나는 누구인가", "자동차 딜러 입니다.", "평범한 9급 공무원 입니다.",
			"웹디자이너 입니다.", "게밍회사에서 일하고 있습니다." };
	
	
	
	public BackDataPost() {
		pool = DBConnectionMgr.getInstance();
		r = new Random();
	}
	
	//tblPost 입력 1000개
	public void insertPost1000() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblPost(id,p_contents,photo1,photo2,photo3,p_date,tag,notify,hide,P_likeN)"
					+ "values(?,?,?,?,?,now(),?,?,?,?)";
			for (int i = 0; i < 1000; i++) {
				String tag[] = { "#독서", "#음악듣기", "#운동", "#암벽등반", "#게임", "#퍼즐", "#영어공부", "#영화", "#동물키우기", "#요리", "#노래부르기", "#악기연주","#봉사활동" };
				int ck = r.nextInt(3);//0~2
				//tag값 만들기
				String str = "";
				int ck2 = r.nextInt(tag.length-1)+1;
				for (int j = 0; j < ck2; j++) {
					int cnt = r.nextInt(tag.length);
					str+=tag[cnt];
					tag[cnt]="";
				}
				///////////////////////////
				if(ck==0) {
					sql = "insert tblPost(id,p_contents,photo1,p_date,tag,notify,hide,P_likeN)"
							+ "values(?,?,?,now(),?,0,0,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, randomId());
					pstmt.setString(2, contents[r.nextInt(contents.length)]);
					pstmt.setString(3, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(4, str);
					pstmt.setInt(5, r.nextInt(10000));
				}else if(ck==1) {
					sql = "insert tblPost(id,p_contents,photo1,photo2,p_date,tag,notify,hide,P_likeN)"
							+ "values(?,?,?,?,now(),?,0,0,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, randomId());
					pstmt.setString(2, contents[r.nextInt(contents.length)]);
					pstmt.setString(3, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(4, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(5, str);
					pstmt.setInt(6, r.nextInt(10000));
				}else if(ck==2) {
					sql = "insert tblPost(id,p_contents,photo1,photo2,photo3,p_date,tag,notify,hide,P_likeN)"
							+ "values(?,?,?,?,?,now(),?,0,0,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, randomId());
					pstmt.setString(2, contents[r.nextInt(contents.length)]);
					pstmt.setString(3, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(4, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(5, "data"+(r.nextInt(1000)+1)+".jpg");
					pstmt.setString(6, str);
					pstmt.setInt(7, r.nextInt(10000));
				}
				System.out.println(i);
				pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//tblMember 랜덤 가져오기
	public String randomId() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember limit ? , 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r.nextInt(1000)); //0~999
			rs = pstmt.executeQuery();
			if(rs.next())
				id = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
	
	
	
	public static void main(String[] args) {
		BackDataPost bk = new BackDataPost();
		bk.insertPost1000();
	}
}














