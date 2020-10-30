package com.groovy.backdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import com.groovy.DBConnectionMgr;

public class BackDataFollow {
	DBConnectionMgr pool;
	Random r = new Random();

	public BackDataFollow() {
		pool = DBConnectionMgr.getInstance();
	}
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
			if(rs.next()) id =rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
	public void insertBackDataF() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			for (int i = 0; i < 3000; i++) {
				
			
			sql = "insert tblfollow(giveId,takeId,f_date,checkMod,BLOCK) values(?,?,now(),0,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, randomId());
			pstmt.setString(2, "aaa");
			pstmt.executeUpdate();
			System.out.println(i);
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public static void main(String[] args) {
		new BackDataFollow().insertBackDataF();
	}

}
