$("document").ready(function () {
  var slide = document.querySelector(".slide"),
      docslistingdiv = document.getElementById("docslistingdiv");
  $("#openSliderbtn").click(function () {
    docslistingdiv.style.zIndex = 10000000;
    slide.classList.remove("slide-up");
    var hideshow = $("#filenameslist p");
    hideshow[0].style.display = "none";
    var currentIndex, n, editbtns = document.querySelectorAll("#filenameslist .editbtn");
    for (n = 1; n < editbtns.length; n+=1) {
      editbtns[n].addEventListener("click", function () {
        currentIndex = $(this).closest("p").index();
        document.getElementById("changekanban").value = currentIndex;
        $("#changekanban").change();
      });
    }
 });
  $("#closeSliderbtn").click(function () {
    slide.classList.add("slide-up");
    setTimeout(function () {
      docslistingdiv.style.zIndex = -2000;
    }, 800);
    
  });
  function searchFiles(searchfor) {
    var i, showfiles = $("#filenameslist p");
    for (i = 1; i < showfiles.length; i+=1) {
      if (showfiles[i].innerHTML.toLowerCase().indexOf(searchfor) > -1) {
        showfiles[i].style.display = "block";
      } else {
        showfiles[i].style.display = "none";                
      }
    }
  }
  $("#searchbtn").click(function () {
    var searchfor = $("#searchinput").val().trim().toLowerCase();
    if (searchfor !== "") {
      searchFiles(searchfor);
    }
  });
  $("#searchinput").change(function () {
    if ($("#searchinput").val().trim() === "") {
      var i, showfiles = $("#filenameslist p");
      for (i = 1; i < showfiles.length; i+=1) {
        showfiles[i].style.display = "block";
      }
    }
  }); 
});
