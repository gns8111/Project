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

		Random r = new Random(); // ����
		char ids[] = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'n', 'm', 'o', 'p', 'q', 'r', 's',
				't', 'u', 'v', 'w', 'x', 'y', 'z' }; // ���ĺ� �迭
		char num[] = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' }; // ���� �迭 10��

		String first_name[] = { "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "Ȳ", "��",
				"��", "��", "ȫ", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��",
				"��", "��", "��", "��", "��", "��", "��", "��", "��", "��", "��" }; // 49��

		String full_name[] = { "����", "����", "����", "�μ�", "����", "����", "����", "�ֿ�", "����", "�ÿ�", "����", "����", "����", "����", "����",
				"����", "����", "����", "��ȣ", "����", "�ؼ�", "����", "����", "�ؿ�", "����", "����", "����", "����", "����", "����", "����", "����",
				"����", "����", "����", "����", "����", "����", "����", "����", "����", "����", "����", "�¿�", "��ȯ", "����", "����", "�μ�", "�ÿ�",
				"����", "����", "����", "����", "�ٿ�", "�þ�", "����", "����", "����", "����", "����", "����", "����", "�α�", "����", "����", "���",
				"����", "��ȣ", "����", "��ȣ", "����", "�Թ�", "�Ͽ�", "����", "ä��", "����", "��ȣ", "ä��", "����", "��ä", "����", "�ֿ�", "�ؼ�",
				"�Ѻ�", "ä��", "����", "����", "�μ�", "����", "����" }; // 90��

		// char special[] = {'!','@','#','$','%','^','&','*'}; //Ư�� 8��
		String gg = "@gmail.com";
		String filename = "";
		int zipcode=0;
		String address="";
		String detailAddress="";
		
		String gender = "";
		String intro[] = { "�ȳ��ϼ��� �ݰ����ϴ�.", "�λ꿡 IT�п��� �ٴϴ� �л��Դϴ�.", "������ī BJ�Դϴ�.", "���� ��Ʃ�� �Դϴ�.", "��Ƽ ��Ʃ�� �Դϴ�.",
				"������ ��Ʃ�� �Դϴ�.", "������б� �л��Դϴ�.", "�������� �����մϴ�.", "���� �����ΰ�", "�ڵ��� ���� �Դϴ�.", "����� 9�� ������ �Դϴ�.",
				"�������̳� �Դϴ�.", "�Թ�ȸ�翡�� ���ϰ� �ֽ��ϴ�." };
		String birthyears[] = { "1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960",
				"1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973",
				"1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986",
				"1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999",
				"2000", "2001", "2002", "2003", "2004", "2005", "2006" };
		String birthmonths[] = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" };

		String birthdays[] = { "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15",
				"16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" }; // 1,3,5,7,8,10,12����
																													// �̰�
																													// ��

		String nickname[] = { "Adel", "Erwynn", "Laen", "Shal", "Bert", "Esgal", "Madir", "Sirri", "Bobd", "Floo",
				"Merri", "Sonke", "Brea", "Flos", "Neva", "Tany", "Calle", "Forda", "Nobel", "Trevon", "Chan", "Girgir",
				"Novand", "Tuos", "Darril", "Holl", "Onand", "Vada", "Dearge", "Igan", "Peran", "Wain", "Dhuic",
				"Isemi", "Rekwel", "Widor", "Doni", "Ivolis", "Rivell", "Wigh", "Eadely", "Jennia", "Samm", "Willea",
				"Eles", "Kent", "Saryan", "Erus", "Lach", "Serath" }; // 50��
		
		

		int daybox = 0;
		// 4,6,7,8,10,12 ���� 31�ϱ���
		// 1,3,5,9,11���� 30�ϱ���
		// 2���� 28�ϱ���
		// char nick[] = {"��",""

		for (int i = 1; i <1000; i++) {/* 1000 ���� */
			String id = "";
			String hp = "010-";
			String goodpwd = "";
			// -------------------���̵� �̸���--------------------
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
				 */ // Ư������ �߰�
				for (int a = 0; a < 2; a++) {
					goodpwd += num[r.nextInt(9) + 1];
				}

				// -----------------�޴��� ��ȣ------------------
			}
			for (int j = 0; j < 4; j++) {
				hp += num[r.nextInt(9) + 1];
			}
			hp += "-";
			for (int j = 0; j < 4; j++) {
				hp += num[r.nextInt(9) + 1];
			}
			// -------------------����---------------------
			int leng = r.nextInt(12) + 1;
			// ----------------������ ����--------
			filename = "data" + i +"jpg";
			// ----------------����----------------------
			int half = r.nextInt(2);
			if (half == 0) {
				gender = "0";
			} else if (half == 1) {
				gender = "1";
			}
			// ----------------�̸�------------------
			String name = first_name[r.nextInt(48) + 1] + full_name[r.nextInt(89) + 1];
			// ----------------�г���-----------------
			int nickbox = r.nextInt(49) + 1;
			// -------------------���-------------------
			int hobbybox = r.nextInt(12) + 1;
			// ---------------------�ڱ�Ұ�--------------------
			int introduce = r.nextInt(12) + 1;
			// ---------------------�������---------------------
			int yearbox = r.nextInt(56) + 1; // ��
			int monthbox = r.nextInt(11) + 1; // ��
			if (monthbox == 4 || monthbox == 6 || monthbox == 9 || monthbox == 11) {
				daybox = r.nextInt(29) + 1;
			} else if (monthbox == 2) {
				daybox = r.nextInt(27) + 1;
			} else if (monthbox == 1 || monthbox == 3 || monthbox == 5 || monthbox == 7 || monthbox == 8
					|| monthbox == 10 || monthbox == 12) {
				daybox = r.nextInt(30) + 1;
			}
			int withdrawal = 0; // Ż�𿩺�
			String birth = "";
			birth += birthyears[yearbox].substring(2, 4);
			birth += birthmonths[monthbox];
			birth += birthdays[daybox];
			
			String email = id.concat(gg);

			System.out.println("���̵�: " + id);
			
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