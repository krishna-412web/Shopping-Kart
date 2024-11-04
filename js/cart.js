$("#addCart").click(function(event){
        event.preventDefault(); // Prevent the default button action if it's a link
        let url=window.location.href;
        url = url + "&add=1"
        window.location.href = url;
});
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
    } else if (actionType === "delete") {
            var requestData1 = {
            cartid: $row
            };
            $.ajax({
                url: '../components/shoppingkart.cfc?method=deleteCart', 
                method: 'POST',
                data: requestData1,
                success: function(response) {
                    // Assuming the response indicates success, redirect to cart.cfm
                    //$rowSelected.remove();
                    //alert("*removed item from cart"); 
                    window.location.href="cart.cfm";
                },
                error: function(xhr, status, error) {
                    // Handle errors if needed
                    console.error("Error updating quantity: " + error);
                }
            }); // Exit the function to prevent further processing
    }

    // Update the displayed quantity
    

    // Prepare data for AJAX request
    /*var requestData = {
        productId: productId,
        quantity: currentQuantity
    };

    // Call AJAX function to update quantity
    $.ajax({
        url: 'updateQuantity.cfm', // URL of your ColdFusion script to handle the update
        method: 'POST',
        data: requestData,
        success: function(response) {
            // Assuming the response indicates success, redirect to cart.cfm
            window.location.href = 'cart.cfm'; 
        },
        error: function(xhr, status, error) {
            // Handle errors if needed
            console.error("Error updating quantity: " + error);
        }
    });*/
});