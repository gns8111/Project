package com.groovy.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.swing.text.StyledEditorKit.BoldAction;

import com.groovy.DBConnectionMgr;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FollowMgr {
	private DBConnectionMgr pool;

	public FollowMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//ÆÈ·Î¿ì ÅäÅ»
	public int followerTotal(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total=0;
		try {
			con = pool.getConnection();
			sql = "select count(takeId) from tblfollow where giveId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return total;
	}
	
	//ÆÈ·ÎÀ® ÅäÅ»
	public int followingTotal(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total = 0;
		try {
			con = pool.getConnection();
			sql = "select count(giveId) from tblfollow where takeId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return total;

	}
	
	//°Ô½Ã¹° ÆÈ·ÎÀ® ÅäÅ»
	public Vector<String> postFollowing(String id, String yid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String fp= "";
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "SELECT tblpost.p_index,tblfollow.takeid,tblfollow.giveid  "
					+ "FROM tblpost "
					+ "JOIN tblfollow "
					+ "ON tblpost.id=tblfollow.giveid;"
					+ "where giveId=?,takeId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, yid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				fp=rs.getString(1)+"&";
				fp+=rs.getString(2)+"&";
				fp+=rs.getString(3);
				vlist.addElement(fp);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//ÆÈ·Î¿ì ±â´É
	public boolean follow(String giveId, String takeId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblfollow(giveId,takeId,f_date,checkMod) VALUES(?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, giveId);
			pstmt.setString(2, takeId);
			int cnt = pstmt.executeUpdate();
			if(cnt==1) 
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//ÆÈ·Î¿ì °Ë»ö
	public boolean followCheck(String giveid, String takeid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tblfollow where giveId =? and takeId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, giveid);
			pstmt.setString(2, takeid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//ÆÈ·Î¿ì Ãë¼Ò 
	public void followCancel(String giveId, String takeId ) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM tblfollow WHERE giveId = ? AND takeId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, giveId);
			pstmt.setString(2, takeId);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//ÆÈ·Î¿ì ¾Ë¸²
	public Vector<String> followNotification(String giveid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select giveId from tblfollow where checkMod = 0 and takeid =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, giveid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vlist.addElement(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println(flag);
		return vlist;
	}
	
	
	//navBar ÆÈ·Î¿ì ¾Ë¸² Å¬¸¯½Ã ¾È º¸ÀÌ°Ô ÇÏ´Â ±â´É
	public boolean followCheckMod(String giveId, String takeId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "update tblfollow set checkMod = 1 where giveId = ? and takeId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, giveId);
			pstmt.setString(2, takeId);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt==1) {
				flag = true;
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
}
