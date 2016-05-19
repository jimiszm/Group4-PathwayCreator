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
	background: -moz-linear-gradient(top,#0099CC 0%,#006699);
    background: -webkit-gradient(linear, left top, left bottom, from(#66CCCC), to(#00CCCC));
    border: 1px solid #000;
    color: #000;
    padding: 3px 0;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CarePathway Creator</title>
<script type="text/javascript" src="lib/angular.min.js"></script>
</head>
<body bgcolor="#EEFFFF">
	<table>
		<tr>
			<td><span style="font-size:x-large">CarePathway Creator</span></td>
		</tr>
	</table>
	<div ng-app="myApp" ng-controller="myCtrl" style="overflow-x: auto; overflow-y: auto;">
		<table border="1" width="1100" height="500">
			<tr>
				<!-- ------------------------------ left part Start ------------------------------ -->
				<td>
					<table border="0" width="550" height="500" bgcolor="white">
						<tr height="20">
							<td colspan="3">CONDITIONS:</td>
						</tr>
						<tr height="20">
							<td colspan="3" valign="middle">
								<input type="text" name="searchArea" size="50"></input>
								<button onclick="alert('NLP API');">
									<img width="15" height="15" src="search.jpg" border="0" />
								</button>
								<!-- <span ng-right-click="decrement()">{{value}}</span> -->
								<!-- <span context-menu="myContext">Add Q</span> -->
								<addbuttonsbutton></addbuttonsbutton>
							</td>
						</tr>
						<tr height="200">
							<td colspan="3">
								<div id="add-question"></div>
								<div id="add-options"></div>
							</td>
						</tr>
						<tr align="right" height="20">
							<td colspan="3">
								 <span ng-mouseover="mouseover()" ng-mouseleave="mouseleave()" 
								 	ng-style="myStyle" ng-class="'button'" ng-click="reset()">Reset</span>
								 <span ng-mouseover="mouseover2()" ng-mouseleave="mouseleave2()" 
								 	ng-style="myStyle2" ng-class="'button'">Submit</span>
							</td>
						</tr>
						<tr>
							<td>
								<hr>
							</td>
						</tr>
						<tr height="160">
							<td>
								<table border="0" width="550" height="160">
									<tr height="20">
										<td colspan="3">EXIT CONDITIONS:</td>
									</tr>
									<tr height="140">
										<td colspan="3">
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr align="right" valign="middle" height="20">
							<td>
								 <span ng-mouseover="mouseover3()" ng-mouseleave="mouseleave3()" 
								 	ng-style="myStyle3" ng-class="'button'">Reset</span>
								 <span ng-mouseover="mouseover4()" ng-mouseleave="mouseleave4()" 
								 	ng-style="myStyle4" ng-class="'button'">Submit</span>
							</td>
						</tr>
					</table>
				</td>
				<!-- ------------------------------ left part end ------------------------------ -->
				<!-- ------------------------------ left part start ---------------------------- -->
				<td>
					<table border="1" width="550" height="500" bgcolor="white">
					</table>
				</td>
				<!-- ------------------------------ right part end ------------------------------ -->
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
			$scope.mouseover3 = function() {
				$scope.myStyle3 = {
					fontWeight : 'bold'
				};
			}
			$scope.mouseleave3 = function() {
				$scope.myStyle3 = {
					fontWeight : 'normal'
				}
			}
			$scope.mouseover4 = function() {
				$scope.myStyle4 = {
					fontWeight : 'bold'
				};
			}
			$scope.mouseleave4 = function() {
				$scope.myStyle4 = {
					fontWeight : 'normal'
				}
			}
			/*Mouse Moveover end*/
			
			/*Options start*/
		   	$scope.items = [{ id: 1, name: 'Add Radio Button' },
		  			     	{ id: 2, name: 'Add Input Area' },];
			/*Options end*/
			
			/*Dynamically add questions start*/
			$scope.count = 0;
			$scope.countRadioB = 0;
			$scope.countText = 0;
			/*Dynamically add questions end*/
			
			/*Reset start*/
			$scope.reset = function() {
				alert('Need to be improved.');
			}
			/*Reset end*/
		} ]);

		/*Dynamically add questions start*/
		app.directive("addbuttonsbutton", function() {
			return {
				restrict : "E",
				template : "<button addbuttons class ='button'>Click to add questions</button>"
			}
		});
		app.directive("addbuttons",function($compile) {
			return function(scope, element, attrs) {
				element.bind("click", function() {
					scope.count++;
					angular.element(document.getElementById('add-question')).append($compile(
						"<div><tr colspan='3'><td>Question"+scope.count+":</td><td>&nbsp;&nbsp;</td><td><select ng-model='selectedItem' ng-options='item as item.name for item in items'></select></td><td><button add class ='button'>ADD</button></td><td><input type='text' size='50'></td></tr></div>")(scope));
				});
			};
		});
		app.directive("add", function($compile) {
			return function(scope, element, attrs) {
				element.bind("click", function() {
					if (scope.selectedItem.id == '1') {
						angular.element(document.getElementById('add-options')).append($compile(
						"<div><input type='radio' name="+scope.countRadioB+" value='1'><input type='text' size='5'></div>")(scope));
					} else if (scope.selectedItem.id == '2') {
						angular.element(document.getElementById('add-options')).append($compile(
						"<div><input type='text' size='25'><input type='checkbox' value="+scope.countText+"></div>")(scope));
					}
				});
			};
		});
		/*Dynamically add questions end*/

		/*-----------------------------backup souce-------------------------------------------*/
		/* Mouse right click start*/
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
		/* Mouse right click end*/
		/*Mouse right click show menu start*/
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
		/*Mouse right click show menu end*/
	/***************************************** Yuzhu Add End *******************************/
	</script>
</body>
</html>