package petmily.customer;
import java.sql.Date;
import java.sql.Timestamp;

public class CusReviewDataBean {
	private String rev_num;
	private String pet_id;
	private String cus_id;
	private String dog_id;
	private String pet_name;
	private String cus_name;
	private String dog_name;
	private String dog_pic;
	private String rev_content;
	private int rev_star;
	private String rev_ip;
	private String res_date;
	private Timestamp rev_date;
    	
	public String getRev_num() {
		return rev_num;
	}
	public void setRev_num(String rev_num) {
		this.rev_num = rev_num;
	}
	public String getPet_id() {
		return pet_id;
	}
	public void setPet_id(String pet_id) {
		this.pet_id = pet_id;
	}
	public String getCus_id() {
		return cus_id;
	}
	public void setCus_id(String cus_id) {
		this.cus_id = cus_id;
	}
	public String getDog_id() {
		return dog_id;
	}
	public void setDog_id(String dog_id) {
		this.dog_id = dog_id;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public String getCus_name() {
		return cus_name;
	}
	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}
	public String getDog_name() {
		return dog_name;
	}
	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}
	public String getDog_pic() {
		return dog_pic;
	}
	public void setDog_pic(String dog_pic) {
		this.dog_pic = dog_pic;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public int getRev_star() {
		return rev_star;
	}
	public void setRev_star(int rev_star) {
		this.rev_star = rev_star;
	}
	public String getRev_ip() {
		return rev_ip;
	}
	public void setRev_ip(String rev_ip) {
		this.rev_ip = rev_ip;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}
	public Timestamp getRev_date() {
		return rev_date;
	}
	public void setRev_date(Timestamp rev_date) {
		this.rev_date = rev_date;
	}
	
}