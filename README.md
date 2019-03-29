# 总结

## REST风格URL
```
PUT方法用来添加的资源
GET方法用来获取已有的资源
POST方法用来对资源进行状态转换
DELETE方法用来删除已有的资源
```


##正则表达式的使用
```
在页面使用的话:
    var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;


后台使用:
    就是传过来的数据再做一次验证
         boolean b = email.matches("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$");
    
    使用的是字符串匹配方法函数        
```

##为按钮绑定事件(是拼接上去的按钮类型不是直接定义然后绑定的)
```
var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")

绑定方式:         
    $(document).on("click",".edit_btn",function () {}
```


##事件源改变函数
```
$("#empName_add_input").change(function () {
        //var empName = this.val();
}

```


## @PathVariable和@RequestMapping 的关系或者是区别
```
使用@RequestParam时，URL是这样的：http://host:port/path?参数名=参数值
使用@PathVariable时，URL是这样的：http://host:port/path/参数值
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

##SpringMVC.xml   主要是自动扫描控制器，视图模式，注解的启动这三个。
```
<?xml version="1.0" encoding="UTF-8"?>  
<beans xmlns="http://www.springframework.org/schema/beans"  
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"  
    xmlns:context="http://www.springframework.org/schema/context"  
    xmlns:mvc="http://www.springframework.org/schema/mvc"  
    xsi:schemaLocation="http://www.springframework.org/schema/beans    
                        http://www.springframework.org/schema/beans/spring-beans-3.1.xsd    
                        http://www.springframework.org/schema/context    
                        http://www.springframework.org/schema/context/spring-context-3.1.xsd    
                        http://www.springframework.org/schema/mvc    
                        http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd">  
    <!-- 自动扫描该包，使SpringMVC认为包下用了@controller注解的类是控制器 -->  
    <context:component-scan base-package="com.javen.controller" />  
    <!-- 扩充了注解驱动，可以将请求参数绑定到控制器参数 -->
    <mvc:annotation-driven/>
    <!-- 静态资源处理  css js imgs -->
    <mvc:resources location="/resources/**" mapping="/resources"/>
    
    <!--避免IE执行AJAX时，返回JSON出现下载文件 -->  
    <bean id="mappingJacksonHttpMessageConverter"  
        class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">  
        <property name="supportedMediaTypes">  
            <list>  
                <value>text/html;charset=UTF-8</value>  
            </list>  
        </property>  
    </bean>  
    <!-- 启动SpringMVC的注解功能，完成请求和注解POJO的映射 -->  
    <bean  
        class="org.springframework.web.servlet.mvc.annotation.AnnotationMethodHandlerAdapter">  
        <property name="messageConverters">  
            <list>  
                <ref bean="mappingJacksonHttpMessageConverter" /> <!-- JSON转换器 -->  
            </list>  
        </property>  
    </bean>  
      
    <!-- 配置文件上传，如果没有使用文件上传可以不用配置，当然如果不配，那么配置文件中也不必引入上传组件包 -->  
    <bean id="multipartResolver"    
        class="org.springframework.web.multipart.commons.CommonsMultipartResolver">    
        <!-- 默认编码 -->  
        <property name="defaultEncoding" value="utf-8" />    
        <!-- 文件大小最大值 -->  
        <property name="maxUploadSize" value="10485760000" />    
        <!-- 内存中的最大值 -->  
        <property name="maxInMemorySize" value="40960" />    
        <!-- 启用是为了推迟文件解析，以便捕获文件大小异常 -->
        <property name="resolveLazily" value="true"/>
    </bean>   
    
    <!-- 配置ViewResolver 。可用多个ViewResolver 。使用order属性排序。   InternalResourceViewResolver 放在最后-->
    <bean class="org.springframework.web.servlet.view.ContentNegotiatingViewResolver">
    <property name="order" value="1"></property>
        <property name="mediaTypes">
            <map>
                <!-- 告诉视图解析器，返回的类型为json格式 -->
                <entry key="json" value="application/json" />
                <entry key="xml" value="application/xml" />
                <entry key="htm" value="text/htm" />
            </map>
        </property>
        <property name="defaultViews">
            <list>
                <!-- ModelAndView里的数据变成JSON -->
                <bean class="org.springframework.web.servlet.view.json.MappingJacksonJsonView" />
            </list>
        </property>
        <property name="ignoreAcceptHeader" value="true"></property>
    </bean>
    
   <!-- 定义跳转的文件的前后缀 ，视图模式配置-->  
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">  
        <!-- 这里的配置我的理解是自动给后面action的方法return的字符串加上前缀和后缀，变成一个 可用的url地址 -->  
        <property name="prefix" value="/WEB-INF/jsp/" />  
        <property name="suffix" value=".jsp" />  
    </bean>  
</beans>
```

##web.xml 文件配置
```
<?xml version="1.0" encoding="UTF-8"?>  
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
    xmlns="http://java.sun.com/xml/ns/javaee"  
    xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"  
    version="3.0">  
    <display-name>Archetype Created Web Application</display-name>  
    <!-- Spring和mybatis的配置文件 -->  
   <!--  <context-param>  
        <param-name>contextConfigLocation</param-name>  
        <param-value>classpath:spring-mybatis.xml</param-value>  
    </context-param>   -->
    <!-- 编码过滤器 -->  
    <filter>  
        <filter-name>encodingFilter</filter-name>  
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>  
        <async-supported>true</async-supported>  
        <init-param>  
            <param-name>encoding</param-name>  
            <param-value>UTF-8</param-value>  
        </init-param>  
    </filter>  
    <filter-mapping>  
        <filter-name>encodingFilter</filter-name>  
        <url-pattern>/*</url-pattern>  
    </filter-mapping>  
    <!-- Spring监听器 -->  
   <!--  <listener>  
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>  
    </listener>   -->
    <!-- 防止Spring内存溢出监听器 -->  
    <!-- <listener>  
        <listener-class>org.springframework.web.util.IntrospectorCleanupListener</listener-class>  
    </listener>  --> 
  
    <!-- Spring MVC servlet -->  
    <servlet>  
        <servlet-name>SpringMVC</servlet-name>  
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>  
        <init-param>  
            <param-name>contextConfigLocation</param-name>  
            <param-value>classpath:spring-mvc.xml</param-value>  
        </init-param>  
        <load-on-startup>1</load-on-startup>  
        <async-supported>true</async-supported>  
    </servlet>  
    <servlet-mapping>  
        <servlet-name>SpringMVC</servlet-name>  
        <!-- 此处可以可以配置成*.do，对应struts的后缀习惯 -->  
        <url-pattern>/</url-pattern>  
    </servlet-mapping>  
    <welcome-file-list>  
        <welcome-file>/index.jsp</welcome-file>  
    </welcome-file-list>  
  
</web-app>
```

##Log4j.properties
```
log4j.rootLogger=INFO,Console,File  
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

       