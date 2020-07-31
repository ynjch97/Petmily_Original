package petmily.customer;
import java.sql.Timestamp;

public class CustomerDataBean {
	private String cus_id;
	private String cus_passwd;
	private String cus_name;
	private String cus_gender;
	private String cus_birth;
	private String cus_phone;
	private String cus_post;
	private String cus_addr;
	private int cus_mile;
	private Timestamp cus_reg_date;
    	
	public String getCus_id() {
		return cus_id;
	}
	public void setCus_id(String cus_id) {
		this.cus_id = cus_id;
	}
	public String getCus_passwd() {
		return cus_passwd;
	}
	public void setCus_passwd(String cus_passwd) {
		this.cus_passwd = cus_passwd;
	}
	public String getCus_name() {
		return cus_name;
	}
	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}
	public String getCus_gender() {
		return cus_gender;
	}
	public void setCus_gender(String cus_gender) {
		this.cus_gender = cus_gender;
	}
	public String getCus_birth() {
		return cus_birth;
	}
	public void setCus_birth(String cus_birth) {
		this.cus_birth = cus_birth;
	}
	public String getCus_phone() {
		return cus_phone;
	}
	public void setCus_phone(String cus_phone) {
		this.cus_phone = cus_phone;
	}
	public String getCus_post() {
		return cus_post;
	}
	public void setCus_post(String cus_post) {
		this.cus_post = cus_post;
	}
	public String getCus_addr() {
		return cus_addr;
	}
	public void setCus_addr(String cus_addr) {
		this.cus_addr = cus_addr;
	}
	public int getCus_mile() {
		return cus_mile;
	}
	public void setCus_mile(int cus_mile) {
		this.cus_mile = cus_mile;
	}
	public Timestamp getCus_reg_date() {
		return cus_reg_date;
	}
	public void setCus_reg_date(Timestamp cus_reg_date) {
		this.cus_reg_date = cus_reg_date;
	}
	
}