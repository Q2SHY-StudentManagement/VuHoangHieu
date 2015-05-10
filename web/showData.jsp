<%-- 
    Document   : interface
    Created on : May 9, 2015, 11:20:54 PM
    Author     : Vu Hoang Hieu
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>           
            #header2 {
                background-image:url("3_1.jpg");
                color:black;
                text-align:left;
                padding:50px;
            }
            #header3 {
                background-color:#BC3C2E;
                color: #F5FFFA;
                text-align:left;
                padding:7px;
            }
            #nav {
                line-height:30px;
                background-color:#F9F9F9;
                height:1000px;
                width:200px;
                float:left;
                padding:5px;	      
            }
            #nav2 {
                line-height:30px;
                background-color:#F9F9F9;
                height:1000px;
                width:200px;
                float:right;
                text-align:left;
                padding:5px;	 
            }
            #nav3 {
                line-height:30px;
                background-color:#F9F9F9;
                height:1000px;
                width:900px;
                float:left;
                padding:5px;	 
            }
        </style>
        </style>
    <body>
        <body style="background-color:#F9F9F9">
        <jsp:useBean class="com.sample.StudentBean" id="bb" scope="session"/> 

        <div id="header2" >  

            <a href="Home.jsp"><img  width="414" height="143" src="logo.jpg"> </a>


        </div>
        <div id="header3">
            <%
              String s = (String)session.getAttribute("userid");
              session.setAttribute("userid", s);
          %>
            <table  id="01" style="width: 100%">
                
                <tr>
                    <td style="text-align:left" style="color: #8B4726"><li class="menusep"><a  href='Home.jsp'><b style="color: #ffffff">Home</b></a></li></td> 
                    <td style="text-align:left" ><li class="menusep">&nbsp;<a href='showData.jsp'><b  style="color: #ffffff">List Student</b></li></a></td>
                    <td style="text-align:left" ><li class="menusep">&nbsp;<a href='AddStudent.jsp'><b  style="color: #ffffff">Add New Student</li></a></td>
                    <td style="text-align:left" ><li class="menusep">&nbsp;<a href='about.jsp'><b  style="color: #ffffff">About</li></a></td>
                    <td style="text-align:left" ><li class="menusep">&nbsp;<a href='Logout.jsp'><b  style="color: #ffffff">Logout&nbsp&nbsp(<%=s%>)</li></a></td>

                </tr>       

            </table>   

        </div>
        <div id="nav">
            <strong><h2>TOP CÁC TRƯỜNG ĐẠI HỌC DANH TIẾNG TRÊN THẾ GIỚI </h2></strong>
            <p></p>
            <p><b>1 . Đại học Harvard </b>
            <p><img src="4_Harvard_University.jpg" width="200px" height="200px" border="1" >
            <p><b>2 . Đại học Cambridge</b>
            <p><img src="5_Cambridge.jpg" width="200px" height="200px" border="1" >
            <p><b>3 . Đại học YALE</b>
            <p><img src="6_YALE.jpg" width="200px" height="200px" border="1" >

        </div>
        <div id="nav2">
            <strong><h2>GIỚI THIỆU VỀ TRƯỜNG ĐẠI HỌC FPT</h2></strong>
            <iframe width="200" height="200" src="https://www.youtube.com/embed/f2NlRi8_3s0" frameborder="1" allowfullscreen></iframe>
            <iframe width="200" height="200" src="https://www.youtube.com/embed/X5YwIfrT9Tc" frameborder="1" allowfullscreen></iframe>
            <iframe width="200" height="200" src="https://www.youtube.com/embed/bfhcBXtY9NU" frameborder="1" allowfullscreen></iframe>
            <iframe width="200" height="200" src="https://www.youtube.com/embed/Hzj0345wo4E" frameborder="1" allowfullscreen></iframe>



        </div>
        <div id="content">
            <br><br>
                    <form>

                    <%
                        //get parameter
                        String search=request.getParameter("btSearch");
                        String txtSearch=request.getParameter("txtSearch");
                        if(txtSearch==null) txtSearch="";
                        else txtSearch=txtSearch.trim();
                    %>
                    <h3>Enter key to search student:</h3>
                    <input type="text" value="<%=txtSearch%>" name="txtSearch"/>
                    <input type="submit" value="Search" name="btSearch"/>
                    <br><br><br>
                    <%
                        //connect database
                        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
                        Connection con=DriverManager.getConnection("jdbc:odbc:StudentManagement");
                        // search button clicked
                        if(search!=null){
                            String sql=null;
                            if(txtSearch.equalsIgnoreCase("male"))
                                sql="select * from Student where Gender='male'";
                            else if(txtSearch.equalsIgnoreCase("female"))
                                sql="select * from Student where Gender='female'";
                            else{
                                try{
                                    int txtID=Integer.parseInt(txtSearch);
                                    sql="select * from Student where Student_ID="+txtSearch+" or year(dob)="+txtSearch+" or month(dob)="+txtSearch+" or day(dob)="+txtSearch;
                                }catch(Exception e){
                                    sql="select * from Student where Name like '%"+txtSearch+"%' or HomeTown like '%"+txtSearch+"%'";
                                }
                            }
                            ResultSet rs=con.createStatement().executeQuery(sql);
                            if(rs.next()){
                    %>
                    <table border="1">
                        <tr><th>Student ID</th> <th>Student name</th> <th>Date of birth</th> <th>Gender</th> <th>Hometown</th> <th>Phone number</th> <th>Action</th></tr>
                    <%
                        do{
                            int id=rs.getInt(1);
                            String name=rs.getString(2);
                            String dob=rs.getString(3);
                            String gender=rs.getString(4);
                            String hometown=rs.getString(5);
                            String phone=rs.getString(6);
                    %>
                        <tr><th><%=id%></th> <th><%=name%></th> <th><%=dob%></th> <th><%=gender%></th> <th><%=hometown%></th> <th><%=phone%></th> <th><a href="EditStudent.jsp?id=<%=id%>">Edit</a> / <a href="deleteStudent.jsp?id=<%=id%>">Delete</a></th></tr>
                    <%        
                        }while(rs.next());
                    %>
                    </table>
                    <%
                        }else{
                    %>
                    <h2>No student found.</h2>
                    <%
                        }
                        }else{
                            String sql="select * from Student";
                            ResultSet rs=con.createStatement().executeQuery(sql);
                            if(rs.next()){
                    %>
                    <table border="1">
                        <tr><th>Student ID</th> <th>Student name</th> <th>Date of birth</th> <th>Gender</th> <th>Hometown</th> <th>Phone number</th> <th>Action</th></tr>
                    <%
                        do{
                            int id=rs.getInt(1);
                            String name=rs.getString(2);
                            String dob=rs.getString(3);
                            String gender=rs.getString(4);
                            String hometown=rs.getString(5);
                            String phone=rs.getString(6);
                    %>
                        <tr><th><%=id%></th> <th><%=name%></th> <th><%=dob%></th> <th><%=gender%></th> <th><%=hometown%></th> <th><%=phone%></th> <th><a href="EditStudent.jsp?id=<%=id%>">Edit</a> / <a href="deleteStudent.jsp?id=<%=id%>">Delete</a></th></tr>
                    <%        
                        }while(rs.next());
                    %>
                    </table>
                    <%
                        }else{
                    %>
                    <h2>No student found.</h2>
                    <%
                        }
                        }
                    %>
                    </form>
                    <br><br>
                </div>
    </body>
</html>
