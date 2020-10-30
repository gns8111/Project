package com.groovy.backdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import com.groovy.DBConnectionMgr;

public class BackDataPost {

	DBConnectionMgr pool;
	Random r;
	String contents[] = { "�ȳ��ϼ��� �ݰ����ϴ�.", "�λ꿡 IT�п��� �ٴϴ� �л��Դϴ�.", "������ī BJ�Դϴ�.", "���� ��Ʃ�� �Դϴ�.", "��Ƽ ��Ʃ�� �Դϴ�.",
			"������ ��Ʃ�� �Դϴ�.", "������б� �л��Դϴ�.", "�������� �����մϴ�.", "���� �����ΰ�", "�ڵ��� ���� �Դϴ�.", "����� 9�� ������ �Դϴ�.",
			"�������̳� �Դϴ�.", "�Թ�ȸ�翡�� ���ϰ� �ֽ��ϴ�." };
	
	
	
	public BackDataPost() {
		pool = DBConnectionMgr.getInstance();
		r = new Random();
	}
	
	//tblPost �Է� 1000��
	public void insertPost1000() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblPost(id,p_contents,photo1,photo2,photo3,p_date,tag,notify,hide,P_likeN)"
					+ "values(?,?,?,?,?,now(),?,?,?,?)";
			for (int i = 0; i < 1000; i++) {
				String tag[] = { "#����", "#���ǵ��", "#�", "#�Ϻ����", "#����", "#����", "#�������", "#��ȭ", "#����Ű���", "#�丮", "#�뷡�θ���", "#�Ǳ⿬��","#����Ȱ��" };
				int ck = r.nextInt(3);//0~2
				//tag�� �����
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
	
	//tblMember ���� ��������
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














