/**
 * Created by min on 19/05/2016.
 */
var filtertest = angular.module('myaapp',[],function($filterProvider,$provide,$controllerProvider){

    $provide.service('user_inforamtion',function(){
        return  [
            {
                id:1001,
                name:"jim",
                age:26,
                sex:'M'
            },{
                id:1002,
                name:"tom",
                age:27,
                sex:'M'
            },{
                id:1003,
                name:"Jane",
                age:23,
                sex:'F'
            }
        ]
    });

    $filterProvider.register('sex_filtere',function(){
        return function (obj){

           var return_obj =[];

            angular.forEach(obj,function(item){
                if(item.sex=='F'){
                    return_obj.push(item)
                }
            })

            return return_obj
        }
    });

    $controllerProvider.register('sexCongroller',function($scope,user_inforamtion){
          $scope.user_info = user_inforamtion;
    });

})
    .filter('age_filter',function(){

    return function (ooob){x
        var rt_array =[];
          angular.forEach(ooob,function(tt){
              if(tt.age<27){
                  rt_array.push(tt)
              }
          });
        return rt_array;
    }
})
var injectiontestApp = angular.module('injectionApp',[]);

injectiontestApp.value('input','sssssssssssssssss');

injectiontestApp.controller('injectcontroller',function ($scope,input){
    alert(input);
});

injectiontestApp.factory('MathService', function () {

})

//injectiontestApp.myfactory('myfactory',function(){
//    var objs =
//        [{
//            id:1100,
//            name:'Kitty',
//            age:13
//        },{
//            id:1101,
//            name:'David',
//            age:15
//        },{
//            id:1103,
//            name:'Jhonses',
//            age:19
//        }];
//    return objs;
//})

var getObjects = function (){
    var objs =
        [{
            id:1100,
            name:'Kitty',
            age:13
        },{
            id:1101,
            name:'David',
            age:15
        },{
            id:1103,
            name:'Jhonses',
            age:19
        }];
    return objs;
}

injectiontestApp.controller('injectcontroller',['$scope',function (sp){
    sp.city =
        [{
            id:1100,
            name:'Kitty',
            age:13
        },{
            id:1101,
            name:'David',
            age:15
        },{
            id:1103,
            name:'Jhonses',
            age:19
        }];
    sp.deleteitem = function(index,event){
        //sp.city.splice(index,1);
        angular.element(event.target).append('<input = type ="text">');
        angular.element(event.target).css('color','red');
        sp.sss = event.currentTarget.toString();
    }

    sp.add = function add(){
        sp.i++;
    }
}])