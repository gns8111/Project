package com.groovy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.groovy.DBConnectionMgr;
import com.groovy.dto.FollowBean;
import com.groovy.dto.MemberBean;
import com.groovy.dto.PostBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class PostMgr {
	public static final String saveFolder = "C:\\Users\\ditak\\eclipse-workspace\\groovyProject\\WebContent\\groovy\\data";
	// 경로 바꿔야됨
	public static final String encType = "UTF-8";
	public static final int maxSize = 10 * 1024 * 1024;// 10MB
	private DBConnectionMgr pool;

	public PostMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//다음 게시물 index값
	public int getNext() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select p_index from tblpost order by p_index DESC";
		
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1; 
			}
			return 1;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public PostBean readPost(int p_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PostBean bean = new PostBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblPost where p_index=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_index);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setP_index(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setP_contents(rs.getString(3));
				bean.setPhoto1(rs.getString(4));
				bean.setPhoto2(rs.getString(5));
				bean.setPhoto3(rs.getString(6));
				bean.setP_date(rs.getString(7));
				bean.setTag(rs.getString(8));
				bean.setNotify(rs.getInt(9));
				bean.setHide(rs.getInt(10));
				bean.setP_likeN(rs.getInt(11));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public MemberBean readMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getString(1));
				bean.setName(rs.getString(2));
				bean.setNick(rs.getString(3));
				bean.setPwd(rs.getString(4));
				bean.setBirthday(rs.getString(5));
				bean.setEmail(rs.getString(6));
				bean.setProfile(rs.getString(7));
				bean.setHp(rs.getString(8));
				bean.setAddress(rs.getString(9));
				bean.setDetailAddress(rs.getString(10));
				bean.setGender(rs.getString(11));
				bean.setIntro(rs.getString(12));
				bean.setWithdrawal(rs.getInt(13));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
		
	}
	
	//게시물 검색
	public Vector<PostBean> selectPost(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PostBean> vlist = new Vector<PostBean>();
		try {
			con = pool.getConnection();
			sql = 
					  "SELECT * FROM tblpost WHERE id = ? "
					  + "OR id IN (select takeid FROM tblfollow WHERE giveid = ?)"
					  + "AND id not in(select bid from tblblock where id = ?)"
					  + " order by p_date desc limit 0,20";
					 
					/*"Select * From tblfollow where giveid = ? OR id in(Select takeId from tblfollow where giveId = ?";*/
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PostBean bean = new PostBean();
				bean.setP_index(rs.getInt(1));
				bean.setId(rs.getString(2));
				bean.setP_contents(rs.getString(3));
				bean.setPhoto1(rs.getString(4));
				bean.setPhoto2(rs.getString(5));
				bean.setPhoto3(rs.getString(6));
				bean.setP_date(rs.getString(7));
				bean.setTag(rs.getString(8));
				bean.setNotify(rs.getInt(9));
				bean.setHide(rs.getInt(10));
				bean.setP_likeN(rs.getInt(11));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	
	public Vector<String> flistImgList(int n, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>();
		try {
			con = pool.getConnection();
			sql = "select p_index, photo1,p_likeN from tblpost where id=? limit 0, ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, n);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String msg = "";
				msg+=rs.getString(1);
				msg+="&<img src='data/"+rs.getString(2) +"' style=\"width: 270px; height:270px;\">";
				msg+="&"+rs.getInt(3);
				vlist.addElement(msg);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public String listImgList2(String id, int n) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String msg = "";
		CommentMgr cMgr = new CommentMgr();
		try {
			con = pool.getConnection();
			sql = "select p_index, photo1,p_likeN from tblpost where id=? limit ?, 6";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, n);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				msg+= "<tag>";
				msg+= "<imglist>";
				int cCnt =  cMgr.commentInt(rs.getInt(1));
				msg+= "<imgfile1>"+cCnt+"&"+ rs.getString(2)+"&"+rs.getInt(3)+"</imgfile1>";
				if(rs.next()) {
					cCnt =  cMgr.commentInt(rs.getInt(1));
					msg+=  "<imgfile2>"+cCnt+"&"+ rs.getString(2)+"&"+rs.getInt(3)+"</imgfile2>";
				}else{break;}
				if(rs.next()) {
					cCnt =  cMgr.commentInt(rs.getInt(1));
					msg+=  "<imgfile3>"+cCnt+"&"+ rs.getString(2)+"&"+rs.getInt(3)+"</imgfile3>";
				}else{break;}
				msg+= "</imglist>";
				msg+="</tag>";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return msg;
	}
	
	//해당 회원의 게시물 수
	public int postInt(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0 ;
		try {
			con = pool.getConnection();
			sql = "select count(id) from tblpost where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
	
	public FollowBean notifiAll(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		FollowBean bean = new FollowBean();
		
		try {
			con = pool.getConnection();
			sql = "select takeId from tblfollow where giveId = ? ";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//게시물 올리기
	public boolean insertContent(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		// String upFile1, upFile2, upFile3;
		boolean flag = false;
		int getNext = getNext();
		try {
			MultipartRequest multi = new MultipartRequest(req, saveFolder, maxSize, encType,
					new DefaultFileRenamePolicy());
			
			String upFile1 = multi.getFilesystemName("profile1");
			String upFile2 = multi.getFilesystemName("profile2");
			String upFile3 = multi.getFilesystemName("profile3");
			con = pool.getConnection();
			sql = "insert tblpost(p_index, id,p_contents,photo1,photo2,photo3,p_date,tag,notify,hide,p_likeN)"
					+ "values(?,?,?,?,?,?,now(),?,0,0,0)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, getNext);
			pstmt.setString(2, multi.getParameter("id"));
			pstmt.setString(3, multi.getParameter("p_contents"));
			pstmt.setString(4, upFile1);
			pstmt.setString(5, upFile2);
			pstmt.setString(6, upFile3);
			pstmt.setString(7, multi.getParameter("tag"));
			
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
	
	
	public void likePlus(int p_index,String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT INTO tbllike(p_index,lid) VALUE(?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_index);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public void likeMinus(int p_index,String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tbllike where p_index=? and lid =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, p_index);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public int likeInt(int p_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM tbllike WHERE p_index=?;";
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
	
	public boolean likeCheck(String id , int p_index) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from tbllike where lid=? and p_index=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, p_index);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		/* System.out.println(p_index + " : " + flag); */
		return flag;
	}
}

