package petmily.customer;
import java.sql.Date;
import java.sql.Timestamp;

public class ReserveDataBean {
	private int res_num;
	private String res_date;
	private String cus_id;
	private String cus_name;
	private String dog_id;
	private String dog_name;
	private String pet_id;
	private String pet_name;
	private int pet_cash;
	private int petmily_pet;
	private int petmily_fee;
	private String res_comment;
	private Timestamp res_reg_date;
    	
	public int getRes_num() {
		return res_num;
	}
	public void setRes_num(int res_num) {
		this.res_num = res_num;
	}
	public String getRes_date() {
		return res_date;
	}
	public void setRes_date(String res_date) {
		this.res_date = res_date;
	}	
	public String getCus_id() {
		return cus_id;
	}
	public void setCus_id(String cus_id) {
		this.cus_id = cus_id;
	}
	public String getCus_name() {
		return cus_name;
	}
	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}
	public String getDog_id() {
		return dog_id;
	}
	public void setDog_id(String dog_id) {
		this.dog_id = dog_id;
	}
	public String getDog_name() {
		return dog_name;
	}
	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}
	public String getPet_id() {
		return pet_id;
	}
	public void setPet_id(String pet_id) {
		this.pet_id = pet_id;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public int getPet_cash() {
		return pet_cash;
	}
	public void setPet_cash(int pet_cash) {
		this.pet_cash = pet_cash;
	}
	public int getPetmily_pet() {
		return petmily_pet;
	}
	public void setPetmily_pet(int petmily_pet) {
		this.petmily_pet = petmily_pet;
	}
	public int getPetmily_fee() {
		return petmily_fee;
	}
	public void setPetmily_fee(int petmily_fee) {
		this.petmily_fee = petmily_fee;
	}
	public String getRes_comment() {
		return res_comment;
	}
	public void setRes_comment(String res_comment) {
		this.res_comment = res_comment;
	}
	public Timestamp getRes_reg_date() {
		return res_reg_date;
	}
	public void setRes_reg_date(Timestamp res_reg_date) {
		this.res_reg_date = res_reg_date;
	}
	
}