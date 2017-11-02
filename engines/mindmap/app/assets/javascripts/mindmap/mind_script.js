var mhmind_maps = [];

var presentmap_id = -1;

var filenamediv = document.getElementById("filename_div");
var filenameinput = document.getElementById("filenameinput");
var nametype = document.getElementById("nametype");

var docfilename = document.getElementById("docfilename");
docfilename.addEventListener("click", function () {
  if (docfilename.value !== "MHMind.jm") {
    nametype.value = "modifyfunc";
    if (filenamediv.style.display !== "block") {
       filenamediv.style.display = "block";
       filenameinput.value = docfilename.value.slice(0,-3);
    }
  }
});

var _jm = null;

function open_empty(){
    "use strict";
    var options = {
        container:'jsmind_container',
        theme:'light',
        editable:true
    }
    _jm = MHMind.show(options);
    // _jm = jsMind.show(options,mind);
}

/*
 function open_ajax(){
 var mind_url = 'data_example.json';
 MHMind.util.ajax.get(mind_url,function(mind){
 _jm.show(mind);
 });
 }
 */
function screen_shot(){
    "use strict";
    _jm.screenshot.shootDownload();
}


function save_file(){
    "use strict";
    var mind_data = _jm.get_data();
    var mind_name = docfilename.value;
    var mind_str = MHMind.util.json.json2string(mind_data);
    MHMind.util.file.save(mind_str,'text/jsmind',mind_name);
}


function open_file(){
    "use strict";
    var files = file_input.files;
    if(files.length > 0){
        var file_data = files[0];
        MHMind.util.file.read(file_data,function(jsmind_data, jsmind_name){
            var mind = MHMind.util.json.string2json(jsmind_data);
            if(!!mind){
                _jm.show(mind);
                docfilename.value = file_input.value.slice(12);
            }else{
                prompt_info('Can not open this file as mindmap.');
            }
        });
    }else{
        prompt_info('Please choose a file first.')
    }
}


var submituploadbtn = document.getElementById("submituploadbtn");
submituploadbtn.addEventListener("click", function () {
    open_file();
});

var file_input = document.getElementById("file_input");
file_input.addEventListener("change", function () {
    if (file_input.value !== "") {
        submituploadbtn.click();
    }         
});

var uploadbtn = document.getElementById("uploadbtn");
uploadbtn.addEventListener("click", function () {
    file_input.value = "";
    file_input.click();
});


function select_node(){
    "use strict";
    var nodeid = 'other';
    _jm.select_node(nodeid);
}

function show_selected(){
    "use strict";
    var selected_node = _jm.get_selected_node();
    if(!!selected_node){
        prompt_info(selected_node.topic);
    }else{
        prompt_info('nothing');
    }
}

function get_selected_nodeid(){
    "use strict";
    var selected_node = _jm.get_selected_node();
    if(!!selected_node){
        return selected_node.id;
    }else{
        return null;
    }
}

function add_node(){
    "use strict";
    var selected_node = _jm.get_selected_node(); // as parent of new node
    if(!selected_node){prompt_info('Please select a node first.');return;}

    var nodeid = MHMind.util.uuid.newid();
    var topic = '* Node_'+nodeid.substr(0,5)+' *';
    var node = _jm.add_node(selected_node, nodeid, topic);
}

var imageChooser = document.getElementById('image-chooser');

imageChooser.addEventListener('change', function (event) {
    "use strict";
    // Read file here.
    var reader = new FileReader();
    reader.onloadend = (function () {
        var selected_node = _jm.get_selected_node();
        var nodeid = MHMind.util.uuid.newid();
        var topic = undefined;
        var data = {
            "background-image": reader.result,
            "width": "100",
            "height": "100"};
        var node = _jm.add_node(selected_node, nodeid, topic, data);
        //var node = _jm.add_image_node(selected_node, nodeid, reader.result, 100, 100);
        //add_image_node:function(parent_node, nodeid, image, width, height, data, idx, direction, expanded){
    });

    var file = imageChooser.files[0];
    if (file) {
        reader.readAsDataURL(file);
    };

}, false);

function add_image_node(){
    "use strict";
    var selected_node = _jm.get_selected_node(); // as parent of new node
    if(!selected_node){
        prompt_info('Please select a node first.');
        return;
    }

    imageChooser.focus();
    imageChooser.click();
}


function edit_node_text(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.begin_edit(selected_id);
}

function move_to_first(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.move_node(selected_id,'_first_');
}

function move_to_last(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.move_node(selected_id,'_last_');
}

/*    function move_node(){
 // move a node before another
 _jm.move_node('other','open');
 }
 */
function remove_node(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}
    var checkstr = window.confirm('Sure you want to delete this node?');
    if (checkstr === false) {
        return;
    }
    _jm.remove_node(selected_id);
}


function change_text_color(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.set_node_color(selected_id, null, '#000');
}

var colorshades = [
    ["#000000","#333333","#595959","#808080","#a6a6a6","#cccccc","#f2f2f2","#ecd9c6","#d9b38c","#c68c53","#996633","#604020"],["#000080","#0000cc","#1a1aff","#6666ff","#9999ff","#ccccff","#8cb3d9","#6699cc","#4080bf","#336699","#264d73","#19334d"],["#20603b","#2e8b57","#53c685","#79d2a0","#9fdfbb","#c6ecd6","#00cccc","#008080","#4dff4d","#00cc00","#008000","#004d00"],["#4b0082","#800080","#cc00cc","#c71585","#ff33ff","#ff99ff","#ffcccc","#ff9999","#ff6666","#ff3333","#cc0000","#800000"],["#804d00","#b36b00","#d2691e","#ff9900","#ffb84d","#ffd699","#ffffcc","#ffff99","#ffff1a","#cccc00","#808000","#4d4d00"]
];
var ch, cv, selcolortr, selcolortd, selcolors = "", colordiv = document.getElementById("selcolors");
for (cv = 0; cv < colorshades.length; cv+=1) {
    selcolortr = '<tr>';
    for (ch = 0; ch < colorshades[cv].length; ch+=1) {
        selcolortd = '<td class="colorshade" style="background-color:' + colorshades[cv][ch] + '"></td>';
        selcolortr = selcolortr + selcolortd;
    }
    selcolortr = selcolortr + '</tr>';
    selcolors = selcolors + selcolortr;
}
colordiv.innerHTML = selcolors;
var c, colortd = document.querySelectorAll(".colorshade");
for (c = 0; c < colortd.length; c+=1) {
    colortd[c].addEventListener("click", function () {
        document.getElementById("colorpickerbtn").value = this.style.backgroundColor;
        document.getElementById("colorpickerbtn").style.backgroundColor = this.style.backgroundColor;
    });
}

function change_background_color(){
    "use strict";
    var colorpick = document.getElementById("colorpickerbtn").value;
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}
    _jm.set_node_color(selected_id, colorpick, null);
}

function open_color_picker(){
    "use strict";
    document.getElementById("colorpicker").style.display = "block";
}

function close_color_picker(){
    "use strict";
    document.getElementById("colorpicker").style.display = "none";
}

function change_background_image(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.set_node_background_image(selected_id, 'ant.png', 100, 100);
}

function set_theme(theme_name){
    "use strict";
    _jm.set_theme(theme_name);
}

var zoomInButton = document.getElementById("zoom-in-button");
var zoomOutButton = document.getElementById("zoom-out-button");

function zoomIn() {
    "use strict";
    if (_jm.view.zoomIn()) {
        zoomOutButton.disabled = false;
    } else {
        zoomInButton.disabled = true;
    };
};

function zoomOut() {
    "use strict";
    if (_jm.view.zoomOut()) {
        zoomInButton.disabled = false;
    } else {
        zoomOutButton.disabled = true;
    };
};

function toggle_editable(btn){
    "use strict";
    var editable = _jm.get_editable();
    if(editable){
        _jm.disable_edit();
        //    btn.innerHTML = 'enable editable';
        btn.innerHTML = '<img src="/mindmap/glyphicons-200-ban-circle.png" class="wh20x20"> <img src="/mindmap/glyphicons-31-pencil.png" class="wh16x16">';
    }else{
        _jm.enable_edit();
//            btn.innerHTML = 'disable editable';
        btn.innerHTML = '<img src="/mindmap/glyphicons-199-ok-circle.png" class="wh20x20"> <img src="/mindmap/glyphicons-31-pencil.png" class="wh16x16">';
    }
}


function resize_jsmind(){
    "use strict";
    _jm.resize();
}
// this method change size of container, prepare for adjusting jsmind
function change_container(widthsize){
    "use strict";
    var c = document.getElementById('jsmind_container');
    if (widthsize === 'xxlarge2') {
        c.style.width = '100%';
        c.style.height = '1340px';
    } else if (widthsize === 'xxlarge1') {
        c.style.width = '100%';
        c.style.height = '1000px';
    } else if (widthsize === 'xlarge3') {
        c.style.width = '100%';
        c.style.height = '940px';
    } else if (widthsize === 'xlarge2') {
        c.style.width = '100%';
        c.style.height = '900px';
    } else if (widthsize === 'xlarge1') {
        c.style.width = '100%';
        c.style.height = '900px';
    } else if (widthsize === 'large2') {
        c.style.width = '100%';
        c.style.height = '900px';
    } else if (widthsize === 'large1') {
        c.style.width = '100%';
        c.style.height = '800px';
    } else if (widthsize === 'medium2') {
        c.style.width = '100%';
        c.style.height = '740px';
    } else if (widthsize === 'small2') {
        c.style.width = '100%';
        c.style.height = '600px';
    } else if (widthsize === 'small1') {
        c.style.width = '100%';
        c.style.height = '900px';
    } else if (widthsize === 'xsmall2') {
        c.style.width = '100%';
        c.style.height = '900px';
    } else if (widthsize === 'xsmall1') {
        c.style.width = '100%';
        c.style.height = '300px';
    } else  { //medium1
        c.style.width = '100%';
        c.style.height = '700px';
    }
    resize_jsmind();
}



function setlayout() {
    "use strict";
    var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if (w <= '640') {
        change_container('xsmall1');
    } else if ((w > '640') && (w < '768')) {
        change_container('xsmall2');
    } else if ((w >= '768') && (w < '940')) {
        change_container('small1');
    } else if ((w >= '940') && (w < '1000')) {
        change_container('small2');
    } else if ((w >= '1000') && (w < '1200')) {
        change_container('medium1');
    } else if ((w >= '1200') && (w < '1300')) {
        change_container('medium2');
    } else if ((w >= '1300') && (w < '1400')) {
        change_container('large1');
    } else if ((w >= '1400') && (w < '1500')) {
        change_container('large2');
    } else if ((w >= '1500') && (w < '1600')) {
        change_container('xlarge1');
    } else if ((w >= '1600') && (w < '1680')) {
        change_container('xlarge2');
    } else if ((w >= '1680') && (w < '1900')) {
        change_container('xlarge3');
    } else if ((w >= '1900') && (w < '2400')) {
        change_container('xxlarge1');
    } else {
        if (w >= '2400') {
            change_container('xxlarge2');
        }
    }
}

function expand(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.expand_node(selected_id);
}

function collapse(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.collapse_node(selected_id);
}

function toggle(){
    "use strict";
    var selected_id = get_selected_nodeid();
    if(!selected_id){prompt_info('Please select a node first.');return;}

    _jm.toggle_node(selected_id);
}

/*
 function expand_all(){
 _jm.expand_all();
 }
 function collapse_all(){
 _jm.collapse_all();
 }
 */

function expand_to_level2(){
    "use strict";
    _jm.expand_to_depth(2);
}

function expand_to_level3(){
    "use strict";
    _jm.expand_to_depth(3);
}

function collapse_expand_all(){
    "use strict";
    if (document.getElementById('collapse_expand_btn').innerHTML === '<sup><img src="/mindmap/glyphicons-172-fast-backward.png" class="wh13x9"></sup> <img src="/mindmap/glyphicons-154-unchecked.png" class="wh16x16">') {
        document.getElementById('collapse_expand_btn').innerHTML = '<img src="/mindmap/glyphicons-154-unchecked.png" class="wh16x16"> <sup><img src="/mindmap/glyphicons-178-fast-forward.png" class="wh13x9"></sup>';
        _jm.collapse_all();
    } else {
        document.getElementById('collapse_expand_btn').innerHTML = '<sup><img src="/mindmap/glyphicons-172-fast-backward.png" class="wh13x9"></sup> <img src="/mindmap/glyphicons-154-unchecked.png" class="wh16x16">';
        _jm.expand_all();
    }
}

function prompt_info(msg){
    "use strict";
    alert(msg);
}


function get_map_info() {
    "use strict";
    var mind_data = _jm.get_data();
    var mind_str = MHMind.util.json.json2string(mind_data);
    return mind_str;          
}


function default_map() {
    "use strict";
    document.getElementById("jsmind_container").innerHTML = null;
    presentmap_id = -1;
    docfilename.value = "MHMind.jm";
    open_empty();
}


function checkDefault() {
    "use strict";
    if (docfilename.value.toLowerCase() !== "mhmind.jm") {
        return false;      
    }
    var mind_data = _jm.get_data();
    var mind_str = MHMind.util.json.json2string(mind_data);
    if (mind_str === '{"meta":{"name":"MHMind","author":"MicroHealth, LLC","version":"0.1.0"},"format":"node_tree","data":{"id":"root","topic":"Your Concept Here","expanded":true}}') {
        return true;
    } else {
        return false;
    }
}


var resetmapbtn = document.getElementById("resetmapbtn");
resetmapbtn.addEventListener("click", function () {
    if (presentmap_id !== -1) {
        savemap();
    } else {
        var defaultmap = checkDefault();
        if (defaultmap === false) {
            var checkstr = window.confirm('Click "Cancel" if this mind map needs to be saved first, otherwise click "OK".');
            if (checkstr === false) {
                filenameform();
                return;
            }
        }
    }
    default_map();
});



function editmap(btnid) {
    "use strict";
    if (Number(btnid) !== presentmap_id) {
        if (presentmap_id !== -1) {
            savemap();
        } else {
            var defaultmap = checkDefault();
            if (defaultmap === false) {
                var checkstr = window.confirm('Click "Cancel" if this mind map needs to be saved first, otherwise click "OK".');
                if (checkstr === false) {
                    filenameform();
                    return;
                }
            }
        }
        var found = false, i = -1;
        while ((found === false) && (i < mhmind_maps.length)) {
            i += 1;
            if (mhmind_maps[i].id === Number(btnid)) {
                found = true;
            }
        }
        if (found === true) {
            presentmap_id = Number(btnid);
            _jm.show(mhmind_maps[i].map);
            docfilename.value = mhmind_maps[i].docfilename;
        } else {
            prompt_info("Error, map not found!");
        }
    } else {
        prompt_info("This mind map is displayed!");
    }
}

function deletemap(btnid) {
    "use strict";
    var found = false, i = -1;
    while ((found === false) && (i < mhmind_maps.length)) {
        i += 1;
        if (mhmind_maps[i].id === Number(btnid)) {
            found = true;
        }
    }
    if (found === true) {
        mhmind_maps.splice(i, 1);
        if (Number(btnid) === presentmap_id) {
            default_map();
        }
        update_maplisting(null);
    } else {
        prompt_info("Error, map not found!");
    }
}


var deleteallbtn = document.getElementById("deleteallbtn");
deleteallbtn.addEventListener("click", function () {
    var checkstr = window.confirm('Sure you want to delete ALL maps? Click "OK" to proceed, otherwise "Cancel"?');
    if (checkstr === false) {
        return;
    }
    resetmapbtn.click();
    mhmind_maps.length = 0;
    update_maplisting(null);
    localStorage.removeItem("thesemhminds1");
});


function update_maplisting(srchinput) {
    "use strict";
    var i, s1, s2, nodetext, nodestr, nodetopic, foundtopic, c = 0, maplist_items = "", warning = false;
    var searchtext = document.getElementById("searchtext");
    var this_list = document.getElementById("maplisting");
    this_list.innerHTML = null;
    if (srchinput === null) {
        document.getElementById("searchmaps").value = "";
    }
    for (i = mhmind_maps.length - 1; i >= 0; i-=1) {
        if (srchinput !== null) {
            if (mhmind_maps[i].docfilename.toLowerCase().indexOf(srchinput) > -1) {
                foundtopic = true;
            } else {
                foundtopic = false;                
            }
            if ((foundtopic === false) && (searchtext.checked === true)) {
                nodetext = JSON.stringify(mhmind_maps[i].map.data);
                nodestr = nodetext.toLowerCase();
                while ((foundtopic === false) && (nodestr.indexOf('"topic":"') > -1)) {
                    s1 = nodestr.indexOf('"topic":"');
                    nodestr = nodestr.slice(s1 + 9);
                    s2 = nodestr.indexOf('","expanded":');
                    nodetopic = nodestr.slice(0, s2);
                    if (nodetopic.indexOf(srchinput.toLowerCase()) > -1) {
                        foundtopic = true;
                    }
                }
            }
        }
        if ((srchinput === null) || (foundtopic === true)) {
           maplist_items = maplist_items + '<p><button id="deletebtn' + mhmind_maps[i].id + '" class="deletemapbtn" title="Delete ' + mhmind_maps[i].docfilename + '"><img src="/mindmap/glyphicons-208-remove.png" class="wh12x12"></button><button id="editbtn' + mhmind_maps[i].id + '" class="editmapbtn" title="Edit ' + mhmind_maps[i].docfilename + '"><img src="/mindmap/glyphicons-151-edit.png" class="wh17x15"></button>' + mhmind_maps[i].docfilename + '</p>';
        }
    }
    this_list.innerHTML = maplist_items;
    var j, editbtns = document.querySelectorAll(".editmapbtn");
    for (j = 0; j < editbtns.length; j+=1) {
        editbtns[j].addEventListener("click", function() {
            editmap(this.id.slice(7));
       });
    }
    var k, deletebtns = document.querySelectorAll(".deletemapbtn");
    for (k = 0; k < deletebtns.length; k+=1) {
        deletebtns[k].addEventListener("click", function() {
            var checkstr = window.confirm('Sure you want to delete mind map ' + this.title.slice(7) + '?');
            if (checkstr === false) {
                return;
            }
            deletemap(this.id.slice(9));
       });
    }
    var deletediv = document.getElementById("deletediv");
    var filesessionmsg = document.getElementById("filesessionmsg");
    if (mhmind_maps.length > 0) {
        deletediv.style.display = "block";
        filesessionmsg.style.display = "block";
    } else {
        deletediv.style.display = "none";
        filesessionmsg.style.display = "none";
    }
    return;
}


var searchmaps = document.getElementById("searchmaps");
searchmaps.addEventListener("change", function() {
    var searchitem = document.getElementById("searchmaps").value.trim();
    if (searchitem === "") {
        update_maplisting(null);
    }
});


function findmap() {
    "use strict";
    var searchitem = document.getElementById("searchmaps").value.trim().toLowerCase();
    if ((searchitem !== "") && (presentmap_id === -1)) {
        var checkstr = window.confirm('Proceed with search, excluding this unsaved mind map?');
        if (checkstr === false) {
            return;
        }
    }
    update_maplisting(searchitem);
}


function save_map(mind_str) {
    "use strict";
    var thisfile = docfilename.value;
    var this_map = JSON.parse(mind_str);
    var this_group = {};
    if (presentmap_id === -1) {
        if (mhmind_maps.length > 0) {
            var this_id = Number(mhmind_maps[mhmind_maps.length - 1].id) + 1;
        } else {
            var this_id = 0;
       }
        this_group.id = this_id;
        this_group.docfilename = thisfile;
        this_group.map = this_map;
        mhmind_maps.push(this_group);
        presentmap_id = this_id;
    } else {
        mhmind_maps[presentmap_id].map = this_map;
        mhmind_maps[presentmap_id].docfilename = thisfile;
    }
    update_maplisting(null);
    return;
}

function checkValid() {
    var validname = false;
    var thisdocfilename = docfilename.value.trim();
    docfilename.value = thisdocfilename;
    if (thisdocfilename === "") {
        alert("Must input doc file name!");
    } else {
        if (thisdocfilename.toLowerCase() === "mhmind.jm") {
            alert('File name must not be "mhmind.jm"!');
        } else {
            validname = true;
        }
    }
    return validname;
}

function checkName() {
    var i = -1, found = false;
    while ((found === false) && (i < mhmind_maps.length - 1)) {
        i += 1;
        if (mhmind_maps[i].docfilename.toLowerCase() === docfilename.value.toLowerCase()) {
            found = true;
        }
    }
    if (found === true) {
        return(i);
    } else {
        return(-1);
    }
}

/*
function savemap() {
    "use strict";
    var mind_str = get_map_info();
    if (mind_str !== true) {
        save_map(mind_str);
    } else {
        prompt_info("Default map!");
    }

    thesemhminds1 = JSON.stringify(mhmind_maps);
    $.ajax({ url: '/mindmap/mindmap/save.js?content='+thesemhminds1 })
}
*/


function savemap() {
    "use strict";
    var validname = checkValid();
    if (validname === true) {
        var found = checkName();
        if (presentmap_id === -1) {
            if (found > -1) {
                alert("Change the file name, this one already exists!");
                docfilename.value = "MHMind.jm";
                return;
            }
        } else {
            if ((found !== -1) && (found !== presentmap_id) && (nametype.value === "copyfunc")) {
                alert("That file name already exists for another file!");
                docfilename.value = mhmind_maps[presentmap_id].docfilename;
                return;
            }
        }
        var mind_str = get_map_info();
        save_map(mind_str);
        thesemhminds1 = JSON.stringify(mhmind_maps);
        $.ajax({ url: '/mindmap/mindmap/save.js?content='+thesemhminds1 })
    }
    return;
}



function duplicatemap() {
    "use strict";
    var validname = checkValid();
    if (validname === true) {
        var found = checkName();
        if (found !== -1) {
            alert("That file name already exists for another file!");
            docfilename.value = mhmind_maps[presentmap_id].docfilename;
            return;
        }
        presentmap_id = -1;
        var mind_str = get_map_info();
        save_map(mind_str);
    }
    return;
}


var cancelfilename = document.getElementById("cancelfilename");
cancelfilename.addEventListener("click", function (e) {
  e.preventDefault();
  filenameinput.value = "";
  nametype.value = "newfunc";
  filenamediv.style.display = "none";
});


var submitfilename = document.getElementById("submitfilename");
submitfilename.addEventListener("click", function (e) {
   e.preventDefault();
   var thisfilename = filenameinput.value.trim();
   if (thisfilename === "") {
      alert("Input file name!");
      filenameinput.value = "";
   } else if (thisfilename.toLowerCase() === "mhmind") {
      alert('File name must not be "MHMind.jm"!');    
      filenameinput.value = "";
   } else {
      thisfilename = thisfilename + ".jm";
      var j = -1, found = false;
      while ((found === false) && (j < mhmind_maps.length - 1)) {
        j += 1;
        if (thisfilename === mhmind_maps[j].docfilename) {
          found = true;
          alert("File name already exists!");
        }
      }
      if (found === false) {
        docfilename.value = thisfilename;
        filenameinput.value = "";
        filenamediv.style.display = "none";
        if (nametype.value === "newfunc") {
          savemap();
        } else if (nametype.value === "modifyfunc") {
          nametype.value = "newfunc";
          mhmind_maps[presentmap_id].docfilename = docfilename.value;
          savemap();
        } else if (nametype.value === "copyfunc") {
          nametype.value = "newfunc";
          duplicatemap();
        } else {
          alert("Error, illegal submit name type!");
          nametype.value = "newfunc";
        }
      }
   }
});


function filenameform() {
  filenamediv.style.display = "block";
  return;
}

var newfilebtn = document.getElementById("newfilebtn");
newfilebtn.addEventListener("click", function(e) {
  e.preventDefault();
  if (presentmap_id !== -1) {
    resetmapbtn.click();
  }
  filenameform();
});


var duplicatebtn = document.getElementById("duplicatebtn");
duplicatebtn.addEventListener("click", function(e) {
  e.preventDefault();
  if (presentmap_id === -1) {
    alert("May not duplicate unsaved file!");
  }
  savemap();
  nametype.value = "copyfunc";
  filenameform();
});


var openSlider = document.getElementById("openSliderbtn"),
    slide = document.querySelector(".slide"),
    closeSlider = document.getElementById("closeSliderbtn"),
    mapslistingdiv = document.getElementById("mapslistingdiv");

openSlider.addEventListener("click",  function () {
    mapslistingdiv.style.zIndex = 2000;
    slide.classList.remove("slide-up");
});

closeSlider.addEventListener("click", function () {
    slide.classList.add("slide-up");
    setTimeout(function () {
        mapslistingdiv.style.zIndex = -2000;
    }, 800);
});


function open_export_import() {
    "use strict";
    document.getElementById("export_import").style.display = "block";
}

function close_export_import() {
    "use strict";
    document.getElementById("export_import").style.display = "none";
}


function close_info() {
    "use strict";
    document.getElementById("info").style.display = "none";
}

function showinfo() {
    "use strict";
    if (document.getElementById("info").style.display === 'block') {
        document.getElementById("info").style.display = 'none';
    } else {
        document.getElementById("info").style.display = 'block';
    }
}


window.onresize = function() {
    setlayout();
}


function setupMap() {
    var thesemhminds1 = localStorage.getItem("thesemhminds1");
    if ((thesemhminds1 !== null) && (thesemhminds1 !== "") && (thesemhminds1 !== undefined)) {
        thesemhminds1 = JSON.parse(thesemhminds1);
        mhmind_maps.length = 0;
        mhmind_maps = thesemhminds1;
        update_maplisting(null);
    }
    default_map();
}

open_empty();
setlayout();
setupMap();


function saveMHMind() {
    "use strict";
    if (presentmap_id !== -1) {
        savemap();
    }
    localStorage.removeItem("thesemhminds1");
    var thesemhminds1 = JSON.stringify(mhmind_maps);
    //    localStorage.setItem("thesemhminds1", thesemhminds1);
    $.ajax({ url: '/mindmap/mindmap/save.js?content='+thesemhminds1 })
}
