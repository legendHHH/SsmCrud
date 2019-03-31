# SSM项目整合

## 1.项目简介
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330112820358-1327790500.png)

### 1.1 功能点
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190327185138367-1128372478.png)

### 1.2 技术点
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190327185234357-915710013.png)


## 2. 总体基础环境搭建
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330123252412-1849242388.png)


>下面的第一个是配置maven仓库地址 默认的是在    .m2目录下面
>在D:\software\apache-maven-3.3.9\conf  下找到settings.xml 文件的mirrors节点添加下面配置文件,加快下载速度.
>添加jdk编译版本 profiles节点.
>如果是用默认的就会编译版本过时的问题出现
```
<localRepository>D:\WorkCode\local_maven_repository</localRepository>

<mirror>
		<id>nexus-aliyun</id>
		<mirrorOf>central</mirrorOf>
		<name>Nexus aliyun</name>
		<url>http://maven.aliyun.com/nexus/content/repositories/central</url>
</mirror>



<profile>
	  <id>jdk-1.8</id>
	  <activation>
		<activeByDefault>true</activeByDefault>
		<jdk>1.8</jdk>
	  </activation>
	  <properties>
		<maven.compiler.source>1.8</maven.compiler.source>
		<maven.compiler.target>1.8</maven.compiler.target>
		<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
	  </properties>
	</profile>
```

### 2.1 pom.xml  引入jar包依赖
```
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.legend</groupId>
  <artifactId>ssm</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>war</packaging>

   <!--引入需要的jar包  下面的是maven仓库地址-->
  <dependencies>
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->

    <!--JSR303数据校验支持；tomcat7及以上的服务器，
		tomcat7以下的服务器：el表达式。额外给服务器的lib包中替换新的标准的el
		-->
    <dependency>
      <groupId>org.hibernate</groupId>
      <artifactId>hibernate-validator</artifactId>
      <version>5.4.1.Final</version>
    </dependency>

    <!-- 返回json字符串的支持 -->
    <!-- https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind -->
    <dependency>
      <groupId>com.fasterxml.jackson.core</groupId>
      <artifactId>jackson-databind</artifactId>
      <version>2.8.8</version>
    </dependency>


    <!-- MyBatisGenerator -->
    <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-core -->
    <dependency>
      <groupId>org.mybatis.generator</groupId>
      <artifactId>mybatis-generator-core</artifactId>
      <version>1.3.5</version>
    </dependency>

    <!--引入pageHelper分页插件 -->
    <dependency>
      <groupId>com.github.pagehelper</groupId>
      <artifactId>pagehelper</artifactId>
      <version>5.0.0</version>
    </dependency>


    <!--SpringMVC\ Spring-->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-webmvc</artifactId>
      <version>4.3.7.RELEASE</version>
    </dependency>

    <!--Spring-JDBC-->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-jdbc</artifactId>
      <version>4.3.7.RELEASE</version>
    </dependency>

    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-test</artifactId>
      <version>4.3.7.RELEASE</version>
    </dependency>

    <!-- Spring面向切面编程 -->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-aspects -->
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-aspects</artifactId>
      <version>4.3.7.RELEASE</version>
    </dependency>

    <!--MyBatis -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis</artifactId>
      <version>3.4.2</version>
    </dependency>

    <!-- MyBatis整合Spring的适配包 -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
      <groupId>org.mybatis</groupId>
      <artifactId>mybatis-spring</artifactId>
      <version>1.3.1</version>
    </dependency>

    <!-- 数据库连接池、驱动 -->
    <!-- https://mvnrepository.com/artifact/c3p0/c3p0 -->
    <dependency>
      <groupId>c3p0</groupId>
      <artifactId>c3p0</artifactId>
      <version>0.9.1</version>
    </dependency>

    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>5.1.41</version>
    </dependency>

    <!-- （jstl，servlet-api，junit） -->
    <!-- https://mvnrepository.com/artifact/jstl/jstl -->
    <dependency>
      <groupId>jstl</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>3.0.1</version>
      <scope>provided</scope>
    </dependency>

    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.12</version>
    </dependency>
  </dependencies>

  <properties>
    <maven.compiler.source>1.8</maven.compiler.source>
    <maven.compiler.target>1.8</maven.compiler.target>
  </properties>
</project>

```

### 2.2 web.xml 文件配置
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
      <!--在 CharacterEncodingFilter 雷里卖你有默认的参数名设置-->
      <!--强制请求编码-->
      <param-name>forceRequestEncoding</param-name>
      <param-value>true</param-value>
    </init-param>
    <init-param>
      <!--强制响应编码-->
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

### 2.4 dispatcher-servlet.xml  (即SpringNVC.xml)
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


### 2.5 applicationContext.xml   (Spring容器)
```
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context.xsd
       http://www.springframework.org/schema/tx
       http://www.springframework.org/schema/tx/spring-tx.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <context:component-scan base-package="com.legend">
        <context:exclude-filter type="annotation"
                                expression="org.springframework.stereotype.Controller" />
    </context:component-scan>

    <!-- Spring配置文件的核心点（数据源、与mybatis的整合，事务控制） -->

    <!-- Spring的配置文件，这里主要配置和业务逻辑有关的 -->
    <!--=================== 数据源，事务控制，xxx ================-->
    <context:property-placeholder location="classpath:db.properties" />
    <bean id="pooledDataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource">
        <property name="jdbcUrl" value="${jdbc.jdbcUrl}" />
        <property name="driverClass" value="${jdbc.driverClass}" />
        <property name="user" value="${jdbc.user}" />
        <property name="password" value="${jdbc.password}" />
    </bean>

    <!--================== 配置和MyBatis的整合=============== -->
    <bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <!-- 指定mybatis全局配置文件的位置 -->
        <property name="configLocation" value="classpath:mybatis-config.xml" />
        <property name="dataSource" ref="pooledDataSource" />
        <!-- 指定mybatis，mapper文件的位置 -->
        <property name="mapperLocations" value="classpath:mapper/*.xml" />
    </bean>

    <!-- 配置扫描器，将mybatis接口的实现加入到ioc容器中 -->
    <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
        <!--扫描所有dao接口的实现，加入到ioc容器中 -->
        <property name="basePackage" value="com.legend.dao"/>
    </bean>


    <!-- 配置一个可以执行批量的sqlSession -->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"></constructor-arg>
        <constructor-arg name="executorType" value="BATCH"></constructor-arg>
    </bean>



    <!-- ===============事务控制的配置 ================-->
    <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <!--控制数据源  -->
        <property name="dataSource" ref="pooledDataSource"></property>
    </bean>

    <!--开启基于注解的事务，使用xml配置形式的事务（必要主要的都是使用配置式）  -->
    <aop:config>
        <!-- 切入点表达式 -->
        <!--
            第一个 * 是代表访问控制符
            第二部分是  当前包下的所有类的所有方法
                ..表示如果service包下面还有包也会扫描
                括号里面的 .. 表示参数任意多
        -->
        <aop:pointcut expression="execution(* com.legend.service..*(..))" id="txPoint"/>
        <!-- 配置事务增强 -->
        <aop:advisor advice-ref="txAdvice" pointcut-ref="txPoint"/>
    </aop:config>

    <!--配置事务增强，事务如何切入  -->
    <tx:advice id="txAdvice" transaction-manager="transactionManager">
        <tx:attributes>
            <!-- 所有方法都是事务方法 -->
            <tx:method name="*"/>
            <!--以get开始的所有方法  -->
            <tx:method name="get*" read-only="true"/>
        </tx:attributes>
    </tx:advice>
</beans>
```

### 2.6 使用MaBatis逆向工程生成Bean类
#### 2.6.1引入JAR包
```
<dependency>
      <groupId>org.mybatis.generator</groupId>
      <artifactId>mybatis-generator-core</artifactId>
      <version>1.3.5</version>
</dependency>
```


#### 2.6.2  mgb.xml配置文件
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
	<!--设置注释不生成-->
	<context id="DB2Tables" targetRuntime="MyBatis3">
		<commentGenerator>
			<property name="suppressAllComments" value="true" />
		</commentGenerator>
		<!-- 配置数据库连接 -->
		<jdbcConnection driverClass="com.mysql.jdbc.Driver"
			connectionURL="jdbc:mysql://localhost:3306/ssm_crud" userId="root"
			password="123456">
		</jdbcConnection>

		<javaTypeResolver>
			<property name="forceBigDecimals" value="false" />
		</javaTypeResolver>

		<!-- 指定javaBean生成的位置 -->
		<javaModelGenerator targetPackage="com.legend.bean"
			targetProject=".\src\main\java">
			<property name="enableSubPackages" value="true" />
			<property name="trimStrings" value="true" />
		</javaModelGenerator>

		<!--指定sql映射文件生成的位置 -->
		<sqlMapGenerator targetPackage="mapper" targetProject=".\src\main\resources">
			<property name="enableSubPackages" value="true" />
		</sqlMapGenerator>

		<!-- 指定dao接口生成的位置，mapper接口 -->
		<javaClientGenerator type="XMLMAPPER"
			targetPackage="com.legend.dao" targetProject=".\src\main\java">
			<property name="enableSubPackages" value="true" />
		</javaClientGenerator>


		<!-- table指定每个表的生成策略 -->
		<table tableName="tbl_emp" domainObjectName="Employee"></table>
		<table tableName="tbl_dept" domainObjectName="Department"></table>
	</context>
</generatorConfiguration>
```

#### 2.6.3 运行main函数生成
```
package com.legend.test;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;
/**
 * @author Create By legend
 * @date 2019/3/27 21:07
 */
public class MBGTest {

    public static void main(String[] args) throws Exception {
        List<String> warnings = new ArrayList<String>();
        boolean overwrite = true;
        File configFile = new File("mbg.xml");
        ConfigurationParser cp = new ConfigurationParser(warnings);
        Configuration config = cp.parseConfiguration(configFile);
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
                callback, warnings);
        myBatisGenerator.generate(null);
    }
}

```

#### 2.6.4 逆向工程生成目录结构及文件
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330123948838-958652004.png)


### 2.7 mybatis-config.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<settings>
		<!--驼峰命名-->
		<setting name="mapUnderscoreToCamelCase" value="true"/>
	</settings>

	<!--起别名-->
	<typeAliases>
		<package name="com.legend.bean"/>
	</typeAliases>
	
	<plugins>
		<plugin interceptor="com.github.pagehelper.PageInterceptor">
			<!--分页参数合理化  防止页面点击上一页下一页出现负数的情况-->
			<property name="reasonable" value="true"/>
		</plugin>
	</plugins>
</configuration>
```

### 2.6 db.properties
```
jdbc.jdbcUrl=jdbc:mysql://localhost:3306/ssm_crud
jdbc.driverClass=com.mysql.jdbc.Driver
jdbc.user=root
jdbc.password=123456
```


## 3. 测试Mapper接口文件,为DB 插入数据
### 3.1 MapperTest.java 
```
package com.legend.test;

import com.legend.bean.Department;
import com.legend.bean.Employee;
import com.legend.dao.DepartmentMapper;
import com.legend.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 *推荐Spring的项目就可以使用Spring的单元测试，可以自动注入我们需要的组件
 *1、导入SpringTest模块
 *2、@ContextConfiguration指定Spring配置文件的位置
 *3、直接autowired要使用的组件即可
 * @author Create By legend
 * @date 2019/3/27 22:30
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:dispatcherServlet-servlet.xml"})
public class MapperTest {

    /**
     * 测试接口
     *
     */
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;


    /**
     * 批量sqlSession
     */
    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
        //1、创建SpringIOC容器
        //ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
        //2、从容器中获取mapper
        //DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
        System.out.println(departmentMapper);

        //1、插入几个部门(有选择的插入)
		//departmentMapper.insertSelective(new Department(null, "开发部"));
    	//departmentMapper.insertSelective(new Department(null, "测试部"));

        //2、生成员工数据，测试员工插入
        //employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
        //3、批量插入多个员工；批量，使用可以执行批量操作的sqlSession。

//		for(){
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0;i<100;i++){
            //自动生成然后截取
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1));
        }
        System.out.println("批量完成");


    }
}

```

>注意点:要想批量插入数据,要配置批量执行的  SqlSession的配置  (applicationContext.xml)
```
<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <!-- 指定mybatis全局配置文件的位置 -->
        <property name="configLocation" value="classpath:mybatis-config.xml" />
        <property name="dataSource" ref="pooledDataSource" />
        <!-- 指定mybatis，mapper文件的位置 -->
        <property name="mapperLocations" value="classpath:mapper/*.xml" />
    </bean>


 <!-- 配置一个可以执行批量的sqlSession -->
    <bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
        <constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory"></constructor-arg>
        <constructor-arg name="executorType" value="BATCH"></constructor-arg>
    </bean>

<!--要引用sqlSessionFactory 就一起放上来了-->
```

### 3.2 数据库信息
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330130106081-304116650.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330130220834-1601001527.png)



### 3.3 利用分页插件完成分页显示
<a href="https://github.com/pagehelper/Mybatis-PageHelper/blob/master/wikis/zh/HowToUse.md">参考分页插件官方使用文档</a>


#### 3.3.1 项目使用步骤
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330131559859-144174586.png)


#### 3.3.3使用Spring单元测试测试分页请求
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330155108135-1710119301.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330163443977-1325935695.png)


#### 3.3.2 页面展示分页数据
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330163849212-933978965.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330164041634-229604643.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330164340169-2062514627.png)

>首页就是pn=1 ;  最后一页就是总页数pages属性;  上一页就是当前页-1,pageNum-1;下一页就是当前页+1,pageNum+1.
>首页末页处理
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330164556078-926355660.png)




## 4 .查询返回分页的JSON数据

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330164752046-1911772031.png)

### 4.1 解析json数据填充表格
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330165246310-1407677556.png)


```
$.each(遍历对象,function(index,item){})
第一个参数是索引,第二个是代表当前的对象

//js的三元运算符表达式
var genderTd  = $("<td></td>").append(item.gender =='M'? "男":"女");



//给组件添加样式 用 addClass() ,组件里面添加组件用 append()
var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");


//给组件添加自定义属性
delBtn.attr("del_id",item.empId);

//将节点添加到父节点
navEle.appendTo("#page_nav_area");


//查找 empName_add_input 的父元素 添加class  属性
$("#empName_add_input").parent().addClass("has-success");

//empName_add_input的下一个元素的文本值
$("#empName_add_input").next("span").text("");   

//表单重置
$("#empAddModal form")[0].reset();//取出DOM对象
             
```

### 4.2 遍历json数据
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330170700054-479180012.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330165920838-944265063.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330170628722-1166999863.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330170800968-95045561.png)
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330170832684-836375335.png)
>是否能点击用的属性是  class="active"/disabled


### 4.3 解决页面出现负数的情况
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330171034501-2096757000.png)


### 4.3 数据填充
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330170101650-1580649943.png)



## 5 .员工新增实现
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190328190338408-1606632417.png)

### 5.1 模态框(原生没有修改的)
```
<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
```

### 5.2 弹出模态框
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330171521619-1156686035.png)

>backdrop:"static"//背景删除


### 5.3 获取模态框中的数据
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330175115336-1970967348.png)

```
$("#empAddModal form").serialize()

//请求成功以后
$("#empAddModal").modal('hide');//隐藏模态框


//序列化后的数据格式:
	empName=123&email=2222&gender=M&dId=1

//添加内容到p标签之间的内容   或者是 .text(data)
$("#empName_update_static").append(result.extend.emp.empName);

//填充到input标签里面的内容
$("#email_update_input").val(result.extend.emp.email);

//填充单选框按钮的值
$("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);

//填充下拉列表数据
$("#empUpdateModal select").val([result.extend.emp.department.deptId]);

//移除当前节点的父节点的class属性
$(ele).parent().removeClass("has-success has-error");

//清空上一次请求的内容
$("#empName_update_static").empty();
```


### 5.4 数据校验

#### 5.4.1 数据表格校验
```
//校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //做成方法
            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");*/

            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
           /* $("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next("span").text("");*/

            show_validate_msg("#empName_add_input", "success", "");
        }

        //2.验证邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式

            //代码抽取出来做成方法
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
           /* $("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;

    }
```

#### 5.4.2 用户名校验
```
 //校验用户名是否重复可用
    $("#empName_add_input").change(function () {
        //var empName = this.val();

        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"${pageContext.request.contextPath}/checkUser",
            type:"GET",
            data:"empName="+$("#empName_add_input").val(),
            success:function (result) {
                if (result.code ==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");

                    //当用户名可用才能点击保存
                    $("#emp_save").attr("ajax-validate","success")
                    $("#emp_save").attr('disabled', false);
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.validate_msg);
                    $("#emp_save").attr("ajax-validate","error");
                    $("#emp_save").attr('disabled', true);
                }
            }
        })
        
    })
```
> var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;   //
> 正则表达式代表的是   大小写的a- z   6-16位  或者是  中文2-5位开头



#### 5.4.3  邮箱验证
```
 //邮箱验证
    $("#email_add_input").change(function () {
        var email = $("#email_add_input").val();
        alert(email)
        $.ajax({
            url:"${pageContext.request.contextPath}/checkEmail",
            type:"GET",
            data:"email="+email,
            success:function (result) {
                console.log(result)
                //alert(result)
                if (result.code ==100){
                    show_validate_msg("#email_add_input","success",result.extend.v_email);

                    $("#emp_save").attr('disabled', false);
                }else if (result.code ==200) {
                    show_validate_msg("#email_add_input","error",result.extend.v_email);

                    //改变按钮的是否可用状态
                    $("#emp_save").attr('disabled', true);
                }
            }
        })

    })
```
>  var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
>  邮箱正则表达式


#### 5.4.4 通用的校验结果显示信息
```
 //显示校验结果的提示信息    ele代表的是正在校验的元素
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态   不然正确之后还是红色提示框
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        //判断状态
        if (status =="success"){
            //成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status == "error") {
            //错误
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
```

#### 5.4.5 基于数据库的用户名校验
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330181633877-819099794.png)


## 6.  @RequestParam 和@PathVariable的使用
### 6.1  @RequestParam使用  (在传过来的data是我们需要的值)
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330182138816-862359459.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330181939416-2105144620.png)

### 6.2 @PathValiable 使用(在URL路径中获取我们需要的值)
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330182455559-645352583.png)

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330182555722-467264101.png)





## 6.MyBatis框架流程介绍

![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190329124708243-824347932.png)



![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330112647828-1919968568.png)

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

## JSON字符串解析(还能使用fastjson)
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

## web.xml 文件配置
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





## 关闭tomcat服务器的时候报错:大致内容是项目内存溢出
````
在Tomcat的VM Option空白处添加下面的参数设置即可
    -Xms258m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m
````

## 知识点回顾
![](https://img2018.cnblogs.com/blog/1231979/201903/1231979-20190330112647828-1919968568.png)
       