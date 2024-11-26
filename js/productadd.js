$(document).ready(function(){
    $("button[data-bs-type]").click(function() {
        var actionType = $(this).data("bs-type");
        var $cartrow = $("#quantity").val();
        var currentQuantity = parseInt($cartrow); 
        if (actionType === "increase") {
            currentQuantity += 1;
            $("#quantity").val(currentQuantity);
            let price = $("#price").text();
            let tax = $("#tax").text();
            console.log(tax);
            let totalprice = (price*currentQuantity)+((price*currentQuantity*tax)/100);
            $("#finalprice").text(`Final Price: ${totalprice}`);
        } else if (actionType === "decrease") {
            if (currentQuantity > 1) { 
                currentQuantity -= 1;
                $("#quantity").val(currentQuantity);
                let price = $("#price").text();
                let tax = $("#tax").text();
                let totalprice = (price*currentQuantity)+((price*currentQuantity*tax)/100);
                $("#finalprice").text(`Final Price: ${totalprice}`);    
            }
        } 
    });
    $('#paymentform').submit(function() {
        // Check if the submit button clicked has the name 'paymentproduct'
        if ($('#paymentSubmit').attr('name') === 'paymentproduct') {
            // Set the value of the hidden input 'product_quantity'
            let quantity = $("#quantity").val();
            console.log(quantity);
            $('#productquantity').val(quantity); // Set the desired quantity here
        }
    });
})
