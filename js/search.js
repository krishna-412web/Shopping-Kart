$(document).ready(function(){
    $("#searchSubmit").click(function(){
        let searchstring = $("#searchString").val();
        window.location.href =`homepage.cfm?search=1&string=${searchstring}`;
    });
});