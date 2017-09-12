

var openSlider = document.getElementById("openSliderbtn"),
    slide = document.querySelector(".slide"),
    closeSlider = document.getElementById("closeSliderbtn"),
    svglistingdiv = document.getElementById("svglistingdiv");

openSlider.addEventListener("click", function () {
    svglistingdiv.style.zIndex = 2000;
    slide.classList.remove("slide-up");
    document.getElementById("searchfiles").value = "";
    var searchbtn = document.getElementById("searchbtn");
    searchbtn.click();
});

closeSlider.addEventListener("click", function () {
    document.getElementById("searchfiles").value = "";
    slide.classList.add("slide-up");
    setTimeout(function () {
        svglistingdiv.style.zIndex = -2000;
    }, 800);
});



var filetitle = document.getElementById("filetitle");
filetitle.addEventListener("change", function () {
    var newfiletitle = filetitle.value.trim();
    filetitle.value = newfiletitle;
    if (newfiletitle !== "") {
        window.document.title = "MH SVG Edit: " + newfiletitle;
    } else {
        window.document.title = "MH SVG Edit";        
    }
});
