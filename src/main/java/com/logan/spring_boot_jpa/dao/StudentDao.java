package com.logan.spring_boot_jpa.dao;


import com.logan.spring_boot_jpa.bean.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentDao extends JpaRepository<Student,Integer>, JpaSpecificationExecutor<Student> {
}
