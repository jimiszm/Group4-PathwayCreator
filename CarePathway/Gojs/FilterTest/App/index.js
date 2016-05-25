/**
 * Created by min on 25/05/2016.
 */
var setvalue = function (){
  alert('ddddddddddddddddd');
    setcommObj( "Yuzhu add.....................");
}
/***************************************** Yuzhu Add Start *******************************/
var app = angular.module('myApp', []);
app.controller('myCtrl', [ '$scope', function($scope) {

    /*Options start*/
    $scope.items = [{ id: 1, name: 'Add Radio Button' },
        { id: 2, name: 'Add Input Area' },];
    /*Options end*/

    /*Reset start*/
    $scope.reset = function() {
        $scope.result = ''
    }
    /*Reset end*/

    /*Add questions and answers start*/
    $scope.questions = [{
        id: 'choice1',
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

    /*Show questions and answers start*/
    $scope.selected = '';
    var y = '';
    var x = '';
    var z = '';
    $scope.showAnswers = function(question, answer, co) {
        $scope.result = '';
        if (co == '1') {
            x = question.name + answer.name;
        } else if (co == '2') {
            z = question.name;
            y += answer.name;
        }
        $scope.selected = x + z + y;
    }
    /*Show questions and answers end*/

    /*Submit start*/
    $scope.submit = function() {
        $scope.result = $scope.selected;
        $scope.selected = '';
        y = '';
        x = '';
        z = '';
    }
    /*Submit end*/

    /*Save check start*/
    $scope.submit2 = function() {
        if ($scope.nextStep == undefined || $scope.nextStep == '') {
            $scope.error = 'Please input the tittle of next step.';
        } else {
            $scope.error = 'No error.';
        }
    }
    /*Save check end*/
} ]);