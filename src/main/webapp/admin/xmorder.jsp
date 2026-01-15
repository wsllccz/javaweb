<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="jmu.ccz.fs.pojo.*" %>
<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>订单列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
</head>
<body>



<c:if test="${not empty sessionScope.msg}">
    <div style="color: green; text-align: center; margin: 10px 0;">
            ${sessionScope.msg}
    </div>
    <c:remove var="msg" scope="session"/>
</c:if>

<div style="width: 95%; margin: auto;">
    <table class="table table-bordered table-striped">
        <tr>
            <th>订单ID</th>
            <th>用户ID</th>
            <th>收货地址ID</th>
            <th>总金额</th>
            
            <th>备注</th>
            <th>状态</th>
            <th>下单时间</th>
        </tr>
        <c:forEach items="${pb.list}" var="order">
            <tr>
                <td>${order.oid}</td>
                <td>${order.uid}</td>
                <td>${order.addressId}</td>
                <td>${order.totalprice}</td>
                <td>${order.remarks}</td>
                <td>${order.status}</td>
                <td>${order.odate}</td>
            </tr>
        </c:forEach>
    </table>

    <nav style="text-align:center;">
        <ul class="pagination">
            <li><a href="javascript:ajaxsplit(${pb.prePage})">&laquo;</a></li>
            <c:forEach begin="1" end="${pb.pages}" var="i">
                <li><a href="javascript:ajaxsplit(${i})" style="${pb.pageNum==i?'background-color: grey;':''}">${i}</a></li>
            </c:forEach>
            <li><a href="javascript:ajaxsplit(${pb.nextPage})">&raquo;</a></li>
        </ul>
    </nav>
</div>

<script type="text/javascript">
    function ajaxsplit(page){
        $.post("${pageContext.request.contextPath}/xmorder/list", {page: page}, function(data){
            $("#table").html($(data).find("#table").html());
        });
    }
</script>
</body>
</html>
