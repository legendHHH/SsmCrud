# 总结

## 项目简介
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190327185138367-1128372478.png)



![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190327185234357-915710013.png)


![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190328190338408-1606632417.png)


## REST风格URL
```
PUT方法用来添加的资源
GET方法用来获取已有的资源
POST方法用来对资源进行状态转换
DELETE方法用来删除已有的资源
```


## 正则表达式的使用
```
在页面使用的话:
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;


后台使用:
    就是传过来的数据再做一次验证
         boolean b = email.matches("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$");
    
    使用的是字符串匹配方法函数        
```

## 为按钮绑定事件(是拼接上去的按钮类型不是直接定义然后绑定的)
```
var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")

绑定方式:         
    $(document).on("click",".edit_btn",function () {}
```


## 事件源改变函数
```
$("#empName_add_input").change(function () {
        //var empName = this.val();
}

```


## @PathVariable和@RequestMapping 的关系或者是区别
```
使用@RequestParam时，URL是这样的：http://localhost:8080/demo/path?参数名=参数值
使用@PathVariable时，URL是这样的：http:/localhost:8080/path/参数值
```

## JSON字符串解析
### 使用
```
引入Jar包(maven项目)
    <dependency>
          <groupId>com.fasterxml.jackson.core</groupId>
          <artifactId>jackson-databind</artifactId>
          <version>2.8.8</version>
    </dependency>


页面构建:
    function XXX() {
            $.ajax({
                url:"${pageContext.request.contextPath}/emp",
                type:"GET",
                data:"id=",
                success:function (result) {
                    console(result);
                }
            })
        }

后台处理:
    @ResponseBody
    @RequestMapping(value = "/XXX/{id}",method = RequestMethod.GET)
    public Message getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
            return Message.success().add("emp",employee);
        }        
```

## js的节点拼接
    - append()用的是元素添加或者是内容,有先后顺序
        - var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                          .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
        等价于:
            <button class="">
                <span class=""></span>
                编辑
            </button>    
        
    - attr() 添加属性,可以是自定义的
        - editBtn.attr("edit_id",item.empId);
        
        
        
## 模态框(请求的数据填充方式)
```
$("#empName_update_static").append(result.extend.emp.empName);//添加内容到p标签之间的内容
$("#email_update_input").val(result.extend.emp.email);//添加到input标签里面的内容
$("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);//填充单选框按钮的值
$("#empUpdateModal select").val([result.extend.emp.department.deptId]);//填充下拉列表数据

```

## Ajax请求PUT方式
```
web.xml 配置过滤器
    <!--将请求体中的数据解析包装成一个map  PUT方式-->
      <filter>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
      </filter>
      <filter-mapping>
        <filter-name>HttpPutFormContentFilter</filter-name>
        <url-pattern>/*</url-pattern>
      </filter-mapping>



$.ajax({
            url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit_id"),
            data:$("#empUpdateModal form").serialize(),
            type:"PUT",
            success:function (result) {
                //关闭模态框
                $("#empUpdateModal").modal('hide');

                //回到当前页
                to_page(currentNum);
            }
        });
``` 

## SpringMVC.xml   主要是自动扫描控制器，视图模式，注解的启动这三个。
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">


    <!--SpringMVC的配置文件，包含网站跳转逻辑的控制，配置  -->
    <context:component-scan base-package="com.legend" use-default-filters="false">
        <!--只扫描控制器。  -->
        <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller"/>
    </context:component-scan>

    <!--配置视图解析器，方便页面返回  -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="prefix" value="/WEB-INF/views/" />
        <property name="suffix" value=".jsp" />
    </bean>

    <!--两个标准配置  -->
    <!-- 将springmvc不能处理的请求交给tomcat 动静态资源访问-->
    <mvc:default-servlet-handler/>

    <!-- 能支持springmvc更高级的一些功能，JSR303校验，快捷的ajax...映射动态请求 -->
    <mvc:annotation-driven/>
</beans>
```

##web.xml 文件配置
```
<?xml version="1.0" encoding="UTF-8"?>
<web-app version="2.5" xmlns="http://java.sun.com/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee">

  <!--1、启动Spring的容器  -->
  <!-- needed for ContextLoaderListener -->
  <context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:applicationContext.xml</param-value>
  </context-param>

  <!-- Bootstraps the root web application context before servlet initialization -->
  <listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
  </listener>

  <!--2、springmvc的前端控制器，拦截所有请求  -->
  <!-- The front controller of this Spring Web application, responsible for handling all application requests -->
  <servlet>
    <servlet-name>dispatcherServlet</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

    <!--配置DispatcherServlet的一个初始化参数 :配置SpringMVC配置文件和名称-->
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>classpath:dispatcherServlet-servlet.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>

  <!-- Map all requests to the DispatcherServlet for handling -->
  <servlet-mapping>
    <servlet-name>dispatcherServlet</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>

  <!-- 3、字符编码过滤器，一定要放在所有过滤器之前 -->
  <filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
      <param-name>encoding</param-name>
      <param-value>utf-8</param-value>
    </init-param>
    <init-param>
      <param-name>forceRequestEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
    <init-param>
      <param-name>forceResponseEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
  </filter>
  <filter-mapping>
    <filter-name>CharacterEncodingFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>

  <!-- 4、使用Rest风格的URI，将页面普通的post请求转为指定的delete或者put请求 -->
  <filter>
    <filter-name>HiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
  </filter>
  <filter-mapping>
    <filter-name>HiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>

  <!--将请求体中的数据解析包装成一个map  PUT方式-->
  <filter>
    <filter-name>HttpPutFormContentFilter</filter-name>
    <filter-class>org.springframework.web.filter.HttpPutFormContentFilter</filter-class>
  </filter>
  <filter-mapping>
    <filter-name>HttpPutFormContentFilter</filter-name>
    <url-pattern>/*</url-pattern>
  </filter-mapping>
</web-app>

```

## Log4j.properties
```
log4j.rootLogger=DEBUG,Console,File  
#定义日志输出目的地为控制台  
log4j.appender.Console=org.apache.log4j.ConsoleAppender  
log4j.appender.Console.Target=System.out  
#可以灵活地指定日志输出格式，下面一行是指定具体的格式  
log4j.appender.Console.layout = org.apache.log4j.PatternLayout  
log4j.appender.Console.layout.ConversionPattern=[%c] - %m%n  
  
#文件大小到达指定尺寸的时候产生一个新的文件  
log4j.appender.File = org.apache.log4j.RollingFileAppender  
#指定输出目录  
log4j.appender.File.File = D:/logs/ssm.log  
#定义文件最大大小  
log4j.appender.File.MaxFileSize = 10MB  
# 输出所以日志，如果换成DEBUG表示输出DEBUG以上级别日志  
log4j.appender.File.Threshold = ALL  
log4j.appender.File.layout = org.apache.log4j.PatternLayout  
log4j.appender.File.layout.ConversionPattern =[%p] [%d{yyyy-MM-dd HH\:mm\:ss}][%c]%m%n
```

       