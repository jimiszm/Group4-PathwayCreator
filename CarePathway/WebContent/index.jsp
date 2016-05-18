<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
/* #contextmenu-node {
	position: absolute;
	background-color: white;
	border: solid #CCCCCC 1px;
}

.contextmenu-item {
	margin: 0.5em;
	padding-left: 0.5em;
}

.contextmenu-item:hover {
	background-color: #CCCCCC;
	cursor: default;
} */
.button {
	padding: .5em;
	border: 1px solid #ccc;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CarePathway Creator</title>
<script type="text/javascript" src="lib/angular.min.js"></script>
</head>
<body>
	<table>
		<tr>
			<td>CarePathway Creator</td>
		</tr>
	</table>
	<div ng-app="myApp" ng-controller="myCtrl">
		<!-- <tr>
			<td>
				<p>
					Test: <input type="text" ng-model="textName">
				</p>
				<p>Hello:{{textName}}</p>
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
							<td valign="middle">
								<input type="text" name="searchArea" size="40"></input>
								<button onclick="alert('NLP API');">
									<img width="15" height="15" src="search.jpg" border="0" />
								</button>
								<!-- <span ng-right-click="decrement()">{{value}}</span> -->
								<!-- <span context-menu="myContext">Add Q</span></td> -->
						<tr>
							<td>
								<addbuttonsbutton></addbuttonsbutton>
								<div id="add-question"></div>
								<div id="add-options"></div>
							</td>
						</tr>
						<tr align="right">
							<td >
								 <span ng-mouseover="mouseover()" ng-mouseleave="mouseleave()" 
								 	ng-style="myStyle" ng-class="'button'">Reset</span>
								 <span ng-mouseover="mouseover2()" ng-mouseleave="mouseleave2()" 
								 	ng-style="myStyle2" ng-class="'button'">Submit</span>
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
	<script type="text/javascript">
	/***************************************** Yuzhu Add Start *******************************/
		var app = angular.module('myApp', []);
		app.controller('myCtrl', [ '$scope', function($scope) {
			/*Mouse Moveover start*/
			$scope.mouseover = function() {
				$scope.myStyle = {
					fontWeight : 'bold'
				};
			}
			$scope.mouseleave = function() {
				$scope.myStyle = {
					fontWeight : 'normal'
				}
			}
			$scope.mouseover2 = function() {
				$scope.myStyle2 = {
					fontWeight : 'bold'
				};
			}
			$scope.mouseleave2 = function() {
				$scope.myStyle2 = {
					fontWeight : 'normal'
				}
			}
			/*Mouse Moveover end*/
			
			/*Options start*/
		   	$scope.items = [{ id: 1, name: 'Add Radio Button' },
		  			     	{ id: 2, name: 'Add Input Area' },];
			/*Options end*/
		} ]);

		/*Dynamically add questions start*/
		function myCtrl($scope) {
			$scope.count = 0;
		}
		app.directive("addbuttonsbutton", function() {
			return {
				restrict : "E",
				template : "<button addbuttons>Click to add questions</button>"
			}
		});
		app.directive("addbuttons",function($compile) {
			return function(scope, element, attrs) {
				element.bind("click", function() {
					scope.count++;
					angular.element(document.getElementById('add-question')).append($compile(
						"<div><tr colspan='3'><td>Question:</td><td>&nbsp;&nbsp;</td><td><select ng-model='selectedItem' ng-options='item as item.name for item in items'></select></td><td><button add>ADD</button></td><td><input type='text' size='50'></td></tr></div>")
																			(scope));
				});
			};
		});
		app.directive("add", function($compile) {
			return function(scope, element, attrs) {
				element.bind("click", function() {
					if (scope.selectedItem.id == '1') {
						angular.element(document.getElementById('add-options')).append($compile(
						"<div><p><input type='radio' name='q1' value='1'><input type='text' size='5'></p></div>")(scope));
					} else {
						angular.element(document.getElementById('add-options')).append($compile(
						"<div><p><input type='text' size='25'><input type='checkbox' value=''></p></div>")(scope));
					}
				});
			};
		});
		/*Dynamically add questions end*/

		/*-----------------------------backup souce-------------------------------------------*/
		/* app.controller('myCtrl', function($scope) {
			$scope.textName = "John";
		    $scope.value = 10;
		}); */

		/* Right click start*/
		/* app.controller('myCtrl', function($scope) {
		    $scope.value = 10;
		    $scope.decrement = function() {
		      $scope.value = $scope.value - 1; 
		    };
		});
		
		app.directive('ngRightClick', function($parse) {
		    return function(scope, element, attrs) {
		        var fn = $parse(attrs.ngRightClick);
		        element.bind('contextmenu', function(event) {
		            scope.$apply(function() {
		                event.preventDefault();
		                fn(scope, {$event:event});
		            });
		        });
		    };
		}); */
		/* Right click end*/
		/*Mouse menu start*/
		/* app.controller( 'myCtrl', [ '$scope', function($scope) {
			$scope.myContext = "<ul id='contextmenu-node'><li class='contextmenu-item' ng-click='clickedItem1()'> Add Q with Radio button </li><li class='contextmenu-item' ng-click='clickedItem2()'> Add Q with input</li></ul>";
			$scope.clickedItem1 = function() {
				console.log("Clicked item 1.");
				alert('1');
			};
			$scope.clickedItem2 = function() {
				console.log("Clicked item 2.");
				alert('2');
			};
		} ]);

		app.directive("contextMenu", function($compile) {
			contextMenu = {};
			contextMenu.restrict = "AE";
			contextMenu.link = function(lScope, lElem, lAttr) {
				lElem.on("contextmenu", function(e) {
					e.preventDefault();
					lElem.append($compile(lScope[lAttr.contextMenu])(lScope));
					$("#contextmenu-node").css("left", e.clientX);
					$("#contextmenu-node").css("top", e.clientY);
				});
				lElem.on("mouseleave", function(e) {
					if ($("#contextmenu-node"))
						$("#contextmenu-node").remove();
				});
			};
			return contextMenu;
		}); */
		/*Mouse menu end*/
	/***************************************** Yuzhu Add End *******************************/
	</script>
</body>
</html>