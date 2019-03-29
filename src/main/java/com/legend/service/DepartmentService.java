package com.legend.service;

import com.legend.bean.Department;
import com.legend.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务逻辑主键
 * @author Create By legend
 * @date 2019/3/28 18:45
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null );
    }
}
