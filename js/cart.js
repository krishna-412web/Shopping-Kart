$(document).ready(function() {
    var state;
    $("#addCart").click(function(event){
        event.preventDefault(); // Prevent the default button action if it's a link
        let path = window.location.pathname; // "/product/B3ACCAFA118981EA3EE1186244FE2458"
        let productHash = path.substring(path.lastIndexOf("/") + 1);
        let url = `/productpage.cfm?pro=${productHash}&add=1`;
        window.location.href = url;
    });
    $("button[data-bs-type]").click(function() {
        var actionType = $(this).data("bs-type");
        var $rowSelected = $(this).parent().parent(); 
        var $row = $(this).parent().parent().attr("class").trim();
        var $firstSpan = $("." + $row).find("span").first(); 
        var $cartrow = $firstSpan.html();
        var currentQuantity = parseInt($cartrow); 
        if (actionType === "increase") {
            currentQuantity += 1;
            var requestData = {
            productid: $row,
            mode: 1
            };
            $.ajax({
                url: '../components/shoppingkart.cfc?method=updateCart', 
                method: 'POST',
                data: requestData
            })
            .done(function(response) {
                        var result = JSON.parse(response);
                        var priceSelect = `.${requestData.productid} .price`;
                        var taxSelect = `.${requestData.productid} .tax`;
                        var totalSelect =`#totalPrice`;
                        $(priceSelect).text(result.cartitems[0].productprice);
                        $(taxSelect).text(result.cartitems[0].producttax);
                        $(totalSelect).text(result.amount);
                        $firstSpan.html(currentQuantity);
            })
            .fail(function(xhr, status, error) {
                console.error("Error updating quantity: " + error);
            }); 
        } 
        else if (actionType === "decrease") {
            if (currentQuantity > 1) { 
                currentQuantity -= 1;
                var requestData = {
                    productid: $row,
                    mode: 0
                    };
                    $.ajax({
                        url: '../components/shoppingkart.cfc?method=updateCart', 
                        method: 'POST',
                        data: requestData
                    })
                    .done(function(response) {
                                var result = JSON.parse(response);
                                var priceSelect = `.${requestData.productid} .price`;
                                var taxSelect = `.${requestData.productid} .tax`;
                                var totalSelect =`#totalPrice`;
                                $(priceSelect).text(result.cartitems[0].productprice);
                                $(taxSelect).text(result.cartitems[0].producttax);
                                $(totalSelect).text(result.amount);
                                $firstSpan.html(currentQuantity);
                    })
                    .fail(function(xhr, status, error) {
                        console.error("Error updating quantity: " + error);
                    }); 
            }
            else if (currentQuantity === 1) {
                var requestData1 = {
                    productid: $row
                };
                var delid = requestData1.productid;
                var text = "Do you wish to delete the item?";
                if (delid && typeof delid === "string" && delid.length > 0) {
                    $("#delInput").val(delid);                
                    $("#delText").text(text);
                    $("#deleteSubmit").attr('data-bs-type', 'delete');
                    $('#delModal').modal('show');
                }
            }
            
        } 
        else if (actionType === "delete") {
            /*var requestData1 = {
            productid: $row
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
            }); // Exit the function to prevent further processing*/
            var delid = $(this).data("bs-id");
            var text = "Do you wish to delete the item?";
            if (delid && typeof delid === "string" && delid.length > 0) {
                $("#delInput").val(delid);                
                $("#delText").text(text);
                $("#deleteSubmit").attr('data-bs-type', 'delete');
                $('#delModal').modal('show');
            }
        } 
        else if (actionType === "empty") {
            var delprompt = "Do you wish to empty the cart?";
            $("#delInput").val('');
            $("#delText").text(delprompt);
            $("#deleteSubmit").attr('data-bs-type', 'empty');
            $('#delModal').modal('show');
        }
    });
    $('#delForm').submit(function(event) {
        $('#delModal').modal('hide');
        var submitType = $("#deleteSubmit").data("bs-type");
        if(submitType === 'empty')
        {
            event.preventDefault();
            window.location.href="cart.cfm?emptycart=1";
        }
    });
});
