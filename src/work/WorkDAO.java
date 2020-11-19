package work;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Locale;
import java.sql.PreparedStatement;
import java.text.ParseException;
import java.sql.ResultSet;

//현재시간 구하기 위해
import java.sql.Timestamp;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import java.util.Date;


public class WorkDAO {





		private Connection conn; // connection:db에접근하게 해주는 객체

		//private PreparedStatement pstmt;

		private ResultSet rs;
		
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		
		SimpleDateFormat formatterForDate = new SimpleDateFormat ("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		String today = null;

		
		//mysql 처리부분
		public WorkDAO() {
			try {

				String dbURL = "jdbc:mysql://localhost:3306/commute?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // localhost:3306 포트는 컴퓨터설치된 mysql주소

				String dbID = "root";

				String dbPassword = "2501";

				Class.forName("com.mysql.jdbc.Driver");

				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

			} catch (Exception e) {

				e.printStackTrace(); // 오류가 무엇인지 출력

			}
		}
		
		
		public int clickArrive(String userId) {
			String SQL = "UPDATE work set workStartReal = ? where userId = ? AND workDate = ?";
			try {
				
				
				today = formatter.format(cal.getTime());
				
				Timestamp ts = Timestamp.valueOf(today);
				
				Date d = new Date(ts.getTime());
				
				String stringTs = formatter.format(ts);
				
				String stringD = formatterForDate.format(d);
				
				if(isNullWorkStartReal(userId, stringD)==1) {
					
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, stringTs);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, stringD);

					return pstmt.executeUpdate();
				}else if(isNullWorkStartReal(userId, stringD)==-3) {
					return -3;
				}else if(isNullWorkStartReal(userId, stringD)==-2) {
					return -2;
				}else {
					return -1;
				}
				
				
				
			}catch (Exception e) {
				
				e.printStackTrace();
				
			}
			
			return -1;
			
		} 
		
		public String getLunch(String userId, String workDate) {
			String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, workDate);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
						return rs.getString("lunch");  // workStartReal이 NULL이 아닐 때
					
				}else {
					String SQL1 = "INSERT INTO work (userId, workDate) VALUES (?, ?)";
					
					PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
					
					pstmt1.setString(1, userId);
					
					pstmt1.setString(2, workDate);
					
					pstmt1.executeUpdate();
					return "O"; // 해당 entry 자체가 존재하지 않을 때
				}
					
			}catch (Exception e) {
			
				e.printStackTrace();
		
			}
			return "O";
		}
		
		public int isNullWorkStartReal(String userId,String workDate) {
			String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, workDate);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(rs.getString("workStartReal")==null) { //
						return 1;   // workStartReal이 NULL일 때
					}else {
						return -3;  // workStartReal이 NULL이 아닐 때
					}
				}else {
					String SQL1 = "INSERT INTO work (userId, workDate) VALUES (?, ?)";
					
					PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
					
					pstmt1.setString(1, userId);
					
					pstmt1.setString(2, workDate);
					
					pstmt1.executeUpdate();
					
					return 1; 
				}
					
			}catch (Exception e) {
			
				e.printStackTrace();
		
			}
			
			return -1; // 데이터베이스 오류
		
		}
		
		public String getWorkStartReal(String userId, String workDate) {
			String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, workDate);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(rs.getString("workStartReal")==null) { //
						return "";   // workStartReal이 NULL일 때
					}else {
						return rs.getString("workStartReal");  // workStartReal이 NULL이 아닐 때
					}
				}else {
					return ""; // 해당 entry 자체가 존재하지 않을 때
				}
					
			}catch (Exception e) {
			
				e.printStackTrace();
		
			}
			return "";
		}
		
		public String getWorkEndReal(String userId, String workDate) {
			String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, workDate);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(rs.getString("workEndReal")==null) { //
						return "";   // workStartReal이 NULL일 때
					}else {
						return rs.getString("workEndReal");  // workStartReal이 NULL이 아닐 때
					}
				}else {
					return ""; // 해당 entry 자체가 존재하지 않을 때
				}
					
			}catch (Exception e) {
			
				e.printStackTrace();
		
			}
			return "";
		}
		
		public int clickLeave(String userId) {
			String SQL = "UPDATE work set workEndReal = ?,workUnitReal = ? where userId = ? AND workDate = ?";
			try {
				
				today = formatter.format(cal.getTime());
				
				Timestamp ts = Timestamp.valueOf(today);
				
				Date d = new Date(ts.getTime());
				
				String stringTs = formatter.format(ts);
				
				String stringD = formatterForDate.format(d);
				
				int isNullWorkStartRealValue = isNullWorkStartReal(userId, stringD);
				
				int isNullWorkStartEndValue = isNullWorkEndReal(userId, stringD);
				
				if(isNullWorkStartRealValue==1) {

					return -10; //출근이 아직 안찍혔으면 -10 리턴
					
				}else if(isNullWorkStartRealValue==-2) {
					
					return -2; //근무 계획 미등록 -2
					
				}else if(isNullWorkStartRealValue==-3) {
					
					if(isNullWorkStartEndValue==1) {
						
						
						
						String workStartReal = getWorkStartReal(userId, stringD);
						
						Date workStartRealDate = formatter.parse(workStartReal);
						
						Date workEndRealDate = formatter.parse(stringTs);
						
						long diff = workEndRealDate.getTime() - workStartRealDate.getTime();
						
						long hour = diff/3600000;
						
						if(getLunch(userId, stringD).equals("X")&&hour>0) {
							hour= hour-1;
						}
						
						long unit = hour/4;
						
						int workUnitReal = (int)unit;
						
						if(hour>=6 && hour<8) { //1.5단위
							workUnitReal = -1;
						}
						
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setString(1, stringTs);
						
						pstmt.setInt(2, workUnitReal);
						
						pstmt.setString(3, userId);
						
						pstmt.setString(4, stringD);
						
						

						return pstmt.executeUpdate(); // 정상 퇴근 처리
						
					}else if(isNullWorkStartEndValue==-3) {
						
						return -3; //이미 퇴근 찍힘
						
					}
				}else {
					
					return -1; // 디비 오류
					
				}
				
				
				
			}catch (Exception e) {
				
				e.printStackTrace();
				
			}
			
			return -1;
		}
		
		public int ReClickLeave(String userId) {
			String SQL = "UPDATE work set workEndReal = ?,workUnitReal = ? where userId = ? AND workDate = ?";
			try {
				
				today = formatter.format(cal.getTime());
				
				Timestamp ts = Timestamp.valueOf(today);
				
				Date d = new Date(ts.getTime());
				
				String stringTs = formatter.format(ts);
				
				String stringD = formatterForDate.format(d);
				
						
						String workStartReal = getWorkStartReal(userId, stringD);
						
						Date workStartRealDate = formatter.parse(workStartReal);
						
						Date workEndRealDate = formatter.parse(stringTs);
						
						long diff = workEndRealDate.getTime() - workStartRealDate.getTime();
						
						long hour = diff/3600000;
						
						if(getLunch(userId, stringD).equals("X")&&hour>0) {
							hour= hour-1;
						}
						
						long unit = hour/4;
						
						int workUnitReal = (int)unit;
						
						if(hour>=6 && hour<8) { //1.5단위
							workUnitReal = -1;
						}
					
						
						PreparedStatement pstmt = conn.prepareStatement(SQL);
						
						pstmt.setString(1, stringTs);
						
						pstmt.setInt(2, workUnitReal);
						
						pstmt.setString(3, userId);
						
						pstmt.setString(4, stringD);
						
						

						return pstmt.executeUpdate(); // 정상 퇴근 처리
						
					
				
				
			}catch (Exception e) {
				
				e.printStackTrace();
				
			}
			
			return -1;
		}
		
		public int isNullWorkEndReal(String userId,String workDate) {
			String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, workDate);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(rs.getString("workEndReal")==null) { //
						return 1;   // workStartReal이 NULL일 때
					}else {
						return -3;  // workStartReal이 NULL이 아닐 때
					}
				}else {
					return -2; // 해당 entry 자체가 존재하지 않을 때
				}
					
			}catch (Exception e) {
			
				e.printStackTrace();
		
			}
			
			return -1; // 데이터베이스 오류
		
		}
		
		public ArrayList<Work> getWorkSchedule(String workDate){
			String SQL = "SELECT * FROM work WHERE workDate = ?";
			
			ArrayList<Work> workSchedule = new ArrayList<Work>();
			
			try {
				
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, workDate);
	
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Work workLine = new Work();
					String temp="";
					workLine.setUserId(rs.getString(1));
					workLine.setUserName(rs.getString(2));
					workLine.setWorkDate(rs.getDate(3));
					temp = rs.getString(4);
					if(temp != null) {
						workLine.setWorkStartPlan(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkStartPlan(rs.getTimestamp(4));
					}
					temp = rs.getString(5);
					if(temp != null) {
						workLine.setWorkEndPlan(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkEndPlan(rs.getTimestamp(5));
					}
					temp = rs.getString(6);
					if(temp != null) {
						workLine.setWorkStartReal(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkStartReal(rs.getTimestamp(6));
					}
					temp = rs.getString(7);
					if(temp != null) {
						workLine.setWorkEndReal(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkEndReal(rs.getTimestamp(7));
					}
					workLine.setWorkContent(rs.getString(8));
					workLine.setWorkUnitPlan(rs.getInt(9));
					workLine.setWorkUnitReal(rs.getInt(10));
					
					workSchedule.add(workLine);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			return workSchedule;
		}
		
		public ArrayList<Work> getWorkLog(String userId, String year, String month){
			
			String SQL = "SELECT * FROM work WHERE userId = ? AND year(workDate)= ? AND month(workDate) = ? AND workStartReal != ''  ";
			
			ArrayList<Work> workLog = new ArrayList<Work>();
			
			try {
				
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				
				pstmt.setString(1, userId);
				
				pstmt.setString(2, year);
				
				pstmt.setString(3, month);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					Work workLine = new Work();
					String temp="";
					workLine.setUserId(rs.getString(1));
					workLine.setUserName(rs.getString(2));
					workLine.setWorkDate(rs.getDate(3));
					workLine.setWorkStartPlan(rs.getTimestamp(4));
					workLine.setWorkEndPlan(rs.getTimestamp(5));
					temp = rs.getString(6);
					if(temp != null) {
						workLine.setWorkStartReal(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkStartReal(rs.getTimestamp(6));
					}
					temp = rs.getString(7);
					if(temp != null) {
						workLine.setWorkEndReal(java.sql.Timestamp.valueOf(temp+".0"));
					}else {
						workLine.setWorkEndReal(rs.getTimestamp(7));
					}
					
					workLine.setWorkContent(rs.getString(8));
					workLine.setWorkUnitPlan(rs.getInt(9));
					workLine.setWorkUnitReal(rs.getInt(10));
					
					workLog.add(workLine);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			return workLog;
		}
			
			public int setWorkContent(String userId, String workContent) {
				
				String SQL = "UPDATE work set workContent = ? where userId = ? AND workDate = ?";
				
				try {
					
					today = formatter.format(cal.getTime());
					
					Timestamp ts = Timestamp.valueOf(today);
					
					Date d = new Date(ts.getTime());
					
					String stringD = formatterForDate.format(d);
					
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, workContent);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, stringD);
					
					if( pstmt.executeUpdate()==0) {
						String SQL1 = "INSERT INTO work (userId, workDate, workContent) VALUES (?, ?, ?)";
						
						PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
						
						pstmt1.setString(1, userId);
						
						pstmt1.setString(2, stringD);
						
						pstmt1.setString(3, workContent);
						
						pstmt1.executeUpdate();
						
						return 1; 
					}else {
						return 1;
					}
					
				}catch (Exception e) {
					e.printStackTrace();
				}
				return 0;
			}
			
public int setLunch(String userId, String lunch) {
				
				String SQL = "UPDATE work set lunch = ? where userId = ? AND workDate = ?";
				
				try {
					
					today = formatter.format(cal.getTime());
					
					Timestamp ts = Timestamp.valueOf(today);
					
					String stringTs = formatter.format(ts);
					
					Date d = new Date(ts.getTime());
					
					String stringD = formatterForDate.format(d);
					
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, lunch);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, stringD);
					
					pstmt.executeUpdate();
					
					if(getWorkStartReal(userId, stringD)!=null && getWorkEndReal(userId, stringD)!=null) {
						String workStartReal = getWorkStartReal(userId, stringD);
						
						Date workStartRealDate = formatter.parse(workStartReal);
						
						Date workEndRealDate = formatter.parse(stringTs);
						
						long diff = workEndRealDate.getTime() - workStartRealDate.getTime();
						
						long hour = diff/3600000;
						
						if(getLunch(userId, stringD).equals("X")&&hour>0) {
							hour= hour-1;
						}
						
						long unit = hour/4;
						
						int workUnitReal = (int)unit;
						
						if(hour>=6 && hour<8) { //1.5단위
							workUnitReal = -1;
						}
						
						String SQL1 = "UPDATE work set workUnitReal = ? where userId = ? AND workDate = ?";
						
						PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
						
						pstmt1.setInt(1, workUnitReal);
						
						pstmt1.setString(2, userId);
						
						pstmt1.setString(3, stringD);
						
						

						pstmt1.executeUpdate();
						
						
					}
					
					return 1;
					
				}catch (Exception e) {
					e.printStackTrace();
				}
				return 0;
			}

			public String getWorkStartPlan(String userId, String workDate) {
				String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, userId);
					
					pstmt.setString(2, workDate);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(rs.getString("workStartPlan")==null) { //
							return "";   // workStartReal이 NULL일 때
						}else {
							return rs.getString("workStartPlan");  // workStartReal이 NULL이 아닐 때
						}
					}else {
						return ""; // 해당 entry 자체가 존재하지 않을 때
					}
						
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
				return "";
			}
			
			public String getWorkEndPlan(String userId, String workDate) {
				String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, userId);
					
					pstmt.setString(2, workDate);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(rs.getString("workEndPlan")==null) { //
							return "";   // workStartReal이 NULL일 때
						}else {
							return rs.getString("workEndPlan");  // workStartReal이 NULL이 아닐 때
						}
					}else {
						return ""; // 해당 entry 자체가 존재하지 않을 때
					}
						
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
				return "";
			}
			
			public String getWorkUnitPlan(String userId, String workDate) {
				String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, userId);
					
					pstmt.setString(2, workDate);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(rs.getInt("workUnitPlan")==0) { //
							return "";   
						}else if(rs.getInt("workUnitPlan")==-1){
							return "1.5";
						}else {
							String workUnitPlanStr =Integer.toString(rs.getInt("workUnitPlan"));
							return workUnitPlanStr;  
						}
					}else {
						return ""; // 해당 entry 자체가 존재하지 않을 때
					}
						
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
				return "";
			}
			
			public int getWorkUnitReal(String userId, String workDate) {
				String SQL = "SELECT * FROM work WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, userId);
					
					pstmt.setString(2, workDate);
					
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(rs.getInt("workUnitReal")==0) { //
							return 0;   
						}else if(rs.getInt("workUnitReal")==-1){
							return -1;
						}else {
							return rs.getInt("workUnitReal");  
						}
					}else {
						return 0; // 해당 entry 자체가 존재하지 않을 때
					}
						
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
				return 0;
			}
			
			
			
			public void setWorkStartPlan(String userId, String workDate, String workStartPlan) {
				String SQL = "UPDATE work SET workStartPlan = ? WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, workStartPlan);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, workDate);
					
					if( pstmt.executeUpdate()==0) {
						String SQL1 = "INSERT INTO work (userId, workDate, workStartPlan) VALUES (?, ?, ?)";
						
						PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
						
						pstmt1.setString(1, userId);
						
						pstmt1.setString(2, workDate);
						
						pstmt1.setString(3, workStartPlan);
						
						pstmt1.executeUpdate();
					}
					
					
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
			}
			
			public void setWorkEndPlan(String userId, String workDate, String workEndPlan) {
				String SQL = "UPDATE work SET workEndPlan = ? WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					pstmt.setString(1, workEndPlan);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, workDate);
					
					if( pstmt.executeUpdate()==0) {
						String SQL1 = "INSERT INTO work (userId, workDate, workEndPlan) VALUES (?, ?, ?)";
						
						PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
						
						pstmt1.setString(1, userId);
						
						pstmt1.setString(2, workDate);
						
						pstmt1.setString(3, workEndPlan);
						
						pstmt1.executeUpdate();
					}
					
					
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
			}
			
			public void setWorkUnitPlan(String userId, String workDate, String workUnitPlan) {
				String SQL = "UPDATE work SET workUnitPlan = ? WHERE userId = ? AND workDate = ?";
				try {
					PreparedStatement pstmt = conn.prepareStatement(SQL);
					
					int workUnitPlanInt=0;
					
					if(workUnitPlan==null) {
						workUnitPlanInt = 0; 
					}else if(workUnitPlan.equals("1.5")){
						workUnitPlanInt = -1; 
					}else {
						workUnitPlanInt = Integer.parseInt(workUnitPlan);
					}
					
					pstmt.setInt(1, workUnitPlanInt);
					
					pstmt.setString(2, userId);
					
					pstmt.setString(3, workDate);
					
					if( pstmt.executeUpdate()==0) {
						String SQL1 = "INSERT INTO work (userId, workDate, workUnitPlan) VALUES (?, ?, ?)";
						
						PreparedStatement pstmt1 = conn.prepareStatement(SQL1);
						
						pstmt1.setString(1, userId);
						
						pstmt1.setString(2, workDate);
						
						pstmt1.setInt(3, workUnitPlanInt);
						
						pstmt1.executeUpdate();
					}
					
					
				}catch (Exception e) {
				
					e.printStackTrace();
			
				}
			}
			
			
}
