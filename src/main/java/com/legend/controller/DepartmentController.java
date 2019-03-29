package com.legend.controller;

import com.legend.bean.Department;
import com.legend.bean.Message;
import com.legend.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理和部门相关的信息
 * @author Create By legend
 * @date 2019/3/28 18:44
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     * @return
     */
    @ResponseBody
    @RequestMapping("/getDepts")
    public Message getAllDepts(){
        List<Department> list = departmentService.getAllDepts();
        return Message.success().add("depts",list);
    }
}
