package com.groovy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.groovy.DBConnectionMgr;
import com.groovy.dto.CommentBean;

public class CommentMgr {
	private DBConnectionMgr pool;

	public CommentMgr() {
		pool = DBConnectionMgr.getInstance();

	}

	// ´ñ±Û °¡Á®¿À±â
	public Vector<CommentBean> selectComment(int p_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CommentBean> vlist = new Vector<CommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblcomment where p_index=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_index);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setC_index(rs.getInt("c_index"));
				bean.setP_index(rs.getInt("p_index"));
				bean.setId(rs.getString("id"));
				bean.setC_contents(rs.getString("c_contents"));
				bean.setC_date(rs.getString("c_date"));
				bean.setC_like(rs.getInt("c_like"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// ÃÑ ´ñ±Û¼ö °¡Á®¿À±â
	public int commentInt(int p_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(p_index) from tblcomment where p_index=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_index);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}

	// ´ñ±Û ÀÛ¼ºÇÏ±â
	public void commentWrite(String id , int index, String comment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblcomment (p_index,id,c_date,c_contents,c_like)values(?,?,now(),?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, index);
			pstmt.setString(2, id);
			pstmt.setString(3, comment);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
