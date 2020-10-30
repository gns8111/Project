<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<!DOCTYPE HTML>
<html>
<head>
	<title>NAV</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
			<div class ="limiter">
			<div class = "row">
			<nav class= "navbar navbar-default" >
				<div class = "navbar-header">
				<button class = "navbar-toggle"  data-toggle = "collapse" data-target="#mama">
						<span class ="sr-only"></span>
						<span class = "icon-bar"></span>
						<span class = "icon-bar"></span>
						<span class = "icon-bar"></span>
					</button>
						<a class ="navbar-brand"><strong>Groovy</strong></a>
						<form class = "navbar-form" style = "display: inline;">
							<div class ="form-group" style ="margin-top:9px;">
								<input type ="text" class ="form-control" placeholder="°Ë»ö">
							<button type ="submit" class="btn btn-default"
							>Search</button>
									
							</div>
							
						</form>
				</div>
				
				<div class = "collapse navbar-collapse" id="mama">
					<ul class = "nav navbar-nav" style ="float: right">
						<li><a href = "#">menu1</a></li>
						<li><a href = "#">menu2</a></li>
						<li><a href = "#">menu2</a></li>
						<li><a href = "#">menu2</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>
		<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
</body>

</html>