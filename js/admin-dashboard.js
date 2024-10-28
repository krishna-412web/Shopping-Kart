$(document).ready(() => {
	
	var obj;
	var categories;
	var subcategories;
	var products;
	var prevHobbieList;
	var logId="";
	$.ajax({
		url: '../components/shoppingkart.cfc?method=listCategory',
		type: 'GET',
		success: function(data) 
		{	
			obj= JSON.parse(data);
			var categories = obj.RESULTSET;
			//console.log(categories);
			let tab="";
			let tabContent="";
			if (obj.DATA == '') 
			{
				alert('Add Categories');
			} 
			else 
			{
				tabContent="";
				let row = ""
				let j = 0;
				for(let i=0;i< categories.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu">${categories[i].categoryname}</td>\n`;
					row +=  `<td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#CategoryModal">Edit</button></td>\n+
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete category" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>\n`;
					tabContent+= `<tr id="${categories[i].categoryid}">`+row+`</tr>\n`;
					row="";							
				}
				$("#categoryDisplay").html(tabContent);
			}
		}
		
	});

	$.ajax({
		url: '../components/shoppingkart.cfc?method=listSubCategory',
		type: 'GET',
		success: function(data) 
		{	
			obj= JSON.parse(data);
			var subcategories = obj.RESULTSET;
			console.log(subcategories);
			let tab="";
			let tabContent="";
			if (obj.DATA == '') 
			{
				alert('Add subcategories');
			} 
			else 
			{
				tabContent="";
				let row = ""
				let j = 0;
				for(let i=0;i< subcategories.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu">${subcategories[i].subcategoryname}</td>\n`;
					row +=  `<td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#subCategoryModal">Edit</button></td>\n+
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete sub" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>\n`;
					tabContent+= `<tr id="${subcategories[i].subcategoryid}">`+row+`</tr>\n`;
					row="";							
				}
				$("#subCategoryDisplay").html(tabContent);
			}
		}
		
	});

	$.ajax({
		url: '../components/shoppingkart.cfc?method=listProducts',
		type: 'GET',
		success: function(data) 
		{	
			obj= JSON.parse(data);
			var products = obj.RESULTSET;
			console.log(products);
			let tab="";
			let tabContent="";
			if (obj.DATA == '') 
			{
				alert('Add subcategories');
			} 
			else 
			{
				tabContent="";
				let row = ""
				let j = 0;
				for(let i=0;i< products.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu">${products[i].productname}</td>\n`;
					row +=  `<td><button type="button" class="btn btn-info btn-sm w-100 edit" data-bs-toggle="modal" data-bs-target="#productModal">Edit</button></td>\n+
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete product" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>\n`;
					tabContent+= `<tr id="${products[i].productid}">`+row+`</tr>\n`;
					row="";							
				}
				$("#productDisplay").html(tabContent);
			}
		}
		
	});
		
	$(document).on('click', '[data-bs-toggle="modal"]', function() {
		// Get the target modal's ID from the trigger element
		var targetModal = $(this).data('bs-target');
		var button = $(this);
		var buttonClass = button.attr('class'); 
		/*if($("#logId").length>0){
			$("#logId").remove();
		}*/
	
		if (targetModal === '#CategoryModal') {
			if (buttonClass.includes('add')) {
				$("#CategoryForm")[0].reset();
				$('#CategoryForm input[type="hidden"]').remove();
				//$("#CategoryForm").attr('class','add');
				$("#categoryHeading").text("CREATE CATEGORY");
				$("#categorySubmit").text("Add Category");
						//$('#addDiv').show();
	
			} 
			if (buttonClass.includes('edit')) {
				$("#CategoryForm")[0].reset();
				$('#CategoryForm input[type="hidden"]').remove();
				let j = $(this).parent().parent().attr('id');
				$.ajax({
					url: "../components/shoppingkart.cfc?method=listCategory",
					type: "GET",
					data: { 
					  "categoryid": j // Set selected category ID in the headers
					},
					success: function(data) {
					  const obj = JSON.parse(data);
					  var categories1 = obj.RESULTSET;
					  $("#categorySubmit").text("Edit Category");
					  $("#categoryName").val(categories1[0].categoryname);
					  let field3 = $('<input>').attr('type', 'hidden').attr('name', 'categoryId').attr('id','categoryId');
					  $("#CategoryForm").append(field3);
					  $("#categoryId").val(j);
					},
					error: function(xhr, status, error) {
					  console.error("Error fetching subcategories:", error);
					}
				});
			}
		} else if (targetModal === '#subCategoryModal') {
			// Custom functionality for modal 2
			if (buttonClass.includes('add')) {
				$("#subCategoryForm")[0].reset();
				$('#subCategoryForm input[type="hidden"]').remove();
				//$("#myForm1").attr('class','add');
				$("#subCategoryHeading").text("CREATE SUBCATEGORY");
				$("#subCategorySubmit").text("Add Subcategory");
						//$('#addDiv').show();	
				} 
			if (buttonClass.includes('edit')) {
				$("#subCategoryForm")[0].reset();
				$('#subCategoryForm input[type="hidden"]').remove();
				let j = $(this).parent().parent().attr('id');
				$.ajax({
					url: "../components/shoppingkart.cfc?method=listSubCategory",
					type: "GET",
					data: { 
					  "subcategoryid": j // Set selected category ID in the headers
					},
					success: function(data) {
					  const obj = JSON.parse(data);
					  var subcategories1 = obj.RESULTSET;
					  $("#subcategorySubmit").text("Edit Subcategory");
					  $("#subCategoryName").val(subcategories1[0].subcategoryname);
					  let field3 = $('<input>').attr('type', 'hidden').attr('name', 'subcategoryid').attr('id','subCategoryId');
					  $("#subCategoryForm").append(field3);
					  $("#categorySelect").val(subcategories1[0].categoryid);
					  $("#subCategoryId").val(j);
					},
					error: function(xhr, status, error) {
					  console.error("Error fetching subcategories:", error);
					}
				});

			console.log('Modal 2 opened');
			}
		} else if (targetModal === '#productModal') {
			// Custom functionality for modal 3
			if (buttonClass.includes('add')) {
				$("#productForm")[0].reset();
				$('#productForm input[type="hidden"]').remove();
				//$("#myForm1").attr('class','add');
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

						//$('#addDiv').show();
	
			} 
			if (buttonClass.includes('edit')) {
				$("#productForm")[0].reset();
				$('#productForm input[type="hidden"]').remove();
				$("#productPicture").attr("required", false);
				let j = $(this).parent().parent().attr('id');
				$.ajax({
					url: "../components/shoppingkart.cfc?method=listProducts",
					type: "GET",
					data: { 
					  "productid": j // Set selected category ID in the headers
					},
					success: function(data) {
					  const obj = JSON.parse(data);
					  var products1 = obj.RESULTSET;
					  $("#productSubmit").text("Edit Product");
					  $("#productCategory").val(products1[0].subcategoryid);
					  $("#productName").val(products1[0].productname);
					  $("#productDesc").val(products1[0].productdesc);
					  $("#price").val(products1[0].price);
					  let field3 = $('<input>').attr('type', 'hidden').attr('name', 'productid').attr('id','productId');
					  $("#productForm").append(field3);
					  $("#productCategory").val(products1[0].categoryid);
					  let selectedValue = products1[0].categoryid;
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
							  $("#productSubCategory").val(products1[0].subcategoryid);
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
					  $("#productId").val(j);

					},
					error: function(xhr, status, error) {
					  console.error("Error fetching subcategories:", error);
					}
				});
			console.log('Modal 3 opened');
			}
		}else if(targetModal === "#delModal"){
			$("#delForm")[0].reset();
			$('#delForm input[type="hidden"]').remove();
			if (buttonClass.includes('category')) {
				let j = $(this).parent().parent().attr('id');
				let field3 = $('<input>').attr('type', 'hidden').attr('name', 'deleteid').attr('id','deleteid');
				let field4 = $('<input>').attr('type', 'hidden').attr('name', 'section').attr('id','section');
				$("#delForm").append(field3);
				$("#delForm").append(field4);
				$("#deleteid").val(j);
				$("#section").val("category");
			}
			if (buttonClass.includes('sub')) {
				let j = $(this).parent().parent().attr('id');
				let field3 = $('<input>').attr('type', 'hidden').attr('name', 'deleteid').attr('id','deleteid');
				let field4 = $('<input>').attr('type', 'hidden').attr('name', 'section').attr('id','section');
				$("#delForm").append(field3);
				$("#delForm").append(field4);
				$("#deleteid").val(j);
				$("#section").val("subcategory");
			}
			if (buttonClass.includes('product')) {
				let j = $(this).parent().parent().attr('id');
				let field3 = $('<input>').attr('type', 'hidden').attr('name', 'deleteid').attr('id','deleteid');
				let field4 = $('<input>').attr('type', 'hidden').attr('name', 'section').attr('id','section');
				$("#delForm").append(field3);
				$("#delForm").append(field4);
				$("#deleteid").val(j);
				$("#section").val("product");
			}
			
		}

	});

});
