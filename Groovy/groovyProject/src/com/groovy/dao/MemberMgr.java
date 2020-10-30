package com.groovy.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.groovy.DBConnectionMgr;
import com.groovy.dto.MemberBean;
import com.groovy.dto.ZipcodeBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


	
public class MemberMgr {
	public static final String saveFolder = "C:\\Users\\ditak\\eclipse-workspace\\groovyProject\\WebContent\\groovy\\upload\\filestorage";
	// 경로 바꿔야됨
	public static final String encType = "EUC-KR";
	public static final int maxSize = 10 * 1024 * 1024;// 10MB
	private DBConnectionMgr pool;

	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//로그인 : 성공 : true, 실패 : false
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select id from tblmember where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		//System.out.println(flag);
		return flag;
	}

	//ID 중복확인 - true 중복
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();//결과값이 있으면 true 없으면 false
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//우편번호 검색
	//select * from tblZipcod where doro like '%강남대로%'
	public Vector<ZipcodeBean> zipcodeRead(String doro){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblzipcode where doro like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+doro+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setSido(rs.getString(2));
				bean.setSigungu(rs.getString(3));
				bean.setDoro(rs.getString(4));
				bean.setDong(rs.getString(5));
				bean.setZibun1(rs.getString(6));
				bean.setZibun2(rs.getString(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//회원가입
	public boolean insertMember(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, saveFolder, maxSize, encType,
					new DefaultFileRenamePolicy());
			String upFile = multi.getFilesystemName("profile");
			File f = multi.getFile("profile");
			con = pool.getConnection();
			sql = "insert tblmember(id,name,nick,pwd,birthday,email,"
					+ "profile,hp,zipcode,address,detailAddress,gender,intro,withdrawal)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("id"));
			pstmt.setString(2, multi.getParameter("name"));
			pstmt.setString(3, multi.getParameter("nick"));
			pstmt.setString(4, multi.getParameter("pwd"));
			pstmt.setString(5, multi.getParameter("birthday"));
			pstmt.setString(6, multi.getParameter("email"));
			pstmt.setString(7, upFile);
			pstmt.setString(8, multi.getParameter("hp"));
			pstmt.setString(9, multi.getParameter("zipcode"));
			pstmt.setString(10, multi.getParameter("address"));
			pstmt.setString(11, multi.getParameter("detailAddress"));
			pstmt.setString(12, multi.getParameter("gender"));
			pstmt.setString(13, multi.getParameter("intro"));
			
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
	
	//회원정보 가져오기
	public MemberBean getMember(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			bean.setId(rs.getString("id"));
			bean.setPwd(rs.getString("pwd"));
			bean.setName(rs.getString("name"));
			bean.setNick(rs.getString("nick"));
			bean.setEmail(rs.getString("email"));
			bean.setBirthday(rs.getString("birthday"));
			bean.setHp(rs.getString("hp"));			
			bean.setZipcode(rs.getString("zipcode"));	
			bean.setAddress(rs.getString("address"));
			bean.setDetailAddress(rs.getString("detailAddress"));
			bean.setGender(rs.getString("gender"));
			bean.setIntro(rs.getString("intro"));
			bean.setProfile(rs.getString("profile"));
			bean.setWithdrawal(rs.getInt("withdrawal"));
			}
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//회원정보 수정
	public boolean updateMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			MemberBean bean = new MemberBean();
			con = pool.getConnection();
			sql = "update tblmember set pwd=?, name=?, nick=?, email=?, birthday=?, hp=?,"
					+ "zipcode=?,address=?, detailAddress=? gender=?,"
					+ "profile=?, intro=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getNick());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getHp());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			pstmt.setString(9, bean.getDetailAddress());
			pstmt.setString(10, bean.getGender());
			pstmt.setString(11, bean.getProfile());
			pstmt.setString(12, bean.getIntro());
			pstmt.setString(13, bean.getId());			
			
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
	//패스워드 찾기
	public String findPwd(String id, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pwd = null;
		try {
			con = pool.getConnection();
			sql = "select pwd from tblmember where id=? and email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if(rs.next()) //조건에 만족하는 id와 email 있다면 pwd 리턴
				pwd = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		/* System.out.println("pwd : " + pwd); */
		return pwd;
	}
}
