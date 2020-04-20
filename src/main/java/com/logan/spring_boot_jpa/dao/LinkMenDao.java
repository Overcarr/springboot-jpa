package com.logan.spring_boot_jpa.dao;


import com.logan.spring_boot_jpa.bean.LinkMan;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LinkMenDao extends JpaRepository<LinkMan,Long> {
}
