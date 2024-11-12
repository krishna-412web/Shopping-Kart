$(document).ready(() => {
    var obj;
    var categories;
    var subcategories;
    var products;
    var prevHobbieList;
    var logId = "";

    $.ajax({
        url: '../components/shoppingkart.cfc?method=listCategory',
        type: 'GET',
        success: function(data) {    
            obj = JSON.parse(data);
            categories = obj.RESULTSET;
            let tabContent = "";

            if (categories.length === 0) {
                alert('Add Categories');
            } else {
                for (let i = 0; i < categories.length; i++) {    
                    tabContent += `<tr id="${categories[i].categoryid}">
                        <td>${i + 1}</td>
                        <td class="menu">${categories[i].categoryname}</td>
                        <td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#CategoryModal">Edit</button></td>
                        <td><button type="button" class="btn btn-danger btn-sm w-100 delete category" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>
                    </tr>\n`;                     
                }
                $("#categoryDisplay").html(tabContent);
            }
        }
    });

    $.ajax({
        url: '../components/shoppingkart.cfc?method=listSubCategory',
        type: 'GET',
        success: function(data) {    
            obj = JSON.parse(data);
            subcategories = obj.RESULTSET;
            let tabContent = "";

            if (subcategories.length === 0) {
                alert('Add subcategories');
            } else {
                for (let i = 0; i < subcategories.length; i++) {    
                    tabContent += `<tr id="${subcategories[i].subcategoryid}">
                        <td>${i + 1}</td>
                        <td class="menu">${subcategories[i].subcategoryname}</td>
                        <td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#subCategoryModal">Edit</button></td>
                        <td><button type="button" class="btn btn-danger btn-sm w-100 delete sub" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>
                    </tr>\n`;                     
                }
                $("#subCategoryDisplay").html(tabContent);
            }
        }
    });

    $.ajax({
        url: '../components/shoppingkart.cfc?method=listProducts',
        type: 'GET',
        success: function(data) {    
            obj = JSON.parse(data);
            products = obj.RESULTSET;
            let tabContent = "";

            if (products.length === 0) {
                alert('Add products');
            } else {
                for (let i = 0; i < products.length; i++) {    
                    tabContent += `<tr id="${products[i].productid}">
                        <td>${i + 1}</td>
                        <td class="menu">${products[i].productname}</td>
                        <td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#productModal">Edit</button></td>
                        <td><button type="button" class="btn btn-danger btn-sm w-100 delete product" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>
                    </tr>\n`;                     
                }
                $("#productDisplay").html(tabContent);
            }
        }
    });

    $(document).on('click', '[data-bs-toggle="modal"]', function() {
        var targetModal = $(this).data('bs-target');
        var button = $(this);
        var buttonClass = button.attr('class'); 

        if (targetModal === '#CategoryModal') {
            if (buttonClass.includes('add')) {
                $("#CategoryForm")[0].reset();
                $('#CategoryForm input[type="hidden"]').remove();
                $("#categoryHeading").text("CREATE CATEGORY");
                $("#categorySubmit").text("Add Category");
            } else if (buttonClass.includes('edit')) {
                $("#CategoryForm")[0].reset();
                $('#CategoryForm input[type="hidden"]').remove();
                $("#categoryHeading").text("EDIT CATEGORY");
                let j = $(this).closest('tr').attr('id');
                $.ajax({
                    url: "../components/shoppingkart.cfc?method=listCategory",
                    type: "GET",
                    data: { "categoryid": j },
                    success: function(data) {
                        const obj = JSON.parse(data);
                        let categories1 = obj.RESULTSET;
                        $("#categorySubmit").text("Edit Category");
                        $("#categoryName").val(categories1[0].categoryname);
                        $('<input>', { type: 'hidden', name: 'categoryId', id: 'categoryId' }).appendTo("#CategoryForm").val(j);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching category:", error);
                    }
                });
            }
        } else if (targetModal === '#subCategoryModal') {
            if (buttonClass.includes('add')) {
                $("#subCategoryForm")[0].reset();
                $('#subCategoryForm input[type="hidden"]').remove();
                $("#subCategoryHeading").text("CREATE SUBCATEGORY");
                $("#subCategorySubmit").text("Add Subcategory");
            } else if (buttonClass.includes('edit')) {
                $("#subCategoryForm")[0].reset();
                $('#subCategoryForm input[type="hidden"]').remove();
                let j = $(this).closest('tr').attr('id');
                $.ajax({
                    url: "../components/shoppingkart.cfc?method=listSubCategory",
                    type: "GET",
                    data: { "subcategoryid": j },
                    success: function(data) {
                        const obj = JSON.parse(data);
                        let subcategories1 = obj.RESULTSET;
                        $("#subCategoryHeading").text("EDIT SUBCATEGORY");
                        $("#subCategorySubmit").text("Edit Subcategory");
                        $("#subCategoryName").val(subcategories1[0].subcategoryname);
                        $('<input>', { type: 'hidden', name: 'subcategoryid', id: 'subCategoryId' }).appendTo("#subCategoryForm").val(j);
                        $("#categorySelect").val(subcategories1[0].categoryid);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching subcategory:", error);
                    }
                });
            }
        } else if (targetModal === '#productModal') {
            if (buttonClass.includes('add')) {
                $("#productForm")[0].reset();
                $('#productForm input[type="hidden"]').remove();
                $("#productHeading").text("CREATE PRODUCT");
                $("#productSubmit").text("Add Product");
                $("#productPicture").attr("required", true);
				$("#productCategory").on("change", function() {
				const selectedValue = $(this).val(); // Get the selected value
				if (selectedValue) {
					$.ajax({
					url: "../components/shoppingkart.cfc?method=listSubCategory",
					type: "GET",
					data: { 
						"categoryid": selectedValue // Set selected category ID in the headers
					},
					success: function(data) {
						const obj = JSON.parse(data);
						var subcategories1 = obj.RESULTSET;
						let tabContent = `<option value="" selected></option>`;
				
					if (subcategories1.length != 0) {
						subcategories1.forEach((subcat, index) => {
							tabContent += `<option value="${subcat.subcategoryid}">${subcat.subcategoryname}</option>\n`;
						});
						$("#productSubCategory").html(tabContent);
						}
					else {
						$("#productSubCategory").html(`<option value="" selected></option>`);
					}
					},
					error: function(xhr, status, error) {
						console.error("Error fetching subcategories:", error);
					}
					});
				} else {
					// If no valid category is selected, clear the subcategory display
					$("#productSubCategory").html(`<option value="" selected></option>`);
				}
				});
            } else if (buttonClass.includes('edit')) {
                $("#productForm")[0].reset();
                $('#productForm input[type="hidden"]').remove();
                $("#productPicture").attr("required", false);
                let j = $(this).closest('tr').attr('id');
                $.ajax({
                    url: "../components/shoppingkart.cfc?method=listProducts",
                    type: "GET",
                    data: { "productid": j },
                    success: function(data) {
                        const obj = JSON.parse(data);
                        let products1 = obj.RESULTSET;
                        $("#productSubmit").text("Edit Product");
						$("#productHeading").text("EDIT PRODUCT");
                        $("#productCategory").val(products1[0].categoryid);
                        $("#productName").val(products1[0].productname);
                        $("#productDesc").val(products1[0].productdesc);
                        $("#price").val(products1[0].price);
                        $('<input>', { type: 'hidden', name: 'productid', id: 'productId' }).appendTo("#productForm").val(j);
                        $("#productSubCategory").val(products1[0].subcategoryid);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching product:", error);
                    }
                });
				$("#productCategory").on("change", function() {
					const selectedValue = $(this).val(); // Get the selected value
					if (selectedValue) {
					  $.ajax({
						url: "../components/shoppingkart.cfc?method=listSubCategory",
						type: "GET",
						data: { 
						  "categoryid": selectedValue // Set selected category ID in the headers
						},
						success: function(data) {
						  const obj = JSON.parse(data);
						  var subcategories1 = obj.RESULTSET;
						  let tabContent = `<option value="" selected></option>`;
				  
						if (subcategories1.length != 0) {
							subcategories1.forEach((subcat, index) => {
							  tabContent += `<option value="${subcat.subcategoryid}">${subcat.subcategoryname}</option>\n`;
							});
							$("#productSubCategory").html(tabContent);
						  }
						else {
							$("#productSubCategory").html(`<option value="" selected></option>`);
						}
						},
						error: function(xhr, status, error) {
						  console.error("Error fetching subcategories:", error);
						}
					  });
					} else {
					  // If no valid category is selected, clear the subcategory display
					  $("#productSubCategory").html(`<option value="" selected></option>`);
					}
				  });
            }
        } else if (targetModal === "#delModal") {
            $("#delForm")[0].reset();
            $('#delForm input[type="hidden"]').remove();
            let j = $(this).closest('tr').attr('id');
            $('<input>', { type: 'hidden', name: 'deleteid', id: 'deleteid' }).appendTo("#delForm").val(j);

            if (buttonClass.includes('category')) {
                $('<input>', { type: 'hidden', name: 'section', id: 'section' }).appendTo("#delForm").val("category");
            } else if (buttonClass.includes('sub')) {
                $('<input>', { type: 'hidden', name: 'section', id: 'section' }).appendTo("#delForm").val("subcategory");
            } else if (buttonClass.includes('product')) {
                $('<input>', { type: 'hidden', name: 'section', id: 'section' }).appendTo("#delForm").val("product");
            }
        }
    });
    $("#insertimage").off('click').click(function () {
        $('#imageAdd').append(
            $('<input>').attr({
              type: 'file',
              name: 'images',
              class: 'form-control text-info mt-1',
              accept: 'image/*',
              required: true
            })
        );
    });

	$('#productModal').on('hidden.bs.modal', function () {
		// Refresh the page when the productModal is closed
		location.reload();
	});
});
