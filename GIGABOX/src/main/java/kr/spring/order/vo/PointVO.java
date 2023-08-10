package kr.spring.order.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PointVO {
	private int pt_num;
	private int res_num;
	private int orders_num;
	private int mem_num;
	private Date pt_date;
	private int add_point;
	private int use_point;
}
