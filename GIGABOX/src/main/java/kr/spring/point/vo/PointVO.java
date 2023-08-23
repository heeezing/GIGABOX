package kr.spring.point.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointVO {
	private int pt_num;
	private String res_num;
	private String orders_num;
	private String pt_detail;
	private int mem_num;
	private Date pt_date;
	private int add_point;
	private int use_point;
	
	private int have_point;
	
	private String id;
	private String sn_name;
	private int orders_total;
	private int res_total;
	private String m_title;
	
}
