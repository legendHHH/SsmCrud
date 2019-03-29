package com.legend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.legend.bean.Employee;
import com.legend.bean.Message;
import com.legend.bean.User;
import com.legend.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Create By legend
 * @date 2019/3/27 20:04
 */
@Controller
public class EmployeeController {

    /**
     * 调用Service层
     */
    @Autowired
    private EmployeeService employeeService;


    /**
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    public Message deleteEmpById(@PathVariable("id") Integer id){
        //删除员工
        employeeService.deleteEmp(id);
        return Message.success();
    }


    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee
     * [empId=1014, empName=null, gender=null, email=null, dId=null]
     *
     * 问题：
     * 请求体中有数据；
     * 但是Employee对象封装不上；
     * update tbl_emp  where emp_id = 1014;
     *
     * 原因：
     * Tomcat：
     * 		1、将请求体中的数据，封装一个map。
     * 		2、request.getParameter("empName")就会从这个map中取值。
     * 		3、SpringMVC封装POJO对象的时候。
     * 				会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     * org.apache.catalina.connector.Request--parseParameters() (3111);
     *
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
     success = true;
     return;
     }
     *
     *
     * 解决方案；
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1、配置上HttpPutFormContentFilter；
     * 2、他的作用；将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     * 员工更新方法
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Message saveEmp(Employee employee, HttpServletRequest request){
        System.out.println("请求体中的对象是:"+request.getParameter("gender"));
        System.out.println("传过来的数据是"+employee);

        //更新操作
        employeeService.updateEmp(employee);
        return Message.success();
    }


    /**
     * 根据id进行员工查询   GET方式提交
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.GET)
    public Message getEmp(@RequestParam("id") Integer id){
        System.out.println("当前修改的员工id是"+id);
        Employee employee = employeeService.getEmp(id);
        System.out.println(""+employee);
        return Message.success().add("emp",employee);

    }


    /**
     * 邮箱验证
     * @param email
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmail")
    public Message checkEmail(@RequestParam("email") String email){
        boolean b = email.matches("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$");
        if (b){
            return Message.success().add("v_email","邮箱输入正确");
        }else {
            return Message.failure().add("v_email","邮箱格式错误,请重新填写");
        }
    }


    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkUser")
    public Message checkUser(@RequestParam("empName") String empName){
        //先校验用户名是否可用
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        //判断字符串是否匹配我的正则表达式 matches方法
        if(!empName.matches(regx)){
            return Message.failure().add("validate_msg","用户名必须是2-5位中文或者6-16位英文和数字的组合");
        }

        //进行数据库用户名验证
        //判断用户名是否存在
        boolean flag = employeeService.checkUser(empName);

        if (flag){
            return Message.success();
        }else {
            return Message.failure().add("validate_msg","用户名不可用");
        }
    }



    /**
     * 优化:
     * 1.支持JSR303校验
     * 2.Hibernate-Validator
     * @Validd   返回结果在BindingResult
     *
     *
     * 保存员工(模态框数据)
     *
     * 如果需要向前台传输JSON数据的话就需要ResponseBody注解
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Message saveEmp(@Valid Employee employee, BindingResult result){
        //如果有错误
        if (result.hasErrors()){
            //创建Map集合保存错误信息返回给json前台数据
            Map<String,Object> map = new HashMap<String,Object>();

            //校验失败,返回失败信息,在模态框中显示校验信息
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldErrors:errors) {
                System.out.println("错误的字段名"+fieldErrors.getField());
                System.out.println("错误的信息"+fieldErrors.getDefaultMessage());

                //有一个错误就保存一个错误
                map.put(fieldErrors.getField(),fieldErrors.getDefaultMessage());
            }
            //返回错误信息
            return Message.failure().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            System.out.println("保存模态框员工数据");
            //返回成功状态码
            return Message.success();
        }

    }
    /*@ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Message saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        System.out.println("保存模态框员工数据");
        //返回成功状态码
        return Message.success();
    }*/


    /**
     * 测试返回自定义的json对象
     * @return
     */
    @ResponseBody
    @RequestMapping("/emp")
    public Employee getEmp(){
        Employee e = new Employee(1,"1","1","1",1);
        return e;
    }


    /**
     * 通过JSON数据返回页面处理
     *
     * 导入jackson包
     * @param pn
     * @return
     */
    @RequestMapping("/empsWithJson")
    @ResponseBody
    public Message getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //制作一个分页查询
        //引入pageHelper 分页插件
        //在查询之前只需要调用,传入页码,以及每页大小
        PageHelper.startPage(pn,5);

        List<Employee> emps = employeeService.getAll();

        //PageInfo 包装查询的所有数据,只需要将pageInfo交给页面
        //封装了详细的分页信息,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);

        //重新组装json对象
        return Message.success().add("pageInfo",page);
    }


    /**
     * 查询员工数据(分页查询)
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn, Model model){
        //制作一个分页查询
        //引入pageHelper 分页插件
        //在查询之前只需要调用,传入页码,以及每页大小
        PageHelper.startPage(pn,5);

        List<Employee> emps = employeeService.getAll();

        //PageInfo 包装查询的所有数据,只需要将pageInfo交给页面
        //封装了详细的分页信息,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);

        model.addAttribute("pageInfo",page);
        return "list";
    }
}
