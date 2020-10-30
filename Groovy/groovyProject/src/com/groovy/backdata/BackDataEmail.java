package com.groovy.backdata;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import com.groovy.DBConnectionMgr;

public class BackDataEmail {

	DBConnectionMgr pool;

	public BackDataEmail() {
		pool = DBConnectionMgr.getInstance();
	}

	public void insertBackData() {

		Connection con = null;
		PreparedStatement pstmt = null;

		Random r = new Random(); // 랜덤
		char ids[] = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'm', 'o', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z' }; // 알파벳 배열
		char num[] = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' }; // 숫자 배열 10개

		String first_name[] = { "김", "이", "박", "최", "정", "강", "조", "윤", "장", "임", "한", "오", "서", "신", "권", "황", "안",
				"송", "전", "홍", "유", "고", "문", "양", "손", "배", "백", "허", "남", "심", "노", "하", "성", "차", "주", "우", "구", "민",
				"류", "나", "진", "공", "현", "여", "추", "도", "소", "석", "위" }; // 49개

		String full_name[] = { "지우", "민준", "서연", "민서", "서준", "서현", "지민", "주원", "하윤", "시우", "지원", "도윤", "예준", "연우", "지후",
				"윤서", "하은", "서진", "지호", "지유", "준서", "지윤", "지안", "준우", "수현", "도현", "지훈", "수아", "다은", "예은", "선우", "현서",
				"유진", "소율", "시현", "은우", "승현", "가은", "서율", "윤아", "민지", "예진", "유나", "승우", "지환", "수연", "유빈", "민성", "시연",
				"예서", "서아", "진우", "다인", "다연", "시아", "도연", "지현", "예지", "태윤", "지수", "주하", "민주", "민규", "준희", "지은", "재민",
				"민찬", "윤호", "성민", "수호", "태희", "규민", "하영", "세은", "채린", "민혁", "민호", "채민", "지연", "민채", "현진", "주연", "준수",
				"한별", "채민", "보민", "성준", "민석", "유정", "현지" }; // 90개

		// char special[] = {'!','@','#','$','%','^','&','*'}; //특문 8개
		String gg = "@gmail.com";
		String filename = "";
		int zipcode=0;
		String address="";
		String detailAddress="";
		
		String gender = "";
		String intro[] = { "안녕하세요 반갑습니다.", "부산에 IT학원을 다니는 학생입니다.", "아프리카 BJ입니다.", "게임 유튜버 입니다.", "뷰티 유튜버 입니다.",
				"연예인 유튜버 입니다.", "서울대학교 학생입니다.", "메이플을 좋아합니다.", "나는 누구인가", "자동차 딜러 입니다.", "평범한 9급 공무원 입니다.",
				"웹디자이너 입니다.", "게밍회사에서 일하고 있습니다." };
		String birthyears[] = { "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960",
				"1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973",
				"1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986",
				"1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999",
				"2000", "2001", "2002", "2003", "2004", "2005", "2006" };
		String birthmonths[] = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" };

		String birthdays[] = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15",
				"16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" }; // 1,3,5,7,8,10,12월은
																													// 이거
																													// 씀

		String nickname[] = { "Adel", "Erwynn", "Laen", "Shal", "Bert", "Esgal", "Madir", "Sirri", "Bobd", "Floo",
				"Merri", "Sonke", "Brea", "Flos", "Neva", "Tany", "Calle", "Forda", "Nobel", "Trevon", "Chan", "Girgir",
				"Novand", "Tuos", "Darril", "Holl", "Onand", "Vada", "Dearge", "Igan", "Peran", "Wain", "Dhuic",
				"Isemi", "Rekwel", "Widor", "Doni", "Ivolis", "Rivell", "Wigh", "Eadely", "Jennia", "Samm", "Willea",
				"Eles", "Kent", "Saryan", "Erus", "Lach", "Serath" }; // 50개
		
		

		int daybox = 0;
		// 4,6,7,8,10,12 월은 31일까지
		// 1,3,5,9,11월은 30일까지
		// 2월은 28일까지
		// char nick[] = {"가",""

		for (int i = 1; i <1000; i++) {/* 1000 돌림 */
			String id = "";
			String hp = "010-";
			String goodpwd = "";
			// -------------------아이디 이메일--------------------
			int length1 = r.nextInt(2) + 4;
			int length2 = r.nextInt(2) + 3;

			for (int j = 0; j < length1; j++) {
				int leng = r.nextInt(25) + 1;
				id += ids[leng];
			}
			for (int k = 0; k < length2; k++) {
				int leng1 = r.nextInt(9) + 1;
				id += num[leng1];

				// ---------------------nick-----------------

				// ---------------------pwd------------------
				/*
				 * for (int a = 0 ; a<1; a++) { goodpwd +=special[r.nextInt(7)+1]; }
				 */ // 특수문자 추가
				for (int a = 0; a < 2; a++) {
					goodpwd += num[r.nextInt(9) + 1];
				}

				// -----------------휴대폰 번호------------------
			}
			for (int j = 0; j < 4; j++) {
				hp += num[r.nextInt(9) + 1];
			}
			hp += "-";
			for (int j = 0; j < 4; j++) {
				hp += num[r.nextInt(9) + 1];
			}
			// -------------------지역---------------------
			int leng = r.nextInt(12) + 1;
			// ----------------프로필 사진--------
			filename = "data" + i +"jpg";
			// ----------------성별----------------------
			int half = r.nextInt(2);
			if (half == 0) {
				gender = "0";
			} else if (half == 1) {
				gender = "1";
			}
			// ----------------이름------------------
			String name = first_name[r.nextInt(48) + 1] + full_name[r.nextInt(89) + 1];
			// ----------------닉네임-----------------
			int nickbox = r.nextInt(49) + 1;
			// -------------------취미-------------------
			int hobbybox = r.nextInt(12) + 1;
			// ---------------------자기소개--------------------
			int introduce = r.nextInt(12) + 1;
			// ---------------------생년월일---------------------
			int yearbox = r.nextInt(56) + 1; // 년
			int monthbox = r.nextInt(11) + 1; // 월
			if (monthbox == 4 || monthbox == 6 || monthbox == 9 || monthbox == 11) {
				daybox = r.nextInt(29) + 1;
			} else if (monthbox == 2) {
				daybox = r.nextInt(27) + 1;
			} else if (monthbox == 1 || monthbox == 3 || monthbox == 5 || monthbox == 7 || monthbox == 8
					|| monthbox == 10 || monthbox == 12) {
				daybox = r.nextInt(30) + 1;
			}
			int withdrawal = 0; // 탈퇴여부
			String birth = "";
			birth += birthyears[yearbox].substring(2, 4);
			birth += birthmonths[monthbox];
			birth += birthdays[daybox];
			
			String email = id.concat(gg);

			System.out.println("아이디: " + id);
			
			if(getId(id)) continue;
			String nick = nickname[nickbox]+r.nextInt(1000);
			if(getNick(nick)) continue;
			String sql = "insert tblMember(id,name,nick,pwd,birthday,email,"
					+ "profile,hp,zipcode,address,detailAddress,gender,intro,withdrawal)VALUES"
					+ " (?,?,?,?,?,?,?,?,?,?,?,?,?,0)";
			try {
				con = pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, name);
				pstmt.setString(3, nick);
				pstmt.setString(4, goodpwd);
				pstmt.setString(5, birth);
				pstmt.setString(6, email);
				pstmt.setString(7, filename);
				pstmt.setString(8, hp);
				pstmt.setInt(9,zipcode);
				pstmt.setString(10,address);
				pstmt.setString(11,detailAddress);
				pstmt.setString(12, gender);
				pstmt.setString(13, intro[introduce]);
				pstmt.executeUpdate();
				System.out.println("End~~~~~~~~~~~~~~~");
			} catch (Exception e) {
				System.out.println("insert connect error");
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	}
	
	public boolean getId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()&&!rs.getString(1).equals(""))
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		System.out.println(flag);
		return flag;
	}
	
	public boolean getNick(String nick) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select nick from tblMember where nick = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			if(rs.next()&&!rs.getString(1).equals(""))
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	
	public static void main(String[] args) {
		new BackDataEmail().insertBackData();
	}
}