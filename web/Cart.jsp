<%-- 
    Document   : Cart
    Created on : May 31, 2021, 9:42:21 PM
    Author     : tu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>

    <body>
        <style>
            body{
                background: #03A9F4;
            }
        </style>
        <c:if test="${not empty requestScope.OUT}">
            <script>
                swal("SORRY!", "${requestScope.OUT}");
            </script>
        </c:if>
        <jsp:include page="Menu.jsp"></jsp:include>
            <div class="shopping-cart">
                <div class="px-4 px-lg-0">

                    <div class="pb-5">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-12 p-5 bg-white rounded shadow-sm mb-5">

                                    <!-- Shopping cart table -->
                                    <div class="table-responsive">

                                        <table class="table">
                                        ${requestScope.MESSAGEQUANTITY}
                                        <thead>
                                            <tr>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="p-2 px-3 text-uppercase">Book Name</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Price</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Quantity</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Update</div>
                                                </th>
                                                <th scope="col" class="border-0 bg-light">
                                                    <div class="py-2 text-uppercase">Delete</div>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:if test="${empty sessionScope.CART}">
                                            <h3 style="color: red">You don't have product in cart</h3>
                                        </c:if>
                                        <h3 style="color: red" >${QUANTITYSTOCK}</h3>
                                        <c:forEach items="${sessionScope.CART}" var="o">
                                            <form action="MainController" method="POST">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="p-2">
                                                            <img src="${o.book.getImage()}" alt="" width="70" class="img-fluid rounded shadow-sm">
                                                            <div class="ml-3 d-inline-block align-middle">
                                                                <h5 class="mb-0">${o.book.getBookName()}</h5><span class="text-muted font-weight-normal font-italic"></span>
                                                            </div>
                                                        </div>
                                                    </th>
                                                    <td class="align-middle"><strong>${o.getPrice()}</strong></td>
                                                    <td class="align-middle">
                                                        <input type="number" name="txtQuantity" value="${o.getQuantity()}" />
                                                        <input type="hidden" name="txtQuantity" value="" />
                                                    </td>
                                                    <td class="align-middle">    
                                                        <input type="hidden" name="bookid" value="${o.book.getBookID()}" />                                                                                         
                                                        <button type="submit" value="UpdateCart" name ="action" class="btn btn-danger">Update</button>
                                                        </a>
                                                    </td>
                                                    <td class="align-middle">
                                                        <input type="hidden" name="bookid" value="${o.book.getBookID()}" />
                                                        <button type="submit" value="deletecart" name="action" class="btn btn-danger">Delete</button>
                                                        </a>
                                                    </td>

                                                </tr>
                                            </form>


                                            <c:set var="total" value="${total+o.getPrice()}"/>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="row py-5 p-4 bg-white rounded shadow-sm">
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Voucher</div>
                                <div class="p-4">
                                    <div class="input-group mb-4 border rounded-pill p-2">
                                        <form action="MainController" method="POST">
                                            <select name="voucher" aria-describedby="button-addon3" class="form-control border-0">
                                                <option value="">Choose voucher to discount</option>
                                                <c:forEach items="${sessionScope.VOU}" var="c">
                                                    <option value="${c.getDiscountID()}"
                                                            <c:if test="${requestScope.DISCOUNT.getDiscountID() == c.getDiscountID()}">selected</c:if>
                                                            >Voucher: ${c.getDName()}, Discount ${c.getDPercent()}%</option>
                                                </c:forEach>
                                            </select>
                                            <div class="input-group-append border-0">
                                                <button id="button-addon3" type="submit" name="action" value="usevoucher" class="btn btn-dark px-4 rounded-pill"><i class="fa fa-gift mr-2"></i>Use</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Amount </div>
                                <div class="p-4">
                                    <ul class="list-unstyled mb-4">
                                        <c:if test="${requestScope.DISCOUNT !=null}"> <c:set var="total" value="${total * (100 - requestScope.DISCOUNT.getDPercent())/100} "/></c:if>   
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Sub Total</strong><strong> ${total}</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Ship</strong><strong>Free ship</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">TAX</strong><strong>0,2 $</strong></li>
                                        <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total Amount</strong>
                                            <h5 class="font-weight-bold">${total+0.2} $
                                            </h5>
                                        </li>
                                    </ul><a href="MainController?action=CheckOut&total=${total+0.2}&userID=${sessionScope.USER.getUserID()}&voucherID=${requestScope.DISCOUNT.getDiscountID()}" class="btn btn-dark rounded-pill py-2 btn-block">Checkout</a>
                                </div>
                                <div id="paypal-button-container"></div>
                                <form action="MainController" method="POST" style="display: none">
                                    <input type="hidden" name="total" value="${total+0.2}">
                                    <input type="hidden" name="userID" value="${sessionScope.USER.getUserID()}">
                                    <input type="hidden" name="voucherID" value="${requestScope.DISCOUNT.getDiscountID()}">
                                    <input type="submit" name="action" id="ppButton" value="Paypal">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://www.paypal.com/sdk/js?client-id=ARbBcP-keHsNugf3TSCgT7bh0lxoCxKxEmSkWAQbvZQ46XxDQy7r9xsQy4XzSLFDie9OWFgjuwyp4BWP"></script>
        <script>

                paypal.Buttons({

                    style: {
                        color: 'blue',
                        shape: 'pill'
                    },
                    createOrder: function (data, actions) {
                        //Hàm này thiết lập chi tiết của giao dịch, bao gồm số tiền và chi tiết mục hàng. 
                        return actions.order.create({
                            purchase_units: [{
                                    amount: {
                                        value: '${total+0.2}'
                                    }
                                }]
                        });
                    },
                    onApprove: function (data, actions) {
                        // Chức năng này thu tiền từ giao dịch.
                        return actions.order.capture().then(function (details) {
                            // Chức năng này hiển thị thông báo giao dịch thành công cho người mua của bạn.
                            document.getElementById("ppButton").click();
                        });
                    }
                }).render('#paypal-button-container');
                //Chức năng này hiển thị các Nút thanh toán thông minh trên trang web của bạn.  

        </script>

    </body>

</html>
</html>
