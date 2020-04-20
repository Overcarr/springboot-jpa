package com.logan.spring_boot_jpa.controller;

import com.logan.spring_boot_jpa.bean.Customer;
import com.logan.spring_boot_jpa.bean.Student;
import com.logan.spring_boot_jpa.service.CustomerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping
@Api(tags = "CustomerController",description = "消费者")
public class CustomerController {

    @Autowired
    public CustomerService customerService;



    @ApiOperation("保存一个")
    @PostMapping("saveOne")
    public void saveOne(){
        customerService.saveOne();
    }

    @ApiOperation("更新")
    @PutMapping("update")
    public void update(){
        customerService.update();
    }

    @ApiOperation("根据信息查询")
    @GetMapping("findByCustName")
    public Customer findByCustName(){
        String custNmae = "传智播客上海校区";
        return customerService.findByCustName(custNmae);
    }

    @GetMapping("findAllStudent")
    public Page<Student> findAllStudent(){
        return customerService.findAll();
    }

    @GetMapping("findAllSort")
    public List<Student> findAllSort(){
        return customerService.findAllSort();
    }

    @GetMapping("findALike")
    public List<Student> findLike(){
        List<Student> like = customerService.findLike();
        return like;
    }

    @PutMapping("oneToMany")
    public void oneToMany(){
        customerService.oneToMany();;
    }
}
