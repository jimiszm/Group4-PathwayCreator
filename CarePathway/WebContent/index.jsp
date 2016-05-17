<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CarePathway Creator</title>
<script src="lib/angular.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>CarePathway Creator</td>
		</tr>
	</table>
	<div ng-app="">
		<!-- <tr>
			<td>
				<p>
					Enter your name: <input type="text" ng-model="textName">
				</p>
				<p>Hello: {{textName}}</p>
			</td>
		</tr> -->
		<table border="2" width="900" height="400">
			<tr>
				<!-- ------------------------------left part Start------------------------------ -->
				<td>
					<table border="0" width="450" height="400">
						<tr>
							<td><lable>Conditoins:</lable></td>
						</tr>
						<tr colspan="2">
							<td valign="middle"><input type="text" name="searchArea"
								size="50"></input> <img width="17" hight="17" src="search.jpg" />
							</td>
						</tr>
						<tr>
							<td>
								<table border="0" width="450" height="200">
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table border="1" width="450" height="145">
								</table>
							</td>
						</tr>
					</table>
				</td>
				<!-- ------------------------------left part end------------------------------ -->
				<!-- ------------------------------left part start---------------------------- -->
				<td>
					<table border="1" width="450" height="400">
					</table>
				</td>
				<!-- ------------------------------right part end------------------------------ -->
			</tr>
		</table>
	</div>
</body>
</html>