package com.groovy.backdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import com.groovy.DBConnectionMgr;

public class BackDataComment {
	DBConnectionMgr pool;
	Random r = new Random();

	public BackDataComment() {
		pool = DBConnectionMgr.getInstance();
	}

	String contents[] = { "안녕하세요", "반갑습니다", "퍼가요", "맞팔로우 해주세요", "좋은 사진 보고 갑니다", "저...실례가 안되면 연락처좀..", "안녕하세요 멋쟁입니다.",
			"너무 아름다우십니다.", "너무 멋지십니다", "고우세요", "좋은 풍경이네요", "친해지고 싶습니다.","잘생겼당","맞팔해주세요 ~","선팔하면 맞팔 ㅎㅎ","와 ㅎㅎ 쩐다","너무 멋있어요 !","좋은 구경 하다갑니다 ㅋㅋ",
			"이거 좀 에바아님 ? ㅋㅋ","재밌게 봤어요","소통해요 !"
			};

	public String randomId() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember limit ?, 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, r.nextInt(1000));
			rs = pstmt.executeQuery();
			if (rs.next())
				id = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}

	public void insertBackdataC() {
		Connection con = null;
		PreparedStatement pstmt = null;
		Random r = new Random();
		try {
			con = pool.getConnection();
			for (int i = 0; i < 3000; i++) {
				int index = 0;
				int like = 0;
				index = r.nextInt(1000) + 1;
				like = r.nextInt(20);
				int contentsbox = r.nextInt(20) + 1;
				String t_contents = contents[contentsbox];
				String sql = "insert tblcomment(p_index,id,c_date,c_contents,c_like) values"
						+ "(?,?,now(),?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, index);
				pstmt.setString(2, randomId());
				pstmt.setString(3, t_contents);
				pstmt.setInt(4, like);
				pstmt.executeUpdate();
				System.out.println(i);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public static void main(String[] args) {
		new BackDataComment().insertBackdataC();
	}

}
