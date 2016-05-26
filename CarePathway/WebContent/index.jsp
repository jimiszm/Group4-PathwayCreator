<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">

.errorSpanClass {
  color: red;
}
.button {
	background: -moz-linear-gradient(top,#0099CC 0%,#006699);
    background: -webkit-gradient(linear, left top, left bottom, from(#66CCCC), to(#00CCCC));
    border: 1px solid #000;
    color: #000;
    padding: 3px 6px;
}

fieldset {
  background: #FCFCFC;
  padding: 16px;
  border: 1px solid #D5D5D5;
}

.remove {
  background: #C76868;
  color: #FFF;
  font-weight: bold;
  font-size: 21px;
  border: 0;
  cursor: pointer;
  display: inline-block;
  padding: 2px 6px;
  vertical-align: middle;
  line-height: 100%;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>CarePathway Creator</title>
<script type="text/javascript" src="lib/angular.min.js"></script>
</head>
<body bgcolor="#EEEEEE" >
	<table border="0" align="center" >
		<tr align="center">
			<td><span style="font-size:x-large; color:black">CarePathway Creator</span></td>
		</tr>
	</table>
	<div ng-app="myApp" ng-controller="myCtrl" style="overflow-x:auto; overflow-y:auto;">
		<table border="0" width="100%" height="100%" style="table-layout:auto;" align="center">
			<tr>
				<!-- ------------------------------ left part Start ------------------------------ -->
				<td>
					<table border="0" width="100%" height="100%" bgcolor="white" style="table-layout: auto;">
						<tr height="20">
							<td colspan="3">CONDITIONS:</td>
						</tr>
						<tr height="20">
							<td colspan="3" valign="middle">
								<input type="text" name="searchArea" size="50"></input>
								<button onclick="alert('This area will show the information return from NPL System.');">
									<img width="15" height="15" src="search.jpg" border="0" />
								</button>
								<button class="button" ng-click="addNewQuestion()">Add questions</button>
							</td>
						</tr>
						<tr height="400" align="left" valign="top">
							<td colspan="3">
								<fieldset data-ng-repeat="question in questions">
									<span >Question{{$index + 1}}:</span>
									<button class="remove" ng-click="removeQuestion($index)">-</button>
    								<input type="text" ng-model="question.name" placeholder="Enter question">
    								<select ng-model="choice" ng-options='item as item.name for item in items'></select>
    								<button class="button" ng-click="addNewAnswer(question,$index)">Add answers</button>

    								<div ng-if="choice.id == 1" data-ng-repeat="answer in question.answers">
    									<input type="radio" name="$parent.radioItem" ng-model="$parent.radioItem" value="{{answer.name}}" ng-click='clickOn(question, answer, null)'>
      									<input type="text" ng-model="answer.name" placeholder="Enter answer">
      									<button class="remove" ng-click="removeAnswer(question,$index)">-</button>
    								</div>
    								<div ng-if="choice.id == 2" data-ng-repeat="answer in question.answers">
      									<input type='checkbox' name='question.name' ng-model="checkbox.selected" value="" ng-click="clickOn(question, answer, checkbox.selected)">
      									<input type="text" ng-model="answer.name" placeholder="Enter answer">{{answer.id}}{{}}
      									<button class="remove" ng-click="removeAnswer(question,$index)">-</button>
    								</div>
  								</fieldset>
							</td>
						</tr>
						<!-- <tr align="right" height="20">
							<td colspan="3">
    							<button class="button" type="submit" value="submit" ng-click="submit()">Submit</button>
							</td>
						</tr> -->
						<tr>
							<td>
								<hr>
							</td>
						</tr>
						<tr height="">
							<td>
								<table border="0" width="100%" height="200" style="table-layout:auto;">
									<tr height="20">
										<td colspan="3">EXIT CONDITIONS:</td>
									</tr>
									<tr height="20" align="left">
										<td>* NEXT STEP NAME</td>
										<td colspan="2"><input type="text" name="nextStep" ng-model="nextStep" size="45"></input></td>
									</tr>
									<tr height="" align="left" valign="top">
										<td colspan="3">
										<!-- <fieldset data-ng-repeat="question in questions">
											<span>Question{{$index + 1}}:</span>
											<span>{{question.name}}</span>
											<div data-ng-repeat="answer in question.answers">
												<span ng-show='clickOnItem == answer.id || clickOnItem == true' >Answer: {{answer.name}}</span>
											</div>
		  								</fieldset> -->
											<span>{{radioedItems}}{{checkedItems}}</span>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr align="right" valign="middle" height="20">
							<td>
    							<button class="button" type="reset" value="reset" ng-click="reset()">Reset</button>
							</td>
						</tr>
						<tr>
							<td>
								<hr>
							</td>
						</tr>
						<tr align="left" valign="top" height="100">
							<td>
    							<span>PML ERRORS AREA:</span>
    							<br>
    							<span class="errorSpanClass">{{error}}</span>
							</td>
						</tr>
						<tr align="right" valign="middle" height="20">
							<td>
    							<button class="button" type="submit" value="submit" ng-click="submit2()">Save</button>
							</td>
						</tr>
					</table>
				</td>
				<!-- ------------------------------ left part end ------------------------------ -->
				<!-- ------------------------------ left part start ---------------------------- -->
				<td>
					<table border="0" width="550" height="1000" bgcolor="white" style="table-layout:auto;">
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
			
			/*Options start*/
		   	$scope.items = [{ id: 1, name: 'Add Radio Button' },
		  			     	{ id: 2, name: 'Add Input Area' },];
			/*Options end*/
			
			/*Reset start*/
			$scope.reset = function() {
				$scope.radioedItems = [];
				$scope.checkedItems = [];
			}
			/*Reset end*/
			
			/*Add questions and answers start*/
			$scope.questions = [{
			    id: 'question',
			    answers:[]
			}];

 			$scope.addNewQuestion = function() {
   				var newItemNo = $scope.questions.length + 1;
   				$scope.questions.push({
     				'id': 'question' + newItemNo,
     				answers:[]
   				});
 			};

			$scope.removeQuestion = function(ind) {
   				$scope.questions.splice(ind,1);
 			};

 			$scope.addNewAnswer = function(question, ind) {
   				var newItemNo = question.answers.length + 1;
   				question.answers.push({
     				'id': 'answer' + (ind+1).toString() + newItemNo.toString()
   				});
 			};

			$scope.removeAnswer = function(question,ind) {
   				question.answers.splice(ind,1);
 			};
			/*Add questions and answers end*/

			/*Submit start*/
			$scope.checkedItems = [];
			$scope.radioedItems = [];
			$scope.clickOn = function(question, answer, ckecked) {
				if (ckecked == true) {
					$scope.checkedItems.push('Question :' + question.name + ' ' + 'Answer :' + answer.name);
				} else if (ckecked == false) {
					var temp2 = 'Question :' + question.name + ' ' + 'Answer :' + answer.name;
					var ind = $scope.checkedItems.indexOf(temp2);
					$scope.checkedItems.splice(ind,1);
				} else {
					$scope.radioedItems.splice(0, $scope.radioedItems.length);
					$scope.radioedItems.push('Question :' + question.name + ' ' + 'Answer :' + answer.name);
				}
			}
			/*Submit end*/
			
			/*Save check start*/
 			$scope.submit2 = function() {
				if ($scope.nextStep == undefined || $scope.nextStep == '') {
					$scope.error = 'Please input the tittle of next step.';
				} else {
					$scope.error = 'No error.';
				}
				
				if ($scope.error == 'No error.') {
					alert(1);
					var data = $.param({
			            json: JSON.stringify({
			                name: $scope.answer
			            })
			        });
			        /* $http.post("/echo/json/", data).success(function(data, status) {
			        	alert(data);
			        }) */
			        alert(data);
				}
			}
 			/*Save check end*/
		} ]);
	/***************************************** Yuzhu Add End *******************************/
	</script>
</body>
</html>