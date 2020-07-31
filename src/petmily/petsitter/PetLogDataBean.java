package petmily.petsitter;
import java.sql.Timestamp;

public class PetLogDataBean {
	private int log_num;
	private String pet_id;
	private String cus_id;
	private String dog_id;
	private String pet_name;
	private String cus_name;
	private String dog_name;
	private String dog_pic;
	private String log_count;
	private String log_title;
	private String log_content;
	private String log_pic1;
	private String log_pic2;
	private String log_pic3;
	private String log_ip;
	private String res_date;
	private Timestamp log_date;
    	
	public int getLog_num() {
		return log_num;
	}
	public void setLog_num(int log_num) {
		this.log_num = log_num;
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
	public String getLog_count() {
		return log_count;
	}
	public void setLog_count(String log_count) {
		this.log_count = log_count;
	}
	public String getLog_title() {
		return log_title;
	}
	public void setLog_title(String log_title) {
		this.log_title = log_title;
	}
	public String getLog_content() {
		return log_content;
	}
	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}
	public String getLog_pic1() {
		return log_pic1;
	}
	public void setLog_pic1(String log_pic1) {
		this.log_pic1 = log_pic1;
	}
	public String getLog_pic2() {
		return log_pic2;
	}
	public void setLog_pic2(String log_pic2) {
		this.log_pic2 = log_pic2;
	}
	public String getLog_pic3() {
		return log_pic3;
	}
	public void setLog_pic3(String log_pic3) {
		this.log_pic3 = log_pic3;
	}
	public String getLog_ip() {
		return log_ip;
	}
	public void setLog_ip(String log_ip) {
		this.log_ip = log_ip;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}
	public Timestamp getLog_date() {
		return log_date;
	}
	public void setLog_date(Timestamp log_date) {
		this.log_date = log_date;
	}	
}