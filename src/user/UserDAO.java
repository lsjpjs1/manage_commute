package user;

import java.sql.Connection;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;

import work.Work;



public class UserDAO {
	private Connection conn; // connection:db�������ϰ� ���ִ� ��ü

	private PreparedStatement pstmt;

	private ResultSet rs;

	// mysql�� ������ �ִ� �κ�

		public UserDAO() { // ������ ����ɶ����� �ڵ����� db������ �̷�� �� �� �ֵ�����

			try {

				String dbURL = "jdbc:mysql://localhost:3306/commute?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // localhost:3306 ��Ʈ�� ��ǻ�ͼ�ġ�� mysql�ּ�

				String dbID = "root";

				String dbPassword = "2501";

				Class.forName("com.mysql.jdbc.Driver");

				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

			} catch (Exception e) {

				e.printStackTrace(); // ������ �������� ���

			}

		}
		// �α����� �õ��ϴ� �Լ�****

		public int login(String userID, String userPassword) {

			String SQL = "SELECT userPassword FROM user WHERE userId = ?";

			try {

				// pstmt : prepared statement ������ sql������ db�� �����ϴ� �������� �ν��Ͻ�������

				pstmt = conn.prepareStatement(SQL);

				// sql������ ���� ��ŷ����� ����ϴ°�... pstmt�� �̿��� �ϳ��� ������ �̸� �غ��ؼ�(����ǥ���)

				// ����ǥ�ش��ϴ� ������ �������̵��, �Ű������� �̿�.. 1)�����ϴ��� 2)��й�ȣ��������

				pstmt.setString(1, userID);

				// rs:result set �� �������

				rs = pstmt.executeQuery();

				// ����� �����Ѵٸ� ����

				if (rs.next()) {

					// �н����� ��ġ�Ѵٸ� ����

					if (rs.getString(1).equals(userPassword)) {

						return 1; // ��� ����

					} else

						return 0; // ��й�ȣ ����ġ

				}

				return -1; // ���̵� ���� ����



			} catch (Exception e) {

				e.printStackTrace();

			}

			return -2; // �����ͺ��̽� ������ �ǹ�

		}

		public int join(User user) {

			String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?)";

			try {

				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, user.getUserId());

				pstmt.setString(2, user.getUserPassword());

				pstmt.setString(3, user.getUserName());

				pstmt.setString(4, user.getUserPosition());

				pstmt.setString(5, user.getUserBelong());
				
				pstmt.setString(6, "notAdmin");

				return pstmt.executeUpdate();

			} catch (Exception e) {

				e.printStackTrace();

			}

			return -1; // DB ����

		}
		public String getUserIdFromName(String userName) {
			String SQL = "SELECT * FROM user WHERE userName=?";
			try {


				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, userName);

				rs = pstmt.executeQuery();

				if (rs.next()) {

						return rs.getString(1); // ��� ����

				} else {

						return ""; // ��й�ȣ ����ġ

				}

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return ""; // �����ͺ��̽� ������ �ǹ�
		}
		
		public String getUserAdmin(String userId) {
			String SQL = "SELECT * FROM user WHERE userId=?";
			try {


				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, userId);

				rs = pstmt.executeQuery();

				if (rs.next()) {

						return rs.getString(6); // ��� ����

				} else {

						return ""; // ��й�ȣ ����ġ

				}

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return ""; // �����ͺ��̽� ������ �ǹ�
		}

		public String getUserName(String userId) {
			String SQL = "SELECT * FROM user WHERE userId=?";
			try {


				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, userId);

				rs = pstmt.executeQuery();

				if (rs.next()) {

						return rs.getString(3); // ��� ����

				} else {

						return ""; // ��й�ȣ ����ġ

				}

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return ""; // �����ͺ��̽� ������ �ǹ�
		}
		
		public String getUserBelong(String userId) {
			String SQL = "SELECT * FROM user WHERE userId=?";
			try {


				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, userId);

				rs = pstmt.executeQuery();

				if (rs.next()) {

						return rs.getString(5); // ��� ����

				} else {

						return ""; // ��й�ȣ ����ġ

				}

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return ""; // �����ͺ��̽� ������ �ǹ�
		}

		public String getUserPosition(String userId) {
			String SQL = "SELECT * FROM user WHERE userId=?";
			try {


				pstmt = conn.prepareStatement(SQL);

				pstmt.setString(1, userId);

				rs = pstmt.executeQuery();

				if (rs.next()) {

						return rs.getString(4); // ��� ����

				} else {

						return ""; // ��й�ȣ ����ġ

				}

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return ""; // �����ͺ��̽� ������ �ǹ�
		}
		
		public ArrayList<String> getUserNameAll(){
			String SQL = "SELECT * FROM user";
			ArrayList<String> userNameList = new ArrayList<String>();
			try {


				pstmt = conn.prepareStatement(SQL);

				rs = pstmt.executeQuery();
				
				
				
				while(rs.next()) {
					userNameList.add(rs.getNString(3));
				}
				
				return userNameList;

				



			} catch (Exception e) {

				e.printStackTrace();

			}

			return null; // �����ͺ��̽� ������ �ǹ�
		}
		
		
}
