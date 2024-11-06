$(document).ready(() => {
    $(document).on('click', '[data-bs-toggle="modal"]', function() {
        var targetModal = $(this).data('bs-target');
        var button = $(this);
        var buttonClass = button.attr('class');
        var buttonid = button.attr('id');  

        if (targetModal === '#addAddress') {
            if (buttonClass.includes('add')) {
                $("#addressForm")[0].reset();
                $('#addressForm input[type="hidden"]').remove();
                $("#addressHeading").text("CREATE ADDRESS");
            } else if (buttonClass.includes('edit')) {
                $("#addressForm")[0].reset();
                $('#addressForm input[type="hidden"]').remove();
                $("#addressHeading").text("EDIT ADDRESS");
                let j = $(this).closest('tr').attr('id');
                $.ajax({
                    url: "../components/shoppingkart.cfc?method=listAddress",
                    type: "GET",
                    data: { "addressid": parseInt(buttonid) },
                    success: function(data) {
                        const obj = JSON.parse(data);
                        let address1 = obj.RESULTSET;
                        $("#name").val(address1[0].name);
                        $("#phone").val(address1[0].phoneno);
                        $("#houseName").val(address1[0].housename);
                        $("#street").val(address1[0].street);
                        $("#city").val(address1[0].city);
                        $("#state").val(address1[0].state);
                        $("#pincode").val(address1[0].pincode);
                        $('<input>', { type: 'hidden', name: 'addressid', id: 'addressid' }).appendTo("#addressForm").val(parseInt(buttonid));
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching category:", error);
                    }
                });
            }
        }
    }); 
});