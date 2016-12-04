// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery
//= require jquery_ujs
//   JQUERY VALIDATE -->
//=  require plugin/jquery-validate/jquery.validate.min.js
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require cocoon
//= require dataTables/jquery.dataTables
//= require plugin/datatables/dataTables.colVis.min.js
//= require plugin/datatables/dataTables.tableTools.min.js
//= require plugin/datatables/dataTables.bootstrap.min.js
//= require plugin/datatable-responsive/datatables.responsive.min.js
//= require buttons.colVis.min
//= require dataTables.buttons.min

//= require ckeditor-jquery
//= require plugin/select2/select2.min.js
//= require clockpicker.js
//= require cable
//= require turbolinks

function handle_menu(id)
{
    $('#ul_'+id).on('click', function(){
        eraseCookie('profile_menu');
        eraseCookie('case_menu');
        if(readCookie(id+'_menu')){
            eraseCookie(id+'_menu');
        }
        else
        {
            createCookie(id+'_menu', true, 7);
        }
    });

    if(readCookie(id+'_menu'))
    {
        $('#'+id+'_menu').addClass('display_block');
    }

}

function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function eraseCookie(name) {
    createCookie(name,"",-1);
}

/*
 * CHAT
 */

$.filter_input = $('#filter-chat-list');
$.chat_users_container = $('#chat-container > .chat-list-body')
$.chat_users = $('#chat-users')
$.chat_list_btn = $('#chat-container > .chat-list-open-close');
$.chat_body = $('#chat-body');

/*
 * LIST FILTER (CHAT)
 */

// custom css expression for a case-insensitive contains()
jQuery.expr[':'].Contains = function(a, i, m) {
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};

function listFilter(list) {// header is any element, list is an unordered list
    // create and add the filter form to the header

    $.filter_input.change(function() {
        var filter = $(this).val();
        if (filter) {
            // this finds all links in a list that contain the input,
            // and hide the ones not containing the input while showing the ones that do
            $.chat_users.find("a:not(:Contains(" + filter + "))").parent().slideUp();
            $.chat_users.find("a:Contains(" + filter + ")").parent().slideDown();
        } else {
            $.chat_users.find("li").slideDown();
        }
        return false;
    }).keyup(function() {
        // fire the above change event after every letter
        $(this).change();

    });

}

var named_function = function(){
    $('a').attr('data-turbolinks', "false");

    // initialize persistent state
    $('.date_picker').datepicker({ dateFormat: 'dd-mm-yy' });

    $( ".use_select2" ).select2({
        theme: "bootstrap"
    });
    $('.clockpicker').clockpicker({autoclose:true});

    handle_menu('admin');
    handle_menu('case');
    handle_menu('profile');


    $(".user_autocomplete").autocomplete({
        //source: availableTags

        source: function (request, response) {
            $.ajax({
                url: "/users.json?q="+ request.term,
                dataType: "json",
                success: function (data) {
                    d = data;
                    res = [];
                    for (i = 0; i < d.length; i++) {
                        value = d[i]['login'];
                        res.push({label: value, value: value, id: d[i]['id']})
                    }
                    response(res)
                }
            });
        },
        minLength: 2,
        select: function (event, ui) {
            $(this).next().val(ui.item.id)
            $(this).next().next().val('User')
        }
    });

    console.log("It works on each visit!")
};

$( document ).on('turbolinks:load', named_function);
