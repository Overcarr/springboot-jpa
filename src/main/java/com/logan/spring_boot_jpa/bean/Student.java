package com.logan.spring_boot_jpa.bean;

import javax.persistence.*;


@Entity
@Table(name = "student")
public class Student {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name = "s_id")
    private Integer sid;
    @Column(name = "s_name")
    private String sname;
    @Column(name = "s_birth")
    private String sbirth;
    @Column(name = "s_sex")
    private String ssex;



    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getSbirth() {
        return sbirth;
    }

    public void setSbirth(String sbirth) {
        this.sbirth = sbirth;
    }

    public String getSsex() {
        return ssex;
    }

    public void setSsex(String ssex) {
        this.ssex = ssex;
    }

    @Override
    public String toString() {
        return "Student{" +
                "sid=" + sid +
                ", sname='" + sname + '\'' +
                ", sbirth='" + sbirth + '\'' +
                ", ssex='" + ssex + '\'' +
                '}';
    }
}
