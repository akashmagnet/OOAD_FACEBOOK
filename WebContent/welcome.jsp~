<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%! String msg; %>
<!DOCTYPE html>
<html>
<%@include file="/headtag.jsp" %>
<body>
	<div class="panel panel-primary">
	 <div class="panel-heading"><h1 align="center"><em>STUDENT INFORMATION SYSTEM</em></h1></div>	
			 <br /> <br />
		<div class="panel-body">
		<div class="row">
			<div class="col-lg-4"></div>
 		 	<div class="col-lg-8">	
				 <form class="form-horizontal" method="post" action="login">
				  <div class="form-group">
				    <label for="uname" class="col-lg-2 control-label">Username</label>
				    <div class="col-lg-3">
				      <input type="text" class="form-control" id="uname" name="uname" placeholder="Enter Username" autofocus required>
				    </div>
				  </div>
				  <div class="form-group">
				    <label for="upwd" class="col-lg-2 control-label">Password</label>
				    <div class="col-lg-3">
				      <input type="password" class="form-control" id="upwd" name="upwd" placeholder="Enter Password" required>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="col-lg-offset-2 col-lg-3">
				      <button type="submit" class="btn btn-success">Sign in</button>
				    </div>
				  </div>
				</form>
			</div>
		</div>
	</div>
	</div>
	 <%	msg=response.getHeader("msg");	
	    	if(msg!=null){%>
	    	<h3 align="center"> <span class="label label-danger"><%= msg %></span></h3>
	  <%}%>
   <script src="js/bootstrap.js" type="text/javascript"></script>
</body>
</html>