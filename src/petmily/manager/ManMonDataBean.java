package petmily.manager;

import java.sql.Timestamp;

public class ManMonDataBean {
	private String mon_id; 
	private String mon_name;
	private String mon_kind;
	private int mon_mile;
	private int mon_miletot; 
	private Timestamp mon_date;
	
	public String getMon_id() {
		return mon_id;
	}
	public void setMon_id(String mon_id) {
		this.mon_id = mon_id;
	}
	public String getMon_name() {
		return mon_name;
	}
	public void setMon_name(String mon_name) {
		this.mon_name = mon_name;
	}
	public String getMon_kind() {
		return mon_kind;
	}
	public void setMon_kind(String mon_kind) {
		this.mon_kind = mon_kind;
	}
	public int getMon_mile() {
		return mon_mile;
	}
	public void setMon_mile(int mon_mile) {
		this.mon_mile = mon_mile;
	}
	public int getMon_miletot() {
		return mon_miletot;
	}
	public void setMon_miletot(int mon_miletot) {
		this.mon_miletot = mon_miletot;
	}
	public Timestamp getMon_date() {
		return mon_date;
	}
	public void setMon_date(Timestamp mon_date) {
		this.mon_date = mon_date;
	} 
	
}