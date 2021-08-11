<%-- 
    Document   : HistoryBook
    Created on : June 20, 2021, 2:19:02 AM
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
        <title>History Book</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
            <form action="MainController" method="POST">

                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>History <b>Order</b></h2>
                            </div>

                            <div class="col-sm-6">
                                <a href="MainController?action=home" class="btn btn-success" data-toggle="modal"><span>Back to Home</span></a>                            
                            </div>


                        </div>
                        <div>
                            <font style="color: black">   
                            <input type="text" name="txtSearch" value="${param.txtSearch}" placeholder="Search by name"/>
                            <input type="submit" value="Search History" name="action" />
                            </font>
                        </div>
                    </div>

                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Date</th>
                                <th>Total Price</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>                        

                            <c:set var="searchByName" value="${sessionScope.HISTORY_LISTBYNAME}"/>
                            <c:if test="${not empty searchByName}">
                                <c:forEach items="${sessionScope.HISTORY_LISTBYNAME}" varStatus="counter" var="h">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${h.getDateOrder()}</td>
                                        <td>${h.getTotal()}</td>
                                        <td>
                                            <a href="MainController?action=MoreDetail&OrderID=${h.getOrderID()}"  class="btn btn-success" data-toggle="modal"><span>More</span></a>	
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty searchByName }">
                                <c:if test="${not empty requestScope.OUT}">
                                <h3 style="color: red">${requestScope.OUT}</h3>
                            </c:if>
                            <c:if test="${empty requestScope.OUT}">
                                <c:forEach items="${sessionScope.HISTORY}" varStatus="counter" var="h">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${h.getDateOrder()}</td>
                                        <td>${h.getTotal()}</td>
                                        <td>
                                            <a href="MainController?action=MoreDetail&OrderID=${h.getOrderID()}"  class="btn btn-success" data-toggle="modal"><span>More</span></a>	
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </c:if>

                        </tbody>
                    </table>

                </div>
            </form>
        </div>


        <script src="js/manager.js" type="text/javascript"></script>
    </body>
</html>