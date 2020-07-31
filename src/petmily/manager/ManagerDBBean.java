package petmily.manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.util.Date;
/*import java.util.Calendar;*/
/*import java.text.DecimalFormat;*/
import petmily.customer.CustomerDataBean;
import petmily.customer.DogDataBean;
import petmily.petsitter.PetsitterDataBean;

public class ManagerDBBean {

	private static ManagerDBBean instance = new ManagerDBBean();

	public static ManagerDBBean getInstance() {
		return instance;
	}

	private static class TIME_MAXIMUM {
		public static final int SEC = 60;
		public static final int MIN = 60;
		public static final int HOUR = 24;
		public static final int DAY = 30;
		public static final int MONTH = 12;
	}

	private ManagerDBBean() {
	}

	// Ŀ�ؼ�Ǯ�κ��� Ŀ�ؼǰ�ü�� ���� �޼ҵ�
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/petmily");
		return ds.getConnection();
	}

	// 1. ������ ���� �޼ҵ�
	public int managerCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select man_passwd from manager where man_id = ? ");
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("man_passwd");
				if (dbpasswd.equals(passwd))
					x = 1; // ���� ����
				else
					x = 0; // ��й�ȣ Ʋ��
			} else
				x = -1;// �ش� ���̵� ����

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	// 2(new). ����� ȸ������ ������ ���� ���ε��� ���� or ���ε� ����� ���� ǥ�� - �迭 ���
	public PetsitterDataBean[] getApprvPetsitter(int count, String apprv) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetsitterDataBean petList[] = null;
		int i = 0;

		try {
			conn = getConnection();

			String sql = "select * from petsitter where pet_apprv=?";
					
			/*"select * from petsitter p " + 
			"inner join pet_ma pm on p.pet_id = pm.pet_id " + 
			"inner join matching m on pm.m_que = m.m_que " + 
			"and pm.m_ans = m.tag where pet_apprv=?";*/
					
			/*"select * from petsitter where pet_apprv=?";*/
			/*String sql = "select * from petsitter where pet_apprv=? order by reg_date desc limit ?,?";*/
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, apprv);	
            /*pstmt.setInt(2, 0);
            pstmt.setInt(3, count);*/
			rs = pstmt.executeQuery();

			if (rs.next()) {
				petList = new PetsitterDataBean[count];

				do {
					PetsitterDataBean petsitter = new PetsitterDataBean();

					petsitter.setPet_id(rs.getString("pet_id"));
					petsitter.setPet_passwd(rs.getString("pet_passwd"));
					petsitter.setPet_name(rs.getString("pet_name"));
					petsitter.setPet_gender(rs.getString("pet_gender"));
					petsitter.setPet_birth(rs.getString("pet_birth"));
					petsitter.setPet_phone(rs.getString("pet_phone"));
					petsitter.setPet_post(rs.getString("pet_post"));
					petsitter.setPet_addr(rs.getString("pet_addr"));
					petsitter.setPet_lic(rs.getString("pet_lic"));
					petsitter.setPet_apprv(rs.getString("pet_apprv"));
					petsitter.setPet_intro(rs.getString("pet_intro"));
					petsitter.setPet_intro1(rs.getString("pet_intro1"));
					petsitter.setPet_intro2(rs.getString("pet_intro2"));
					petsitter.setPet_intro3(rs.getString("pet_intro3"));
					petsitter.setPet_reg_date(rs.getTimestamp("pet_reg_date"));
					
					/*System.out.println(">>>>>>>");
					System.out.println(i);
					System.out.println(">>>>>>>");*/
					petList[i] = petsitter;
					i++;

				} while (rs.next() && i<petList.length);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return petList;
	}

	// 2-1. ��ü ��ϵ� ������� ���� ��Ÿ���� �޼ҵ�
	public int getPetsitterCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from petsitter");
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	// 2-2. ���ε��� ����(pet_apprv=0) ������� ���� ��Ÿ���� �޼ҵ�
	public int getPetsitterYetCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from petsitter where pet_apprv = 0");
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	// 2-3. ����� ������ �� �� ������ �� �� ������ 
	public static String formatTimeString (Date tempDate) {
		long curTime = System.currentTimeMillis();
		long regTime = tempDate.getTime();
		long diffTime = (curTime - regTime) / 1000;
		String msg = null;
		
		if (diffTime < TIME_MAXIMUM.SEC) {
			msg = "��� ��";
		} else if ((diffTime /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) {
			msg = diffTime + "�� ��";
		} else if ((diffTime /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) {
			msg = (diffTime) + "�ð� ��";
		} else if ((diffTime /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) {
			msg = (diffTime) + "�� ��";
		} else if ((diffTime /= TIME_MAXIMUM.DAY) < TIME_MAXIMUM.MONTH) {
			msg = (diffTime) + "�� ��";
		} else {
			msg = (diffTime) + "�� ��";
		}
		return msg;
	}
	
	// 2-4(11/01). ���ε� ������� �±� ���� �迭�� ǥ�� - �迭 ���
	public String getPetsittersTag(String pet_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String tagList = "";

		try {
			conn = getConnection();

			String sql = "SELECT group_concat(m.remark separator '__') tagArray\r\n" + 
					"from petsitter p, pet_ma pm, matching m\r\n" + 
					"where p.pet_id = pm.pet_id\r\n" + 
					"and pm.m_que = m.m_que \r\n" + 
					"and pm.m_ans = m.tag\r\n" + 
					"and pet_apprv=1\r\n" + 
					"and pm.pet_id =? \r\n" + 
					"group by pm.pet_id;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pet_id);
			
			rs = pstmt.executeQuery();
			
			if (rs.next())
				tagList = rs.getString(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return tagList;
	}
	
	// 2-5. ����� �� ���� �±� ���� ��Ÿ���� �޼ҵ�
	public int getPetsitterTagCount(String pet_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from petsitter p, pet_ma pm, matching m "
					+ "where p.pet_id = pm.pet_id and pm.m_que = m.m_que and pm.m_ans = m.tag "
					+ "and pet_apprv=1 and pm.pet_id = ? group by p.pet_id");
			pstmt.setString(1, pet_id);
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	// 2-6. �±װ� �� ������� ���� ��Ÿ���� �޼ҵ�
	public int getPetsitterHaveTagCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from petsitter where pet_id in ( select p.pet_id from petsitter p, pet_ma pm, matching m "
					+ "where p.pet_id = pm.pet_id and pm.m_que = m.m_que and pm.m_ans = m.tag "
					+ "and pet_apprv=1 group by p.pet_id )");
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}
	
	// 3. ����� ������ ���� p et_apprv�� 1�� �ٲ��ִ� �޼ҵ�
	public void apprvPetsitter(String[] petId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql;

		try {
			conn = getConnection();

			sql = "update petsitter set pet_apprv='1' where pet_id=?";

			pstmt = conn.prepareStatement(sql);
			
			for(int i=0; i<petId.length; i++) {
				pstmt.setString(1, petId[i]);
				pstmt.executeUpdate();	
			}

			/*pstmt.setString(1, petId);
			pstmt.executeUpdate();*/	
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}

	// 4. ���� �ŷ� �߻� �Ǽ� ����ϱ� (reserve�� reg_date�� ����)

	// 5. �ǽð� ��� �����ֱ�
	
	// 6. ������ ����ó��
	public int ManagerCheck(String id, String passwd) 
	throws Exception {
		Connection conn = null;
        PreparedStatement pstmt = null;
		ResultSet rs= null;
        String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
           
			pstmt = conn.prepareStatement(
				    "select man_passwd from manager where man_id = ?");
			pstmt.setString(1, id);
			rs= pstmt.executeQuery();

			if(rs.next()){
				dbpasswd= rs.getString("man_passwd"); 
				if(dbpasswd.equals(passwd))
					x = 1; //���� ����
				else
					x = 0; //��й�ȣ Ʋ��
			}else
					x = -1;//�ش� ���̵� ����
				
		}catch(Exception ex) {
        	ex.printStackTrace();
        }finally {
			if (rs != null) 
				try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
		return x;
	}
	
	// 7. ����� �������� (cus_search)
	public PetsitterDataBean getPetsitter(String pet_id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetsitterDataBean petsitter = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from petsitter where pet_id = ?");
			pstmt.setString(1, pet_id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				petsitter = new PetsitterDataBean();

				petsitter.setPet_id(rs.getString("pet_id"));
				petsitter.setPet_passwd(rs.getString("pet_passwd"));
				petsitter.setPet_name(rs.getString("pet_name"));
				petsitter.setPet_gender(rs.getString("pet_gender"));
				petsitter.setPet_birth(rs.getString("pet_birth"));
				petsitter.setPet_phone(rs.getString("pet_phone"));
				petsitter.setPet_post(rs.getString("pet_post"));
				petsitter.setPet_addr(rs.getString("pet_addr"));
				petsitter.setPet_lic(rs.getString("pet_lic"));
				petsitter.setPet_apprv(rs.getString("pet_apprv"));
				petsitter.setPet_intro(rs.getString("pet_intro"));
				petsitter.setPet_cash(rs.getInt("pet_cash"));
				petsitter.setPet_intro1(rs.getString("pet_intro1"));
				petsitter.setPet_intro2(rs.getString("pet_intro2"));
				petsitter.setPet_intro3(rs.getString("pet_intro3"));
				petsitter.setPet_reg_date(rs.getTimestamp("pet_reg_date"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try { rs.close(); } catch (SQLException ex) { }
			if (pstmt != null)
				try { pstmt.close(); } catch (SQLException ex) { }
			if (conn != null)
				try { conn.close(); } catch (SQLException ex) { }
		}
		return petsitter;
	}
	
	// 8. ��ü ����� �������� man_list
	public PetsitterDataBean[] getAllPetsitter(int count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PetsitterDataBean petList[] = null;
		int i = 0;

		try {
			conn = getConnection();

			String sql = "select * from petsitter order by pet_reg_date desc";
				
			pstmt = conn.prepareStatement(sql);
            /*pstmt.setInt(2, 0);
            pstmt.setInt(3, count);*/
			rs = pstmt.executeQuery();

			if (rs.next()) {
				petList = new PetsitterDataBean[count];

				do {
					PetsitterDataBean petsitter = new PetsitterDataBean();

					petsitter.setPet_id(rs.getString("pet_id"));
					petsitter.setPet_passwd(rs.getString("pet_passwd"));
					petsitter.setPet_name(rs.getString("pet_name"));
					petsitter.setPet_gender(rs.getString("pet_gender"));
					petsitter.setPet_birth(rs.getString("pet_birth"));
					petsitter.setPet_phone(rs.getString("pet_phone"));
					petsitter.setPet_post(rs.getString("pet_post"));
					petsitter.setPet_addr(rs.getString("pet_addr"));
					petsitter.setPet_lic(rs.getString("pet_lic"));
					petsitter.setPet_apprv(rs.getString("pet_apprv"));
					petsitter.setPet_intro(rs.getString("pet_intro"));
					petsitter.setPet_intro1(rs.getString("pet_intro1"));
					petsitter.setPet_intro2(rs.getString("pet_intro2"));
					petsitter.setPet_intro3(rs.getString("pet_intro3"));
					petsitter.setPet_mile(rs.getInt("pet_mile"));
					petsitter.setPet_reg_date(rs.getTimestamp("pet_reg_date"));
					
					petList[i] = petsitter;
					i++;

				} while (rs.next() && i<petList.length);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return petList;
	}
		
	// 9. ��ü �� �������� man_list
	public CustomerDataBean[] getAllCustomer(int count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CustomerDataBean cusList[] = null;
		int i = 0;

		try {
			conn = getConnection();

			String sql = "select * from customer order by cus_reg_date desc";
				
			pstmt = conn.prepareStatement(sql);
            /*pstmt.setInt(2, 0);
            pstmt.setInt(3, count);*/
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cusList = new CustomerDataBean[count];

				do {
					CustomerDataBean customer = new CustomerDataBean();
					
					customer.setCus_id(rs.getString("cus_id"));
					customer.setCus_passwd(rs.getString("cus_passwd"));
					customer.setCus_name(rs.getString("cus_name"));
					customer.setCus_gender(rs.getString("cus_gender"));
					customer.setCus_birth(rs.getString("cus_birth"));
					customer.setCus_phone(rs.getString("cus_phone"));
					customer.setCus_post(rs.getString("cus_post"));
					customer.setCus_addr(rs.getString("cus_addr"));
					customer.setCus_mile(rs.getInt("cus_mile"));
					customer.setCus_reg_date(rs.getTimestamp("cus_reg_date"));
					
					cusList[i] = customer;
					i++;

				} while (rs.next() && i<cusList.length);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) 
            	try { rs.close(); } catch(SQLException ex) {}
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
		}
		return cusList;
	}
		
	// 10. ��ü ��ϵ� ���� ���� ��Ÿ���� �޼ҵ�
	public int getCustomerCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from customer");
			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}
}