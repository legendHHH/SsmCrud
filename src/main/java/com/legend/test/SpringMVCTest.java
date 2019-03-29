package com.legend.test;

import com.github.pagehelper.PageInfo;
import com.legend.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用Spring测试模块提供的测试请求功能，测试curd请求的正确性
 *
 * 运行报错:Spring4测试的时候,需要servlet3.0的支持
 *  @author Create By legend
 * @date 2019/3/28 8:35
 */
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class SpringMVCTest {

    /**
     * 传入SpringMvc的IOC
     */
    @Autowired
    WebApplicationContext context;


    /**
     * 虚拟mvc请求,获取到处理结果
     */
    MockMvc mockMvc;
    @Before
    public void initMokcMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }


    @Test
    public void testPage(){
        try {
            //模拟请求获取返回值
            MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();

            //请求成功后,请求域中会有pageInfo;我们将pageInfo作为验证
            MockHttpServletRequest request = result.getRequest();
            PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
            System.out.println("当前页码："+pageInfo.getPageNum());
            System.out.println("总页码："+pageInfo.getPages());
            System.out.println("总记录数："+pageInfo.getTotal());
            System.out.println("在页面需要连续显示的页码");

            int[] nums = pageInfo.getNavigatepageNums();
            for (int i : nums) {
                System.out.print(" "+i);
            }

            //获取员工数据
            List<Employee> list = pageInfo.getList();
            for (Employee employee: list) {
                System.out.println("ID："+employee.getEmpId()+"==>Name:"+employee.getEmpName());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
