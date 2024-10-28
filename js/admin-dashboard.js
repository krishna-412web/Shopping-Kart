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
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>\n`;
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
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>\n`;
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
					<td><button type="button" class="btn btn-danger btn-sm w-100 delete">Delete</button></td>\n`;
					tabContent+= `<tr id="${products[i].productid}">`+row+`</tr>\n`;
					row="";							
				}
				$("#productDisplay").html(tabContent);
			}
		}
		
	});
		

	/*$(document).on('click', '[data-bs-toggle="modal"]', function() {
		console.log(obj);
		var button = $(this);
		if($("#logId").length>0){
			$("#logId").remove();
		}
		var buttonClass = button.attr('class'); 
		if (buttonClass.includes('add')) {
			$('.content-div:visible').hide();
			$("#myForm1")[0].reset();
			$("#myForm1").attr('class','add');
			$("#profile").prop('required',true);
			$("#heading").text("CREATE CONTACT");
			$("#submit1").text("Add Contact");
            		$('#addDiv').show();

       		} 
		if (buttonClass.includes('edit')) {
                       	$('.content-div:visible').hide();
			let i = $(this).parent().parent().children().first().html();
			let j = $(this).parent().parent().attr('id');
			let rowSelected = obj[i-1];
			prevHobbieList='';
			$("#myForm1").attr('class','edit');
			$("#heading").text("EDIT CONTACT");
			$("#title").val(rowSelected.title);
			$("#firstName").val(rowSelected.firstname);
			$("#lastName").val(rowSelected.lastname);
			$("#gender").val(rowSelected.gender);
			let date = new Date(rowSelected.dob);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			$("#dob").val(formatdate);
			$("#profile").prop('required',false);
			$("#houseName").val(rowSelected.house_flat);
			$("#street").val(rowSelected.street);
			$("#city").val(rowSelected.city);
			$("#state").val(rowSelected.state);
			$("#pincode").val(rowSelected.pincode);
			$("#email").val(rowSelected.email);
			$("#phone").val(rowSelected.phone);
			prevHobbieList = rowSelected.hobbieid;
			let field3 = $('<input>').attr('type', 'hidden').attr('name', 'logId').attr('id','logId');
			$("#myForm1").append(field3);
			$("#logId").val(j);

			
			$("#hobbies option").each(function() {
 				$(this).prop('selected', false);          	
           	 	});

			$("#hobbies option").each(function() {
                		var optionText = $(this).attr('value');
				if(optionText != ''){
		        		if (rowSelected.hobbieid.includes(optionText)) {
                	    			$(this).prop('selected', true);          
					}
				}	
           	 	});
			$("#submit1").text("Edit Contact");
				
            		$('#addDiv').show();
        } 	
		
	});

		
	$("#myForm1").submit(function(event){
		var class1 = $(this).attr('class');
		var field1;
		var field2;
		var field3; 	
		if(class1 == "add")
		{
			//$(this).addClass("was-validated");
			field1 = $('<input>').attr('type', 'hidden').attr('name', 'operation').val('add');
			$(this).append(field1);
		}
		if(class1 == "edit"){
			field1 = $('<input>').attr('type', 'hidden').attr('name', 'operation').val('edit');
			field2 = $('<input>').attr('type', 'hidden').attr('name', 'prevHobbieList').val(prevHobbieList);
			$(this).append(field1);
			$(this).append(field2);	
		}
		
	});
	$(document).on('click','.delete', function(event) {
		let row = $(this).parent().parent().attr('id');
		$("#delInp").attr('value',row);
	});*/
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
				/*			   $('.content-div:visible').hide();
				let i = $(this).parent().parent().children().first().html();
				let j = $(this).parent().parent().attr('id');
				let rowSelected = obj[i-1];
				prevHobbieList='';
				$("#myForm1").attr('class','edit');
				$("#heading").text("EDIT CONTACT");
				$("#title").val(rowSelected.title);
				$("#firstName").val(rowSelected.firstname);
				$("#lastName").val(rowSelected.lastname);
				$("#gender").val(rowSelected.gender);
				let date = new Date(rowSelected.dob);
				date.setDate(date.getDate() + 1);
				let formatdate = date.toISOString().split('T')[0];
				$("#dob").val(formatdate);
				$("#profile").prop('required',false);
				$("#houseName").val(rowSelected.house_flat);
				$("#street").val(rowSelected.street);
				$("#city").val(rowSelected.city);
				$("#state").val(rowSelected.state);
				$("#pincode").val(rowSelected.pincode);
				$("#email").val(rowSelected.email);
				$("#phone").val(rowSelected.phone);
				prevHobbieList = rowSelected.hobbieid;
				let field3 = $('<input>').attr('type', 'hidden').attr('name', 'logId').attr('id','logId');
				$("#myForm1").append(field3);
				$("#logId").val(j);
	
				
				$("#hobbies option").each(function() {
					 $(this).prop('selected', false);          	
						});
	
				$("#hobbies option").each(function() {
							var optionText = $(this).attr('value');
					if(optionText != ''){
							if (rowSelected.hobbieid.includes(optionText)) {
										$(this).prop('selected', true);          
						}
					}	
						});
				$("#submit1").text("Edit Contact");
					
						$('#addDiv').show();
				}*/ 
			console.log('Modal 3 opened');
			}
		}
	});

});
