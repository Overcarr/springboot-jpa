package com.logan.spring_boot_jpa.service;

import com.logan.spring_boot_jpa.bean.Customer;
import com.logan.spring_boot_jpa.bean.LinkMan;
import com.logan.spring_boot_jpa.bean.Student;
import com.logan.spring_boot_jpa.dao.CustomerDao;
import com.logan.spring_boot_jpa.dao.LinkMenDao;
import com.logan.spring_boot_jpa.dao.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.List;


@Service
@Transactional
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
public class CustomerService {
    @Autowired
    public CustomerDao customerDao;

    @Autowired
    public StudentDao studentDao;

    @Autowired
    public LinkMenDao linkMenDao;

    public void saveOne(){
        Customer c = new Customer();
        c.setCustName("传智播客");
        customerDao.save(c);
    }

    public void update(){
        Customer customer = customerDao.getOne(98L);
        customer.setCustName("传智播客上海校区");
        customerDao.save(customer);
    }

    public Customer findByCustName(String custName){
        return customerDao.findByCustName(custName);
    }

    /**
     * 条件分页查询
     * @return
     */
    public Page<Student> findAll(){
        Student student = new Student();
        student.setSsex("男");
        Example<Student> example = Example.of(student);
        PageRequest pageRequest = PageRequest.of(1,2, Sort.Direction.DESC,"sid");
        Page<Student> all = studentDao.findAll(example, pageRequest);
        return all;
    }

    /**
     * 条件查询排序
     * @return
     */
    public List<Student> findAllSort(){
        Student student = new Student();
        student.setSsex("男");
        Example<Student> example = Example.of(student);
        Sort sort = Sort.by(Sort.Direction.DESC,"sid");
        List<Student> all = studentDao.findAll(example, sort);
        return all;
    }

    /**
     * 模糊查询
     * @return
     */
    public List<Student> findLike(){
        Specification <Student> spca = new Specification<Student>() {
            @Override
            public Predicate toPredicate(Root<Student> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate sname = cb.like(root.get("sname").as(String.class), "张%");
                Predicate sname1 = cb.equal(root.get("ssex").as(String.class), "男");
                query.where(sname,sname1);  //中间是 and 连接点 (student0_.s_name like ?) and student0_.s_sex=? limit ?
                return null;
            }
        };
        Pageable pageable = PageRequest.of(0,2, Sort.Direction.DESC,"sid");
        Page<Student> studentDaoAll = studentDao.findAll(spca, pageable);
        List<Student> all = studentDaoAll.getContent();
        return all;
    }

    /**
     * 一对多
     */
    public void oneToMany(){
        Customer c = new Customer();
        c.setCustName("TBD云集中心");
        c.setCustLevel("VIP客户");
        c.setCustSource("网络");
        c.setCustIndustry("商业办公");
        c.setCustAddress("昌平区北七家镇");
        c.setCustPhone("010-84389340");

        LinkMan l = new LinkMan();
        l.setLkmName("TBD联系人");
        l.setLkmGender("男");
        l.setLkmMobile("13811111111");
        l.setLkmPhone("010-34785348");
        l.setLkmEmail("98354834@qq.com");
        l.setLkmPosition("老师");
        l.setLkmMemo("还行吧");

        c.getLinkMENs().add(l);
        l.setCustomer(c);
        customerDao.save(c);
        linkMenDao.save(l);
    }

}
