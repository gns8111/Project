package com.groovy.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.groovy.DBConnectionMgr;
import com.groovy.dto.BoardBean;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class BoardMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/board/fileupload/";
	public static final String ENCTYPE = "EUC-KR";
	public static int MAXSIZE = 10*1024*1024;
		
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Board Insert : 파일업로드, ContentType, ref의 상대적인 위치값(지금의 신경X 나중에 답변할 때)
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			/////////////파일업로드 기능 부문/////////////////
			File dir = new File(SAVEFOLDER);
			//폴더가 없다면 새롭게 만들어라
			if(!dir.exists()) {
				//mkdir : 상위 폴더가 없으면 생성불가
				//mkdirs : 상위 폴더가 없어도 생성가능 다 한번만 실행
				dir.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER,
					MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;
			//사용자가 파일을 업로드를 한 경우 아니면 null이다.
			if (multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
				//----------------파일업로드 부문은 다 처리됨
			}
			//////게시물 contentType : text, html 두가지가 있다.
			String content = multi.getParameter("content");//게시물 내용
			if (multi.getParameter("contentType").equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			/////////////////////////////////////////////////////
			con = pool.getConnection();
			//////////////ref값///////////////////////////////
			sql = "select max(num) from tblBoard2";//가장 높은 num값
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 0;
			if (rs.next()) {
				ref = rs.getInt(1) + 1;//가장 높은 num값에 1을 더함.
			pstmt.close();
			////////////////////////////////////////////////////////
			sql = "insert tblBoard2(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//Board Total Count(총 게시물 갯수)
		public int getTotalCount(String keyField, String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if (keyWord.equals("")||keyWord==null) {
					//검색이 안되는 경우
					sql = "select count(*) from tblBoard2";
					pstmt = con.prepareStatement(sql);
				}else {
					//검색인 경우
					sql = "select count(*) from tblBoard2 where " + keyField + " like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord + "%");
					
				}
				rs = pstmt.executeQuery();
				if (rs.next())
					totalCount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
	//Board List(리스트) : 검색포함
	//getBoardList에 리턴되는 벡터의 최소 최대 개수는? 배열로하면 복잡해서 벡터로 한다.
	public Vector<BoardBean> getBoardList(String keyField, String keyWord,
			int start, int cnt)/*유동적으로 값을 받기위해 매개변수 int 선언(limit 0, 10)*/ {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select * from tblBoard2 order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);//게시물 시작(인덱스)번호
				pstmt.setInt(2, cnt);//가져 올 게시물 수
			}else {
				//검색인 경우
				sql = "select * from tblBoard2 where " + keyField + " like ? "
						+ "order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);//게시물 시작(인덱스)번호
				pstmt.setInt(3, cnt);//가져 올 게시물 수
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				//regdate DB에서 DATE타입이지만 모든 타입은 getString 가능
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//Board get(한개의 게시물) : 13개 컬럼 모두 리턴
	public BoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblboard2 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//Count Up (조회수 증가)
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard2 set count = count +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Board Delete : 업로드 파일 삭제
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select filename from tblBoard2 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()&&rs.getString(1)!=null) {
				if (!rs.getString(1).equals("")) {
					File f = new File(SAVEFOLDER+rs.getString(1));
					if (f.exists()) {
						//파일삭제기능
						UtilMgr.delete(SAVEFOLDER+rs.getString(1));
					}
				}
			}
			pstmt.close();
			sql = "delete from tblBoard2 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	//Board Update(name, subject, content 3개만 수정)
	public void updateBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard2 set name=?, subject=?, content=? "
					+ "where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//Board Update2(파일 수정) : 1.
	public void updateBoard2(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			//파일 업로드 수정 or 파일 업로드 수정X
			//↓기존에 파일 있을 경우
			int num = Integer.parseInt(multi.getParameter("num"));
			
			if(multi.getFilesystemName("filename")!=null) {
				//기존에 파일이 있다면 삭제
				BoardBean bean = getBoard(num);//파일 정보를 전부 다 가져오는 부문
				String filename = bean.getFilename();
				
				if(filename!=null&&!filename.equals("")) {
					File f = new File(SAVEFOLDER+filename);
					if(f.exists()) {
						//파일 삭제
						UtilMgr.delete(SAVEFOLDER+filename);
						
					}//----if2
				}//-----if1
				//↓파일 업로드가 되었을 때 파일명이랑 파일사이즈 하는 부문
				filename = multi.getFilesystemName("filename");
				int filesize = (int)multi.getFile("filename").length();
				
				sql = "update tblBoard2 set name=?, subject=?, content=? "
						+ "filename=?, filesize=? where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("subject"));
				pstmt.setString(3, multi.getParameter("content"));
//				pstmt.setString(4, multi.getParameter("filename"));
//				pstmt.setInt(5, Integer.parseInt(multi.getParameter("filesize")));
				pstmt.setString(4, filename);
				pstmt.setInt(5, filesize);
				pstmt.setInt(6, num);
				}else{
					sql = "update tblBoard2 set name=?, subject=?, content=? "
							+ " where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, multi.getParameter("name"));
					pstmt.setString(2, multi.getParameter("subject"));
					pstmt.setString(3, multi.getParameter("content"));
					pstmt.setInt(4, num);
			}
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Board Reply(답변글 저장)
	public void replyBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard2(name,content,subject,ref,pos,depth,regdate," 
					+ "pass,count,ip)values(?, ?, ?, ?, ?, ?, now(), ?, 0, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			///////////////////////////////////////////////////////
			pstmt.setInt(4, bean.getRef());//원글과 동일한 ref 그룹값
			pstmt.setInt(5, bean.getPos()+1);//원글의 pos에서 1증가
			pstmt.setInt(6, bean.getDepth()+1);//원글의 depth에서 1증가
			//////////////////////////////////////////////////////
			pstmt.setString(7, bean.getPass());
			pstmt.setString(8, bean.getIp());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Board Reply Up : 답변의 위치값 수정(증가)
	public void replyUpBoard(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard2 set pos = pos+1 where ref=? and pos > ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}	
		}
	
	//Post 1000
		//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
		public void post1000(){
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert tblBoard2(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
				sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
				pstmt = con.prepareStatement(sql);
				for (int i = 0; i < 1000; i++) {
					pstmt.executeUpdate();
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		//main
		public static void main(String[] args) {
			BoardMgr mgr = new BoardMgr();
			mgr.post1000();
			System.out.println("성공~~");
		}
}
