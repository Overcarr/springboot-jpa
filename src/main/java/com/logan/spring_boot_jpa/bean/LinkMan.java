package com.logan.spring_boot_jpa.bean;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="cst_linkman")
@Getter
@Setter
public class LinkMan implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "lkm_id")
	private Long lkmId;
	@Column(name = "lkm_name")
	private String lkmName;
	@Column(name = "lkm_gender")
	private String lkmGender;
	@Column(name = "lkm_phone")
	private String lkmPhone;
	@Column(name = "lkm_mobile")
	private String lkmMobile;
	@Column(name = "lkm_email")
	private String lkmEmail;
	@Column(name = "lkm_position")
	private String lkmPosition;
	@Column(name = "lkm_memo")
	private String lkmMemo;

	@ManyToOne(targetEntity = Customer.class)
	@JoinColumn(name = "lkm_cust_id",referencedColumnName = "cust_id")
	private Customer customer;


}