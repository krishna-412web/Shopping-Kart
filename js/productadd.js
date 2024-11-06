$("button[data-bs-type]").click(function() {
    var actionType = $(this).data("bs-type");
    var $rowSelected = $(this).parent().parent(); 
    var $row = $(this).parent().parent().attr("class");
    var $firstSpan = $("." + $row).find("span").first(); 
    var $cartrow = $firstSpan.html();
    var currentQuantity = parseInt($cartrow); 
    if (actionType === "increase") {
        currentQuantity += 1;
        var requestData = {
        cartid: $row,
        mode: 1
        };
        $.ajax({
            url: '../components/shoppingkart.cfc?method=updateCart', 
            method: 'POST',
            data: requestData,
            success: function(response) {
                // Assuming the response indicates success, redirect to cart.cfm
                window.location.href="cart.cfm";
                $firstSpan.html(currentQuantity); 
            },
            error: function(xhr, status, error) {
                // Handle errors if needed
                console.error("Error updating quantity: " + error);
            }
        }); 
    } else if (actionType === "decrease") {
        if (currentQuantity > 1) { 
            currentQuantity -= 1;
            var requestData = {
                cartid: $row,
                mode: 0
                };
                $.ajax({
                    url: '../components/shoppingkart.cfc?method=updateCart', 
                    method: 'POST',
                    data: requestData,
                    success: function(response) {
                        // Assuming the response indicates success, redirect to cart.cfm
                        window.location.href="cart.cfm";
                        $firstSpan.html(currentQuantity); 
                    },
                    error: function(xhr, status, error) {
                        // Handle errors if needed
                        console.error("Error updating quantity: " + error);
                    }
                }); 

        }
    } 
});