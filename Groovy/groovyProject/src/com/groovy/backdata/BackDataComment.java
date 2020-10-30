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

	String contents[] = { "�ȳ��ϼ���", "�ݰ����ϴ�", "�۰���", "���ȷο� ���ּ���", "���� ���� ���� ���ϴ�", "��...�Ƿʰ� �ȵǸ� ����ó��..", "�ȳ��ϼ��� �����Դϴ�.",
			"�ʹ� �Ƹ��ٿ�ʴϴ�.", "�ʹ� �����ʴϴ�", "��켼��", "���� ǳ���̳׿�", "ģ������ �ͽ��ϴ�.","�߻����","�������ּ��� ~","�����ϸ� ���� ����","�� ���� ¾��","�ʹ� ���־�� !","���� ���� �ϴٰ��ϴ� ����",
			"�̰� �� ���پƴ� ? ����","��հ� �þ��","�����ؿ� !"
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
