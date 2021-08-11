<%-- 
    Document   : Edit
    Created on : June 15, 2021, 9:20:04 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Book</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        
        <link href="css/manager.css" rel="stylesheet" type="text/css"/>
        <style>
            img{
                width: 200px;
                height: 120px;
            }
            body{
  background: #1dbf73;
}
        </style>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Edit <b>Product</b></h2>
                        </div>
                        <div class="col-sm-6">
                        </div>
                    </div>
                </div>
            </div>
            <div id="editEmployeeModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MainController" method="post">
                            <div class="modal-header">						
                                <h4 class="modal-title">Edit Book</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            
                            <div class="modal-body">                               
                                <div class="form-group">
                                    <input value="${detailB.getBookID()}" name="id" type="hidden" class="form-control" readonly required>
                                </div>
                                <h3 style="color: red">${requestScope.ERROREDIT}</h3>
                                <div class="form-group">
                                    <label>Name</label>
                                    <input value="${detailB.getBookName()}" name="name" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Image</label>
                                    <input value="${detailB.getImage()}" name="image" type="text" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input value="${detailB.getPrice()}" name="price" type="number" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input value="${detailB.getQuantity()}" name="quantity" type="number" class="form-control" required>
                                    <input type="hidden" name="txtQuantity" value="" />
                                </div>
                                <div class="form-group">
                                    <label>Author</label>
                                    <input value="${detailB.getAuthor()}" name="author" type="text" class="form-control" required>
                                </div>
                               
                                    <label>Category</label>
                                    <select name="category" class="form-select" aria-label="Default select example">
                                        <c:forEach items="${sessionScope.listc}" var="c">
                                            <option value="${c.getCategoryID()}"
                                                    <c:if test="${c.getCategoryID() eq detailB.getCategoryID() }">selected</c:if>
                                                    >${c.getCategoryName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" name="action" class="btn btn-success" value="Edit">
                                <input type="submit" name="action" class="btn btn-success" value="Cancel">
                            </div>
                               
                        </form>
                    </div>
                </div>
            </div>

        </div>


        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>