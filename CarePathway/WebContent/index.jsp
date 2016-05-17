<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="lib/angular.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>Test Screen Using Angular for CarePathway System</td>
		</tr>
	</table>
	<div ng-app="">
		<p>
			Enter your name: <input type="text" ng-model="textName">
		</p>
		<p>Hello: {{textName}}</p>
	</div>
</body>
</html>