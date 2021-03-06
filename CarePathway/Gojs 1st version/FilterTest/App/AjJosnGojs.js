/**
 * Created by min on 19/05/2016.
 */

commObj = 'Step0/Q:what is your name?/A:jimmy/Q:Waht is you age?/A：age<23/Step1';
var selectkey =0;
var oldkeynumber = 0;
var keynumber = 0;
var selectlocation ={};
var xselectlocation=175;
var yselectlocation=0;
var objs = {
    class: "go.GraphLinksModel",
    linkFromPortIdProperty: "fromPort",
    linkToPortIdProperty: "toPort",
    nodeDataArray: [
        {category: "Comment", loc: "360 -10", text: "This is first Pathway!", key: -13},
        {key:keynumber, category: "Start", loc: "175 0", text: "Start \n Key:" + keynumber}
    ],
    linkDataArray: []
}
var objsJson = {};

var myDiagram = {};


/*******************************************************************************************************************************************************************
 *  Gojs functions  by Min Zan --------------------------------------------------------------------------------------------------------------------
 ******************************************************************************************************************************************************************/

var initial = function () {
    var Gojs = go.GraphObject.make;  // for conciseness in defining templates

    myDiagram =
        Gojs(go.Diagram, "myDiagramDiv",  // must name or refer to the DIV HTML element
            {
                initialContentAlignment: go.Spot.Top,
                allowDrop: true,  // must be true to accept drops from the Palette
                "LinkDrawn": showLinkLabel,  // this DiagramEvent listener is defined below
                "LinkRelinked": showLinkLabel,
                "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
                hasVerticalScrollbar: true,
                "animationManager.isEnabled": false,
                hasHorizontalScrollbar: true,
                "animationManager.duration": 1000, // slightly longer than default (600ms) animation
                //autoScale:go.Diagram.Uniform,
                "undoManager.isEnabled": true  // enable undo & redo
            });


    // when the document is modified, add a "*" to the title and enable the "Save" button
    myDiagram.addDiagramListener("Modified", function (e) {
        var button = document.getElementById("SaveButton");
        if (button) button.disabled = !myDiagram.isModified;
        var idx = document.title.indexOf("*");
        if (myDiagram.isModified) {
            if (idx < 0) document.title += "*";
        } else {
            if (idx >= 0) document.title = document.title.substr(0, idx);
        }
    });

    // helper definitions for node templates

    function nodeStyle() {
        return [
            // The Node.location comes from the "loc" property of the node data,
            // converted by the Point.parse static method.
            // If the Node.location is changed, it updates the "loc" property of the node data,
            // converting back using the Point.stringify static method.
            new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
            {
                // the Node.location is at the center of each node
                locationSpot: go.Spot.Center,
                //isShadowed: true,
                //shadowColor: "#888",
                // handle mouse enter/leave events to show/hide the ports
                //mouseClick:  function (e, obj) { alert('111111111111');},
                click:function(e,obj){
                    selectkey = obj.part.data.key;
                    document.getElementById("fromnode").value=selectkey ;
                    alert(obj.part.data.Title);
                    selectlocation = obj.location.copy();
                    //alert(selectlocation);
                },
                mouseEnter: function (e, obj) {
                    showPorts(obj.part, true);
                },
                mouseLeave: function (e, obj) {
                    showPorts(obj.part, false);
                }
            }
        ];
    }

    // Define a function for creating a "port" that is normally transparent.
    // The "name" is used as the GraphObject.portId, the "spot" is used to control how links connect
    // and where the port is positioned on the node, and the boolean "output" and "input" arguments
    // control whether the user can draw links from or to the port.
    function makePort(name, spot, output, input) {
        // the port is basically just a small circle that has a white stroke when it is made visible
        return Gojs(go.Shape, "Circle",
            {
                fill: "transparent",
                stroke: null,  // this is changed to "white" in the showPorts function
                desiredSize: new go.Size(8, 8),
                alignment: spot, alignmentFocus: spot,  // align the port on the main Shape
                portId: name,  // declare this object to be a "port"
                fromSpot: spot, toSpot: spot,  // declare where links may connect at this port
                fromLinkable: output, toLinkable: input,  // declare whether the user may draw links to/from here
                cursor: "pointer"  // show a different cursor to indicate potential link point
            });
    }

    //go.("UndesiredEvent",
    //    $(go.Node, "Auto",
    //        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
    //        { selectionAdornmentTemplate: UndesiredEventAdornment },
    //        $(go.Shape, "RoundedRectangle",
    //            { fill: redgrad, portId: "", toLinkable: true, toEndSegmentLength: 50 }),
    //        $(go.Panel, "Vertical", {defaultAlignment: go.Spot.TopLeft},
    //
    //            $(go.TextBlock, "Drop", textStyle(),
    //                { stroke: "whitesmoke",
    //                    minSize: new go.Size(80, NaN) },
    //                new go.Binding("text", "text").makeTwoWay()),
    //
    //            $(go.Panel, "Vertical",
    //                { defaultAlignment: go.Spot.TopLeft,
    //                    itemTemplate: reasonTemplate },
    //                new go.Binding("itemArray", "reasonsList").makeTwoWay()
    //            )
    //        )
    //    ))
    // define the Node templates for regular nodes

    var lightText = 'whitesmoke';

    myDiagram.nodeTemplateMap.add("",  // the default category
        Gojs(go.Node, "Spot", nodeStyle(),
            // the main object is a Panel that surrounds a TextBlock with a rectangular Shape
            Gojs(go.Panel, "Auto",
                Gojs(go.Shape, "Rectangle",
                    {fill: "#00A9C9", stroke: null},
                    new go.Binding("figure", "figure")),
                Gojs(go.TextBlock,
                    {
                        font: "bold 8pt Helvetica, Cambria, sans-serif",
                        stroke: lightText,
                        margin: 8,
                        maxSize: new go.Size(160, NaN),
                        wrap: go.TextBlock.WrapFit,
                        editable: true
                    },
                    new go.Binding("text").makeTwoWay())
                //Gojs(go.TextBlock,
                //    {
                //        font: "bold 8pt Helvetica, Cambria, sans-serif",
                //        stroke: lightText,
                //        margin: 8,
                //        maxSize: new go.Size(160, NaN),
                //        wrap: go.TextBlock.WrapFit,
                //        editable: true
                //    },
                //    new go.Binding("Title").makeTwoWay())
            ),
            // four named ports, one on each side:
            makePort("T", go.Spot.Top, false, true),
            makePort("L", go.Spot.Left, true, true),
            makePort("R", go.Spot.Right, true, true),
            makePort("B", go.Spot.Bottom, true, false)
        ));

    //myDiagram.nodeTemplateMap.add("",  // the default category
    //    Gojs(go.Node, "Spot", nodeStyle(),
    //        // the main object is a Panel that surrounds a TextBlock with a rectangular Shape
    //        Gojs(go.Panel, "Auto",
    //            Gojs(go.Shape, "Rectangle",
    //                {fill: "#00A9C9", stroke: null},
    //                new go.Binding("figure", "figure")),
    //            Gojs(go.TextBlock,
    //                {
    //                    font: "bold 8pt Helvetica, Cambria, sans-serif",
    //                    stroke: lightText,
    //                    margin: 8,
    //                    maxSize: new go.Size(160, NaN),
    //                    wrap: go.TextBlock.WrapFit,
    //                    editable: true
    //                },
    //                new go.Binding("text").makeTwoWay())
    //        ),
    //        // four named ports, one on each side:
    //        makePort("T", go.Spot.Top, false, true),
    //        makePort("L", go.Spot.Left, true, true),
    //        makePort("R", go.Spot.Right, true, true),
    //        makePort("B", go.Spot.Bottom, true, false)
    //    ));

    myDiagram.nodeTemplateMap.add("Start",
        Gojs(go.Node, "Spot", nodeStyle(),
            Gojs(go.Panel, "Auto",
                Gojs(go.Shape, "Circle",
                    {minSize: new go.Size(40, 40), fill: "#79C900", stroke: null}),
                Gojs(go.TextBlock, "Start",
                    {font: "bold 11pt Helvetica, Cambria, sans-serif", stroke: lightText},
                    new go.Binding("text"))
            ),
            // three named ports, one on each side except the top, all output only:
            makePort("L", go.Spot.Left, true, false),
            makePort("R", go.Spot.Right, true, false),
            makePort("B", go.Spot.Bottom, true, false)
        ));

    myDiagram.nodeTemplateMap.add("End",
        Gojs(go.Node, "Spot", nodeStyle(),
            Gojs(go.Panel, "Auto",
                Gojs(go.Shape, "Circle",
                    {minSize: new go.Size(40, 40), fill: "#DC3C00", stroke: null}),
                Gojs(go.TextBlock, "End",
                    {font: "bold 11pt Helvetica, Cambria, sans-serif", stroke: lightText},
                    new go.Binding("text"))
            ),
            // three named ports, one on each side except the bottom, all input only:
            makePort("T", go.Spot.Top, false, true),
            makePort("L", go.Spot.Left, false, true),
            makePort("R", go.Spot.Right, false, true)
        ));



    myDiagram.nodeTemplateMap.add("Comment",
        Gojs(go.Node, "Auto", nodeStyle(),
            Gojs(go.Shape, "File",
                {fill: "#EFFAB4", stroke: null}),
            Gojs(go.TextBlock,
                {
                    margin: 5,
                    maxSize: new go.Size(200, NaN),
                    wrap: go.TextBlock.WrapFit,
                    textAlign: "center",
                    editable: true,
                    font: "bold 12pt Helvetica, Arial, sans-serif",
                    stroke: '#454545'
                },
                new go.Binding("text").makeTwoWay())
            // no ports, because no links are allowed to connect with a comment
        ));


    // replace the default Link template in the linkTemplateMap
    myDiagram.linkTemplate =
        Gojs(go.Link,  // the whole link panel
            {
                routing: go.Link.AvoidsNodes,
                curve: go.Link.JumpOver,
                corner: 5, toShortLength: 4,
                relinkableFrom: true,
                relinkableTo: true,
                reshapable: true,
                resegmentable: true,
                // mouse-overs subtly highlight links:
                mouseEnter: function (e, link) {
                    link.findObject("HIGHLIGHT").stroke = "rgba(30,144,255,0.2)";
                },
                mouseLeave: function (e, link) {
                    link.findObject("HIGHLIGHT").stroke = "transparent";
                }
            },
            new go.Binding("points").makeTwoWay(),
            Gojs(go.Shape,  // the highlight shape, normally transparent
                {isPanelMain: true, strokeWidth: 8, stroke: "transparent", name: "HIGHLIGHT"}),
            Gojs(go.Shape,  // the link path shape
                {isPanelMain: true, stroke: "gray", strokeWidth: 2}),
            Gojs(go.Shape,  // the arrowhead
                {toArrow: "standard", stroke: null, fill: "gray"}),
            Gojs(go.Panel, "Auto",  // the link label, normally not visible
                {visible: true, name: "LABEL", segmentIndex: 2, segmentFraction: 0.5},
                new go.Binding("visible", "visible").makeTwoWay(),
                Gojs(go.Shape, "RoundedRectangle",  // the label shape
                    {fill: "#F8F8F8", stroke: null}),
                Gojs(go.TextBlock, "lable", // the label text
                    {
                        textAlign: "center",
                        font: "10pt helvetica, arial, sans-serif",
                        stroke: "#555555",
                        margin: 4
                    },
                    new go.Binding("text", "text").makeTwoWay())
            )
        );

    // Make link labels visible if coming out of a "conditional" node.
    // This listener is called by the "LinkDrawn" and "LinkRelinked" DiagramEvents.
    function showLinkLabel(e) {
        var label = e.subject.findObject("LABEL");
        if (label !== null) label.visible = (e.subject.fromNode.data.figure === "Diamond");
    }

    // temporary links used by LinkingTool and RelinkingTool are also orthogonal:
    myDiagram.toolManager.linkingTool.temporaryLink.routing = go.Link.Orthogonal;
    myDiagram.toolManager.relinkingTool.temporaryLink.routing = go.Link.Orthogonal;

    load();  // load an initial diagram from some JSON text

}

// Make all ports on a node visible when the mouse is over the node
function showPorts(node, show) {
    var diagram = node.diagram;
    if (!diagram || diagram.isReadOnly || !diagram.allowLink) return;
    node.ports.each(function (port) {
        port.stroke = (show ? "white" : null);
    });
}


// Show the diagram's model in JSON format that the user may edit
function save() {


    document.getElementById("mySavedModel").value = myDiagram.model.toJson();
    myDiagram.isModified = false;
}
function load() {

    myDiagram.model = go.Model.fromJson(objsJson);


}

// add an SVG rendering of the diagram at the end of this page
function makeSVG() {
    var svg = myDiagram.makeSvg({
        scale: 0.5
    });
    svg.style.border = "1px solid black";
    obj = document.getElementById("SVGArea");
    obj.appendChild(svg);
    if (obj.children.length > 0) {
        obj.replaceChild(svg, obj.children[0]);
    }
}



/******************************************************************************************************************************************************************
 *  AngularJ functions  by Min Zan, Yuzhu Wang --------------------------------------------------------------------------------------------------------------------
 ******************************************************************************************************************************************************************/

var myApp = angular.module('myApp', []).

    /***************************************************************************************************************************************************************
     *   left part controller by yuzhu wang   --------------------------------------------------------------------------------------------------------
     ***************************************************************************************************************************************************************/
    controller('myCtrl', [ '$scope', function($scope) {

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
} ])

    /****************************************************************************************************************************************************************
     *   right part controller   by Min Zan -----------------------------------------------------------------------------------------
     ***************************************************************************************************************************************************************/
    .controller('AjJsonGojscontroller', function ($scope, $filter) {

    objsJson = $filter('json')(objs);
    initial();


        $scope.getcommonObjs = function(){
            alert(commObj);
        }
   // and new nod
    $scope.ajaddnode = function () {
        oldkeynumber = keynumber;
        keynumber++;


        var diagram  = myDiagram;
        var model = diagram.model;



        var  nodtext = "Quetion: \n"+ $scope.questiontext + '\n' + 'Answer: ' +$scope.answertext;
        var frompot ='';
        var topot ='';

        var positionvalue =  document.getElementById('positons').value;
        if(positionvalue==1){
            xselectlocation =selectlocation.x;
            yselectlocation = selectlocation.y + 120;
        }else if(positionvalue==2){
            yselectlocation = selectlocation.y;
            xselectlocation = selectlocation.x - 200;
            frompot = 'L';
            topot ='R';
        }else if (positionvalue==3){
            yselectlocation = selectlocation.y;
            xselectlocation = selectlocation.x + 200;
            frompot = 'R';
            topot ='L';
        }

        var newloc = xselectlocation + " " + yselectlocation;
       diagram.startTransaction("Add State");

        model.addNodeData({
            key: keynumber,
            loc: newloc,
            text: nodtext + '\n'+ 'Nodekey: '+keynumber,
            Title : 'Title'
            //points:go.Point.stringify(selectlocation)
        });

        model.addLinkData({
            from:selectkey,
            to: keynumber,
            text: $scope.tag,
            fromPort:frompot,
            toPort: topot
        });

        diagram.commitTransaction("Add State");
    }

    $scope.connect = function () {

        var fromkey =  parseInt(document.getElementById('fromnode').value);
        var tokey =  parseInt(document.getElementById('tonode').value);

        var fromport = document.getElementById('fromport').value;
        var toport = document.getElementById('toport').value;

        var diagram  = myDiagram;
        var model = diagram.model;
        diagram.startTransaction("Add State");
        model.addLinkData({
            from:fromkey,
            to: tokey,
            text: $scope.tag,
            fromPort:fromport,
            toPort: toport
        });

        diagram.commitTransaction("Add State");
    }

        $scope.newadd=function(){
            var titlespilt  = commObj.split('/');
            alert(titlespilt[0]+'---'+titlespilt[titlespilt.length-1]);

            var text;
            for( i = 0;i<titlespilt.length-2;i++){
                if(i<titlespilt.length-2)
                {
                    text += titlespilt[i] + '\n';
                }
            }


         }



         $scope.savejson = function(){

             alert(myDiagram.model.toJson());
      //comfirm(myDiagram.model.toJson());
    }
});



