
function addDatePicker() {
    var n, x = document.getElementsByClassName("duedatecal");
    for (n = 0; n < x.length; n+=1) {
        $(x[n]).datepicker();
    }
}


$(function () {
    //var thesetodos = localStorage.getItem("thesetodos");
    if ((thesetodos === null) || (thesetodos === "") || (thesetodos === undefined)) {
        $("#todo-lists-with-datepicker").lobiList({
            lists: [
                {
                    title: 'TODO',
                    items: [
                    ]
                }
            ],
            afterListAdd: function(lobilist, list){
                var $dueDateInput = list.$el.find('form [name=dueDate]');
                $dueDateInput.datepicker();
            }
        });
    } else {
        var k, thisgroup, returntodos = [];
        thesetodos = JSON.parse(thesetodos);
        for (k = 0; k < thesetodos.length; k+=1) {
            thisgroup = JSON.parse(thesetodos[k]);
            returntodos.push(thisgroup);
        }
        $("#todo-lists-with-datepicker").lobiList({
            lists: returntodos,
            afterListAdd: function(lobilist, list){
                var $dueDateInput = list.$el.find('form [name=dueDate]');
                $dueDateInput.datepicker();
            }
        });
    }
    addDatePicker();
});


var json;

function handleFileSelect(evt) {
    var files = evt.target.files;
    var output = [];
    for (var i = 0, f; f = files[i]; i++) {
        var reader = new FileReader();
        reader.onload = (function (theFile) {
            return function (e) {
                console.log('e readAsText = ', e);
                console.log('e readAsText target = ', e.target);
                try {
                    json = JSON.parse(e.target.result);
                    $("#preview").val(json);
                } catch (ex) {
//                    $("#preview").val('ex when trying to parse json = ' + ex);
                    alert('ex when trying to parse json = ' + ex);
                }
            }
        })(f);
        reader.readAsText(f);
    }
}
document.getElementById("loadjson").addEventListener("change", handleFileSelect, false);


function gatherToDos() {
    "use strict";
    var i, j, wrapcolor, todoheader, todotitle, listitem, itemtitle, itemdescription, itemduedate, itemdone, wraptodos = "", wraplists = [], wrapitems = [], exptodos = "";
    var wrapper = document.querySelectorAll("body div .lobilist");
    for (j = 0; j < wrapper.length; j+=1) {
        wrapitems.length = 0;
        todotitle = wrapper[j].querySelectorAll(".lobilist-title");
        if (todotitle.length !== 0) {
            todoheader = todotitle[0].innerHTML;
        } else {
            todoheader = "";
        }
        wrapcolor = (wrapper[j].className).slice(9);
        if (wrapcolor !== "lobilist-default") {
            wraptodos = '{"title": "' + todoheader + '", "defaultStyle": "' + wrapcolor + '", "items": [';
        } else {
            wraptodos = '{"title": "' + todoheader + '"' + ', "items": [';
        }
        listitem = wrapper[j].querySelectorAll(".lobilist-item");
        for (i = 0; i < listitem.length; i+=1) {
            itemtitle = listitem[i].querySelectorAll(".lobilist-item-title");
            exptodos = '{"title": "' + itemtitle[0].innerHTML + '"';
            itemdescription = listitem[i].querySelectorAll(".lobilist-item-description");
            if (itemdescription.length > 0) {
                exptodos = exptodos + ', "description": "' + itemdescription[0].innerHTML + '"';
            }
            itemduedate = listitem[i].querySelectorAll(".lobilist-item-duedate");
            if (itemduedate.length > 0) {
                exptodos = exptodos + ', "dueDate": "' + itemduedate[0].innerHTML + '"';
            }
            if (listitem[i].className === "lobilist-item item-done") {
                exptodos = exptodos + ', "done": "true"';
            }
            exptodos = exptodos + '}';
            wrapitems.push(exptodos);
        }
        wraptodos = wraptodos + wrapitems + "]}";
        wraplists.push(wraptodos);
    }
    wraplists = JSON.stringify(wraplists);
    return wraplists;
}


$("#export_todos").click(function(e) {
    "use strict";
    e.preventDefault();
    var thesetodos = gatherToDos();
    var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(thesetodos);
    var dlAnchorElem = document.getElementById("downloadAnchorElem");
    dlAnchorElem.setAttribute("href", dataStr);
    dlAnchorElem.setAttribute("download", "newtodos.json");
    dlAnchorElem.click();
});


$("#import_todos").click(function (e) {
    "use strict";
    e.preventDefault();
    $("#loadjson").val("");
    $("#preview").val("");
    $("#importtodos").show();
});


$("#cancel_upload").click(function (e) {
    "use strict";
    e.preventDefault();
    $("#loadjson").val("");
    $("#preview").val("");
    $("#importtodos").hide();
});


function theseImportTodos(imptodos) {
    "use strict";
    var i, j, thisgroup, thesetodos = imptodos;
    $("#cancel_upload").click();
    thesetodos = thesetodos.replace(/]},{/g, "]}~{");
    thesetodos = thesetodos.split("~");
    for (j = 0; j < thesetodos.length; j+=1) {
        thisgroup = JSON.parse(thesetodos[j]);
        $("#todo-lists-with-datepicker").lobiList('addList', thisgroup);
    }
    addDatePicker();
}


$("#submit_upload").click(function (e) {
    "use strict";
    e.preventDefault();
    if ($("#loadjson").val() !== "") {
        var imptodos = (document.getElementById("preview").value);
        theseImportTodos(imptodos);
    } else {
        alert("No file selected to upload!");
    }
});


$("#reset_todos").click(function (e) {
    "use strict";
    e.preventDefault();
    $("#cancel_upload").click();
    $("#todo-lists-with-datepicker").empty();
    $("#todo-lists-with-datepicker").lobiList('addList', {title: 'TODO', items: []});
    addDatePicker();
});

