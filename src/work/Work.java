package work;

import java.sql.Date;
import java.sql.Timestamp;

public class Work {
	private String userId;
	private String userName;
	private Date workDate;
	private Timestamp workStartPlan;
	private Timestamp workEndPlan;
	private Timestamp workStartReal;
	private Timestamp workEndReal;
	private String workContent;
	private int workUnitPlan;
	private int workUnitReal;
	public int getWorkUnitPlan() {
		return workUnitPlan;
	}
	public void setWorkUnitPlan(int workUnitPlan) {
		this.workUnitPlan = workUnitPlan;
	}
	public int getWorkUnitReal() {
		return workUnitReal;
	}
	public void setWorkUnitReal(int workUnitReal) {
		this.workUnitReal = workUnitReal;
	}
	public String getWorkContent() {
		return workContent;
	}
	public void setWorkContent(String workContent) {
		this.workContent = workContent;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getWorkDate() {
		return workDate;
	}
	public void setWorkDate(Date workDate) {
		this.workDate = workDate;
	}
	public Timestamp getWorkStartPlan() {
		return workStartPlan;
	}
	public void setWorkStartPlan(Timestamp workStartPlan) {
		this.workStartPlan = workStartPlan;
	}
	public Timestamp getWorkEndPlan() {
		return workEndPlan;
	}
	public void setWorkEndPlan(Timestamp workEndPlan) {
		this.workEndPlan = workEndPlan;
	}
	public Timestamp getWorkStartReal() {
		return workStartReal;
	}
	public void setWorkStartReal(Timestamp workStartReal) {
		this.workStartReal = workStartReal;
	}
	public Timestamp getWorkEndReal() {
		return workEndReal;
	}
	public void setWorkEndReal(Timestamp workEndReal) {
		this.workEndReal = workEndReal;
	}
	
}
