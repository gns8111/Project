package com.groovy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.groovy.DBConnectionMgr;

public class BlockMgr {
	
	
	private DBConnectionMgr pool;
	
	public BlockMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//상대방 차단
	public void block(String id, String bid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		
		try {
			con = pool.getConnection();
			sql = "insert tblblock(id, bid,n_date) values(?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, bid);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
