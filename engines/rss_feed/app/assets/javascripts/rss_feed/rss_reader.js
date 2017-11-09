var rssReaderFeeds = [];

function findFeeds(datefrom, dateto, searchinfo) {
    try{


        var thesefeeds = document.getElementsByTagName("li");
        if (thesefeeds.length > 0) {
            var j, title, thesetitles = document.querySelectorAll(".title");
            var feeddate, from_date, to_date, thesedates = document.querySelectorAll(".date");
            var rssall, theserssall = document.querySelectorAll(".rssall");
            var datefilter, wordfilter, includefeed;
            if ((datefrom !== null) || (dateto !== thisdate)) {
                datefilter = true;
            } else {
                datefilter = false;
            }
            if (searchinfo !== null) {
                wordfilter = true;
            } else {
                wordfilter = false;
            }
            for (j = 0; j < thesefeeds.length; j+=1) {
                includefeed = true;
                if (datefilter === true) {
                    feeddate = new Date(thesedates[j].innerHTML);
                    feeddate.setHours(0,0,0,0);
                    from_date = new Date(datefrom);
                    to_date = new Date(dateto);
                    if ((feeddate < from_date) || (feeddate > to_date)) {
                        includefeed = false;
                    }
                }
                if (includefeed === true) {
                    if (wordfilter === true) {
                        title = thesetitles[j].innerHTML.toLowerCase();
                        rssall = theserssall[j].innerHTML.toLowerCase();
                        if ((title.indexOf(searchinfo) > -1) || (rssall.indexOf(searchinfo) > -1)) {
                            $(thesefeeds[j]).addClass("lishow");
                            $(thesefeeds[j]).removeClass("lihide");
                        } else {
                            $(thesefeeds[j]).addClass("lihide");
                            $(thesefeeds[j]).removeClass("lishow");
                        }
                    } else {
                        $(thesefeeds[j]).addClass("lishow");
                        $(thesefeeds[j]).removeClass("lihide");
                    }
                } else {
                    $(thesefeeds[j]).addClass("lihide");
                    $(thesefeeds[j]).removeClass("lishow");
                }
            }
        }
    }
    catch(err){

    }
}


function showFeed(datefrom, dateto, searchinfo) {

    var i, thissite, thisname;

    for (i = 0; i < rssReaderFeeds.length; i += 1) {
        if (rssReaderFeeds[i].included === true) {
            thisname = rssReaderFeeds[i].name;
            thissite = rssReaderFeeds[i].site;
            //    $("#rss-feeds").rss(thissite,{limit: null, ssl: false, entryTemplate: '<li class="lishow"><a href="{url}" target="_blank"><span class="title">{title}</span></a><br/><span class="rss_small">' + thisname + '<br/><span class="date">{date}</span></span><br/><button type="button" class="morebtn">&plus;</button><span class="rssshort">{shortBody}</span><br/><span class="rssall">{bodyPlain}</span><br /></li>', dateFormat: 'MMMM D, YYYY, h:mm:ss A'})
            $("#rss-feeds").rss(thissite, {
                limit: null,
                ssl: false,
                entryTemplate: '<li class="lishow">' +
                '<a href="{url}" target="_blank">' +
                '<span class="title">{title}</span></a><br/><span class="rss_small">' + thisname + '<br/>' +
                '<span class="date">{date}</span></span><br/><span class="rssall">{bodyPlain}</span>' +
                '</div>  <div class="link"> <a class="read_more" href="#" onclick="changeheight(this); return false;" >Read more</a> </div>' +
                '<br /></li>',
                dateFormat: 'MMMM D, YYYY, h:mm:ss A'
            })
        }
    }
    findFeeds(datefrom, dateto, searchinfo);


    read_mores = document.querySelectorAll('.read_more')
    for(k= 0; k < read_mores.length; k++){
        rm = $(read_mores[k])
        rm.attr('id', "read_more_"+k )
        rm.attr('href', "javascript:changeheight("+k+")" )
    }

}


$("#searchbtn").click(function () {

    var searchinput = $("#searchinput").val().toLowerCase().trim();
    var searchfromdate = $("#searchfromdate").val();
    var searchtodate = $("#searchtodate").val();
    if (searchinput === "") {
        findFeeds(searchfromdate, searchtodate, null);
    } else {
        findFeeds(searchfromdate, searchtodate, searchinput);
    }
});


$("#searchfromdate").change(function () {

    var searchfromdate = $("#searchfromdate").val();
    var testdate = new Date(searchfromdate);
    var okdate = (testdate instanceof Date && !isNaN(testdate.valueOf()));
    if (okdate === false) {
        $( "#searchfromdate" ).datepicker("setDate", null);
    }
});

$("#searchtodate").change(function () {

    var searchtodate = $("#searchtodate").val();
    var testdate = new Date(searchtodate);
    var okdate = (testdate instanceof Date && !isNaN(testdate.valueOf()));
    if ((searchtodate === null) || (okdate === false)) {
        $( "#searchtodate" ).datepicker("setDate", thisdate);
    }
});

$("#resetsearch").click(function () {

    $( "#searchfromdate" ).datepicker("setDate", null);
    $( "#searchtodate" ).datepicker("setDate", thisdate);
    $("#searchinput").val("");
    var j, thesefeeds = document.getElementsByTagName("li");
    if (thesefeeds.length > 0) {
        for (j = 0; j < thesefeeds.length; j+=1) {
            $(thesefeeds[j]).addClass("lishow");
            $(thesefeeds[j]).removeClass("lihide");
        }
    }
});


$("#instructions_btn").click(function () {

    $("#instructions_div").show();
});

$("#closeinstr_btn").click(function (e) {

    e.preventDefault();
    $("#instructions_div").hide();
});

$("#showform_btn").click(function () {

    $("#feeds_form_div").show();
    $("#reset_btn").click();
});



// FEEDS FORM ******************************************************************************/*

function resetInput() {

    $("#feeds_form_div").hide();
    $("#feeds_form").reset();
}


$("#update_feeds").click(function (e) {

    e.preventDefault();
    var el = $(this);
    el.prop("disabled", true);
    $("#rss-feeds").empty();
    var i, thisid, btnimg, feedid = document.querySelectorAll(".feedid");
    for (i = 0; i < feedid.length; i+=1) {
        btnimg = document.getElementById("togglechkbtn" + i);
        if (btnimg.src.indexOf("/rss_feed/glyphicons-154-unchecked.png") > -1) {
            rssReaderFeeds[i].included = false;
        } else {
            rssReaderFeeds[i].included = true;
        }
    }
    var searchfromdate = $("#searchfromdate").val();
    var searchtodate = $("#searchtodate").val();
    var searchinput = $("#searchinput").val().toLowerCase().trim();
    if (searchinput === "") {
        showFeed(searchfromdate, searchtodate, null);
    } else {
        showFeed(searchfromdate, searchtodate, searchinput);
    }
    setTimeout(function (){
        el.prop("disabled", false);
    }, 3000);
});


$("#submit_feed").click(function (e) {

    e.preventDefault();
    var i = 0, found = false, thisfeed = {};
    var thisid = $("#feed_id").val().trim();
    var thisname = $("#feed_name").val().trim();
    var thissite = $("#feed_site").val().trim();
    var thisinclude = $("#feed_include").is(":checked");
    if ((thisname !== "") && (thissite !== "")) {
        if (thisid === "") {
            if (rssReaderFeeds.length > 0) {
                thisid = rssReaderFeeds[rssReaderFeeds.length - 1].id + 1;
            } else {
                thisid = "1";
            }
            thisfeed = {"id": thisid, "name": thisname, "site": thissite, "included": true};
            rssReaderFeeds.push(thisfeed);
        } else {
            while ((found === false) && (i < rssReaderFeeds.length)) {
                if (rssReaderFeeds[i].id === thisid) {
                    found = true;
                    thisfeed = {"id": thisid, "name": thisname, "site": thissite, "included": thisinclude};
                    rssReaderFeeds[i] = thisfeed;
                } else {
                    i+=1;
                }
            }
            if (found === false) {
                alert("Error, feed not found!");
                return;
            }
        }
        showRssList();
        $("#feeds_form_div").hide();
        $("#update_feeds").click();
    } else {
        alert("Feed name and url must be filled in!");
    }
});

$("#closeform_btn").click(function (e) {

    e.preventDefault();
    resetInput();
});



// FEEDS LISTING FORM ******************************************************************************

function setCheckedToggle() {

    var i, includedbtns = document.querySelectorAll(".includeck");
    for (i = 0; i < includedbtns.length; i+=1) {
        includedbtns[i].addEventListener("click", function () {
            var thisid = this.id.slice(12), btnimg = document.getElementById("togglechkbtn" + thisid);
            if (btnimg.src.indexOf("/rss_feed/glyphicons-154-unchecked.png") > -1) {
                btnimg.src = "/rss_feed/glyphicons-199-ok-circle.png";
                $("#include_feed" + thisid).addClass("includedyes");
                $("#include_feed" + thisid).removeClass("includedno");
            } else {
                btnimg.src = "/rss_feed/glyphicons-154-unchecked.png";
                $("#include_feed" + thisid).addClass("includedno");
                $("#include_feed" + thisid).removeClass("includedyes");
            }
        });
    }
}

var openSlider = document.getElementById("openSliderbtn"),
    slide = document.querySelector(".slide"),
    closeSlider = document.getElementById("closeSliderbtn"),
    feedslistingdiv = document.getElementById("feedslistingdiv");

openSlider.addEventListener("click",  function () {
    feedslistingdiv.style.zIndex = 2000;
    slide.classList.remove("slide-up");
    setCheckedToggle();
});

closeSlider.addEventListener("click", function () {
    slide.classList.add("slide-up");
    setTimeout(function () {
        feedslistingdiv.style.zIndex = -2000;
    }, 800);
});


$("#clear_feeds").click(function () {

    var i, feeds = document.querySelectorAll(".includedimg");
    for (i = 0; i < feeds.length; i+=1) {
        feeds[i].src = "/rss_feed/glyphicons-154-unchecked.png";
    }
});

$("#all_feeds").click(function () {

    var i, feeds = document.querySelectorAll(".includedimg");
    for (i = 0; i < feeds.length; i+=1) {
        feeds[i].src = "/rss_feed/glyphicons-199-ok-circle.png";
    }
});

$("body").on("click", ".editbtn", function (e) {

    e.preventDefault();
    var f = this.id.slice(9);
    $("#feed_id").val(document.getElementById("feedid" + f).innerHTML);
    $("#feed_name").val(document.getElementById("feedname" + f).innerHTML);
    $("#feed_site").val(document.getElementById("feedsite" + f).innerHTML);
    if ($("#include_feed" + f).hasClass("includeck includedyes") === true) {
        $("#feed_include").prop("checked", true);
    } else {
        $("#feed_include").prop("checked", false);
    }
    $("#feeds_form_div").show();
});


$("body").on("click", ".deletebtn", function (e) {

    e.preventDefault();
    var checkstr = window.confirm("Sure you want to delete this feed?");
    if (checkstr === false) {
        return false;
    }
    var f = this.id.slice(11);
    var thisid = document.getElementById("feedid" + f).innerHTML;
    var i = 0, found = false;
    while ((found === false) && (i < rssReaderFeeds.length)) {
        if (rssReaderFeeds[i].id === thisid) {
            found = true;
        } else {
            i+=1;
        }
    }
    if (found === true) {
        rssReaderFeeds.splice(i, 1);
    } else {
        alert("Error, feed not found!");
        return;
    }
    showRssList();
    $("#update_feeds").click();
});

$("body").on("click", ".morebtn", function () {

    if ($(this).closest("li").find(".rssshort").css("display") === "block") {
        $(this).closest("li").find(".rssshort").hide();
        $(this).closest("li").find(".rssall").show();
    } else {
        $(this).closest("li").find(".rssshort").show();
        $(this).closest("li").find(".rssall").hide();
    }
});


var theserssfeeds;

function saveFeeds() {
    theserssfeeds = JSON.stringify(rssReaderFeeds);
    $.ajax({ url: '/rss/rss/save.js?content='+theserssfeeds})
    alert('Saved')
}

function showRssList() {

    $("#feedslisting").empty();
    var i, newfeed;
    for (i = 0; i < rssReaderFeeds.length; i+=1) {
        if (rssReaderFeeds[i].included === true) {
            newfeed = '<p class="feedlist"><button type="button" id="delete_feed' + i + '" class="deletebtn"><i class="fa fa-times"></i></button><button type="button" id="edit_feed' + i + '" class="editbtn"><i class="fa fa-pencil-square-o"></i></button><span id="feedid' + i + '" class="feedid" hidden>' + rssReaderFeeds[i].id + '</span><button id="include_feed' + i + '" name="include_feed' + i + '" class="includeck includedyes"><img class="includedimg" id="togglechkbtn' + i + '" src="/rss_feed/glyphicons-199-ok-circle.png"></button><span id="feedname' + i + '">' + rssReaderFeeds[i].name + '</span><span id="feedsite' + i + '" hidden>' + rssReaderFeeds[i].site + '</span></p>';
        } else {
            newfeed = '<p class="feedlist"><button type="button" id="delete_feed' + i + '" class="deletebtn"><i class="fa fa-times"></i></button><button type="button" id="edit_feed' + i + '" class="editbtn"><i class="fa fa-pencil-square-o"></i></button><span id="feedid' + i + '" class="feedid" hidden>' + rssReaderFeeds[i].id + '</span><button id="include_feed' + i + '" name="include_feed' + i + '" class="includeck includedno"><img class="includedimg" id="togglechkbtn' + i + '" src="/rss_feed/glyphicons-154-unchecked.png"></button><span id="feedname' + i + '">' + rssReaderFeeds[i].name + '</span><span id="feedsite' + i + '" hidden>' + rssReaderFeeds[i].site + '</span></p>';
        }
        $("#feedslisting").append(newfeed);
    }
}

$('#saveform_btn').click(function(){
    saveFeeds()
})
$(document).ready(function () {
    $( "#searchfromdate" ).datepicker("setDate", null);
    $( "#searchtodate" ).datepicker("setDate", thisdate);
    $("#searchinput").val("");
    theserssfeeds = localStorage.getItem("theserssfeeds");
    if (theserssfeeds !== null) {
        rssReaderFeeds = JSON.parse(theserssfeeds);
    } else {
        rssReaderFeeds = [];
    }
    showRssList();
    $("#update_feeds").click();
});
