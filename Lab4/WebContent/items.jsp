<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.Item"%>

<%
//update
if (request.getParameter("update_itemID") != null) {
	Item itemObj = new Item();
	session.setAttribute("is_in_update_mode", request.getParameter("update_itemID"));
}

//setting data
String itemCode;
String itemName;
String itemPrice;
String itemDesc;
if (String.valueOf(session.getAttribute("is_in_update_mode")) == "" || session.getAttribute("is_in_update_mode") == null) {
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
} else {
	Item itemObj = new Item();
	System.out.println(session.getAttribute("is_in_update_mode"));
	String temp[] = itemObj.readSingleItems(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))));
	itemCode = temp[0];
	itemName = temp[1];
	itemPrice = temp[2];
	itemDesc = temp[3];
}
// insert when click save button
//update
if (request.getParameter("itemCode") != null && (
		 session.getAttribute("is_in_update_mode") != null)) {
	Item itemObj = new Item();
	String stsMsg = itemObj.updateItem(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))),
	request.getParameter("itemCode"), request.getParameter("itemName"), request.getParameter("itemPrice"),
	request.getParameter("itemDesc"));
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";

	session.setAttribute("is_in_update_mode", "");
	session.setAttribute("statusMsg", stsMsg);
} else if (request.getParameter("itemCode") != null) { //insert new
	Item itemObj = new Item();
	String stsMsg = itemObj.insertItem(request.getParameter("itemCode"), request.getParameter("itemName"),
	request.getParameter("itemPrice"), request.getParameter("itemDesc"));
	session.setAttribute("statusMsg", stsMsg);
	
}
//delete
if (request.getParameter("itemID") != null) {
	Item itemObj = new Item();
	String stsMsg = itemObj.removeItem(Integer.parseInt(request.getParameter("itemID")));
	session.setAttribute("statusMsg", stsMsg);
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Items Management</title>
<link rel="stylesheet" href="Views/bootstrap.min.css">
</head>
<body>
<div class="container">
 <div class="row">
 <div class="col">
 <h1>Items Management</h1>
	<h3>
		<div class="alert alert-success">
 <% out.print(session.getAttribute("statusMsg"));%>
</div>

	</h3>
	<form method="post" action="items.jsp">
		Item code: <input name="itemCode" value="<%out.print(itemCode);%>"
			type="text" class="form-control"><br> Item name: <input name="itemName"
			value="<%out.print(itemName);%>" type="text" class="form-control"><br> Item
		price: <input name="itemPrice" value="<%out.print(itemPrice);%>"
			type="text" class="form-control"><br> Item description: <input
			name="itemDesc" value="<%out.print(itemDesc);%>" type="text" class="form-control"><br>
		<input name="btnSubmit" type="submit" value="Save" class="btn btn-primary"> 
	</form>
	<br>
	<p>
		<i>**If you want to update item , first fill form and then click update button**</i>
	</p>
	<br>
 
 </div>
 </div>
</div>

	
	<%
	Item itemObj = new Item();
	out.print(itemObj.readItems());
	%>



</body>
</html>