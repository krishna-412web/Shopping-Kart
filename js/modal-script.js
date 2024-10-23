$(document).ready(() => {
	
	var obj;
	var prevHobbieList;
	var logId="";
	$.ajax({
		url: './components/database.cfc?method=selectdata',
		type: 'GET',
		success: function(data) 
		{	
			obj= JSON.parse(data);
			console.log(obj);
			let tab="";
			let tabContent="";
			if (obj.DATA == '') 
			{
				alert('Add pages');
			} 
			else 
			{
				tabContent="";
				let row = ""
				let j = 0;
				for(let i=0;i< obj.length;i++)
				{	
					row += `\n<td>${i+1}</td>\n`+
						`<td class="menu"><img style="height:40px;width:40px;padding:0;margin:0 auto;" src="${obj[i].profile}" class="img-fluid" alt="pic"/></td>\n`+
						`<td class="menu">${obj[i].firstname+" "+obj[i].lastname}</td>\n`+
						`<td class="menu">${obj[i].email}</td>\n`+
						`<td class="menu">${obj[i].phone}</td>\n`;
					row +=  `<td>\n<button type="button" class=" btn btn-sm btn-success view no-print" data-bs-toggle="modal" data-bs-target="#myModal">View</button></td>\n`+
						`<td><button type="button" class=" btn btn-sm btn-success edit no-print" data-bs-toggle="modal" data-bs-target="#myModal">Edit</button></td>`+
						`<td><button type="submit" class=" btn btn-sm btn-success delete no-print" name="delete" data-bs-toggle="modal" data-bs-target="#delModal">Delete</button></td>`+
						`<td><button type="button" class=" btn btn-sm btn-success edit no-print printContact">Print</button></td>`;
					tabContent+= `<tr id="${obj[i].log_id}">`+row+`</tr>\n`;
					row="";							
				}
				$("#pageDisplay").html(tabContent);
			}
		}
		
	});

	$("#pdfFeature").click(function(){
		window.location.href="pdfFeature.cfm";
	});


	$("#printFeature").click(function(){
        	window.print();
	});
		

	$(document).on('click', '[data-bs-toggle="modal"]', function() {
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
		if (buttonClass.includes('view')) {
			var hobbieResult = [];
			var hobbyText='';
            		$('.content-div:visible').hide();
			let i = $(this).parent().parent().children().first().html();
			let rowSelected = obj[i-1];

			let date = new Date(rowSelected.dob);
			date.setDate(date.getDate() + 1);
			let formatdate = date.toISOString().split('T')[0];
			let address = `${rowSelected.house_flat},${rowSelected.street},<br>${rowSelected.city},${rowSelected.state}`;
			
			$("#profilePic").attr('src',`${rowSelected.profile}`);

			let name = `${rowSelected.titleName} ${rowSelected.firstname} ${rowSelected.lastname}`;
			$("#nameView").text(name);
			$("#genderView").text(rowSelected.genderName);
			$("#dobView").text(formatdate);
			$("#AddressView").html(address);
			$("#pincodeView").text(rowSelected.pincode);
			$("#mailView").text(rowSelected.email);
			$("#phoneView").text(rowSelected.phone);

			for(let j=0; j<rowSelected.hobbies.length; j++){
				hobbyText +=`${rowSelected.hobbies[j]}<br>\n`;
			}
			$("#hobbieView1").html(hobbyText);

			
			
			$('#viewDiv').show();
       	 	}
		if (buttonClass.includes('upload')) {
			$(".content-div:visible").hide();
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
	});
	
	/*$("#uploadSubmit").click(function() {
		setTimeout(function() {
			window.location.href="welcome.cfm";
		},1500);
	});*/
	
	$(document).on('click','.printContact', function(event) {
		let id= $(this).parent().parent().attr('id');
		let i = $(this).parent().parent().children().first().html();
		let rowSelected = obj[i-1];

		$("#title1").val(rowSelected.title);
		let title = $('#title1 option:selected').text();
		$("#gender1").val(rowSelected.gender);
		let gender = $('#gender1 option:selected').text();

		let encodedTitle = encodeURIComponent(title);
		let encodedGender = encodeURIComponent(gender);

		 window.open(`output.cfm?id=${rowSelected.log_id}`);

	});
	$("#downloadButton").click(function(event) {
		// Hide the closest form when the link is clicked
		$(this).closest("form").hide();
		
		// Set isVisited to true
		isVisited = true;

		// Open the link in a new tab
		//window.open($(this).attr("href"), "_blank");
	});
});
