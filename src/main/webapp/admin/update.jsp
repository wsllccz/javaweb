<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>更新商品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
</head>
<body>

<div id="addAll">
    <div id="nav">
        <p>商品管理 &gt; 更新商品</p>
    </div>

    <script type="text/javascript">
        function myclose(ispage) {
            window.location = "${pageContext.request.contextPath}/admin/product?flag=split&ispage=" + ispage;
        }
    </script>

    <div id="table">
        <form action="${pageContext.request.contextPath}/prod/update.action" method="post" id="myform">
            <input type="hidden" value="${prod.pId}" name="pId">
            <input type="hidden" value="${page}" name="page">

            <table>
                <tr>
                    <td class="one">商品名称</td>
                    <td><input type="text" name="pName" class="two" value="${prod.pName}"></td>
                </tr>
                <tr class="three">
                    <td></td>
                    <td><span id="pnameerr"></span></td>
                </tr>

                <tr>
                    <td class="one">商品介绍</td>
                    <td><input type="text" name="pContent" class="two" value="${prod.pContent}"></td>
                </tr>
                <tr class="three">
                    <td></td>
                    <td><span id="pcontenterr"></span></td>
                </tr>

                <tr>
                    <td class="one">定价</td>
                    <td><input type="number" name="pPrice" class="two" value="${prod.pPrice}"></td>
                </tr>
                <tr class="three">
                    <td></td>
                    <td><span id="priceerr"></span></td>
                </tr>

                <tr>
                    <td class="one">总数量</td>
                    <td><input type="number" name="pNumber" class="two" value="${prod.pNumber}"></td>
                </tr>
                <tr class="three">
                    <td></td>
                    <td><span id="numerr"></span></td>
                </tr>

                <tr>
                    <td class="one">类别</td>
                    <td>
                        <select name="typeId">
                            <c:forEach items="${ptlist}" var="type">
                                <option value="${type.typeId}" <c:if test="${type.typeId==prod.typeId}">selected</c:if>>
                                        ${type.typeName}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="submit" value="提交" class="btn btn-success">
                    </td>
                    <td>
                        <input type="reset" value="取消" class="btn btn-default" onclick="myclose(1)">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</body>
</html>
