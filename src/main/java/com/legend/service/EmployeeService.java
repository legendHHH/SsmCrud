package com.legend.service;

import com.legend.bean.Employee;
import com.legend.bean.EmployeeExample;
import com.legend.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Create By legend
 * @date 2019/3/27 23:11
 */
@Service
public class EmployeeService{
    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 查询所有员工,不需要条件
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 员工保存方法
     * @param employee
     */
    public void saveEmp(Employee employee) {
        int a = employeeMapper.insertSelective(employee);
        System.out.println("a"+a);
    }

    /**
     * 检查是否有重复的用户名
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();

        //添加拼接条件
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        //如果有数据则返回一个long类型的数值
        long count = employeeMapper.countByExample(employeeExample);

        return count ==0;
    }


    /**
     * 按照员工ID 获取Emp查询对象
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        //return employeeMapper.selectByPrimaryKey(id);
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    /**
     * 更新员工信息
     * @param employee
     */
    public boolean updateEmp(Employee employee) {
        int n = employeeMapper.updateByPrimaryKeySelective(employee);
        return n==0;
    }

    /**
     * 根据ID删除员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     * @param ids
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();

        EmployeeExample.Criteria criteria = example.createCriteria();

        //delete form tableName where emp_id in(1,2,3);
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
