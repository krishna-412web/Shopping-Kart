$(document).ready(function(){
    $("#searchSubmit").click(function(){
        let searchstring = $("#searchString").val();
        window.location.href =`homepage.cfm?search=1&string=${searchstring}`;
    });
    $("#filterForm").submit(function (event) {
        event.preventDefault();
        var min = $("#min").val();
        var max = $("#max").val();
        let url = new URL(window.location.href);
    
        url.searchParams.delete('range');
        url.searchParams.delete('min');
        url.searchParams.delete('max');
    
        url.searchParams.set('range', '1');
        url.searchParams.set('min', min);
        url.searchParams.set('max', max);
    
        window.location.href = url.toString();
    });
});