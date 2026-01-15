<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="jmu.ccz.fs.pojo.*" %>
<%@page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">
        if ("${msg}" != "") {
            alert("${msg}");
        }
    </script>
    <c:remove var="msg"></c:remove>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bright.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addBook.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>




    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
    <title>商品管理</title>
    
</head>

<body>
<div id="brall">
    <!-- 顶部导航 -->
    <div id="nav">
        <p>商品管理 &gt; 商品列表</p>
    </div>

    <!-- 查询条件 -->
    <div id="condition" style="text-align: center">
        <form id="queryForm">
            商品名称：<input name="pname" id="pname">&nbsp;&nbsp;&nbsp;
            商品类型：
            <select name="typeid" id="typeid">
                <option value="-1">请选择</option>
                <c:forEach items="${ptlist}" var="pt">
                    <option value="${pt.typeId}">${pt.typeName}</option>
                </c:forEach>
            </select>&nbsp;&nbsp;&nbsp;
            价格：<input name="lprice" id="lprice">-<input name="hprice" id="hprice">
            <input type="button" value="查询" onclick="ajaxsplit(${pb.pageNum})">
        </form>
    </div>
    <br>

    <!-- 商品表格 -->
    <div id="table">
        <c:choose>
            <c:when test="${pb.list.size()!=0}">
                <div id="top">
                    <input type="checkbox" id="all" onclick="allClick()" style="margin-left: 50px">&nbsp;&nbsp;全选
                    <a href="${pageContext.request.contextPath}/admin/addproduct.jsp">
                        <input type="button" class="btn btn-warning" value="新增商品">
                    </a>
                    <input type="button" class="btn btn-warning" value="批量删除" onclick="deleteBatch(${pb.pageNum})">
                </div>

                <div id="middle">
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th></th>
                            <th>商品名</th>
                            <th>商品介绍</th>
                            <th>定价（元）</th>
                            <th>商品数量</th>
                            <th>操作</th>
                        </tr>
                        <c:forEach items="${pb.list}" var="p">
                            <tr>
                                <td align="center"><input type="checkbox" name="ck" value="${p.pId}" onclick="ckClick()"></td>
                                <td>${p.pName}</td>
                                <td>${p.pContent}</td>
                                <td>${p.pPrice}</td>
                                <td>${p.pNumber}</td>
                                <td>
                                    <button type="button" class="btn btn-info" onclick="one(${p.pId},${pb.pageNum})">编辑</button>
                                    <button type="button" class="btn btn-warning" onclick="del(${p.pId},${pb.pageNum})">删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <!-- 分页 -->
                    <div id="bottom">
                        <nav aria-label="Page navigation" style="text-align:center;">
                            <ul class="pagination">
                                <li><a href="javascript:ajaxsplit(${pb.prePage})">&laquo;</a></li>
                                <c:forEach begin="1" end="${pb.pages}" var="i">
                                    <li>
                                        <a href="javascript:ajaxsplit(${i})" style="${pb.pageNum==i?'background-color: grey;':''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li><a href="javascript:ajaxsplit(${pb.nextPage})">&raquo;</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <h2 style="text-align: center;color: orangered;margin-top: 100px">暂时没有符合条件的商品！</h2>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 新增/编辑商品模态框 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">新增商品</h4>
            </div>
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/prod/save.action"
                      method="post" id="modalForm">
                    <table>
                        <tr>
                            <td class="one">商品名称</td>
                            <td><input type="text" name="pname" class="two"></td>
                        </tr>
                        <tr class="three">
                            <td></td>
                            <td><span id="pnameerr"></span></td>
                        </tr>

                        <tr>
                            <td class="one">商品介绍</td>
                            <td><input type="text" nam e="pcontent" class="two"></td>
                        </tr>
                        <tr class="three">
                            <td></td>
                            <td><span id="pcontenterr"></span></td>
                        </tr>

                        <tr>
                            <td class="one">定价</td>
                            <td><input type="number" name="pprice" class="two"></td>
                        </tr>
                        <tr class="three">
                            <td></td>
                            <td><span id="priceerr"></span></td>
                        </tr>

                        <tr>
                            <td class="one">总数量</td>
                            <td><input type="number" name="pnumber" class="two"></td>
                        </tr>
                        <tr class="three">
                            <td></td>
                            <td><span id="numerr"></span></td>
                        </tr>

                        <tr>
                            <td class="one">类别</td>
                            <td>
                                <input type="reset" value="取消" class="btn btn-default" onclick="myclose(${param.page})">
                                <script type="text/javascript">
                                    function myclose(ispage) {
                                        window.location="${pageContext.request.contextPath}/prod/split.action?page="+ispage;
                                    }
                                </script>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="text-align: center;">
                                <button type="button" class="btn btn-info"
                                        onclick="location.href='${pageContext.request.contextPath}/prod/split.action'">
                                    取消
                                </button>

                            </td>
                        </tr>

                    </table>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function allClick() {
        var ischeck=$("#all").prop("checked");
        $("input[name=ck]").each(function () { this.checked=ischeck; });
    }

    function ckClick() {
        var length=$("input[name=ck]:checked").length;
        var len=$("input[name=ck]").length;
        $("#all").prop("checked", len === length);
    }

    function deleteBatch(page) {
        var zhi=$("input[name=ck]:checked");
        if(zhi.length==0){ alert("请选择商品！"); return; }
        if(confirm("确定删除"+zhi.length+"条商品吗？")){
            var str = "";
            $.each(zhi,function () { str += $(this).val() + ","; });
            $.post("${pageContext.request.contextPath}/prod/deleteBatch.action", {
                pids:str, page:page,
                pname:$("#pname").val(),
                typeid:$("#typeid").val(),
                lprice:$("#lprice").val(),
                hprice:$("#hprice").val()
            }, function(data){ alert(data.msg); $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table"); }, "json");
        }
    }

    function del(pid,page){
        if(confirm("确定删除吗？")){
            $.post("${pageContext.request.contextPath}/prod/delete.action", {
                pid:pid, page:page,
                pname:$("#pname").val(),
                typeid:$("#typeid").val(),
                lprice:$("#lprice").val(),
                hprice:$("#hprice").val()
            }, function(data){ alert(data.msg); $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table"); }, "json");
        }
    }

    function one(pid,page){ location.href="${pageContext.request.contextPath}/prod/one.action?pid="+pid+"&page="+page; }

    function ajaxsplit(page){
        $.post("${pageContext.request.contextPath}/prod/ajaxsplit.action", {
            page:page,
            pname:$("#pname").val(),
            typeid:$("#typeid").val(),
            lprice:$("#lprice").val(),
            hprice:$("#hprice").val()
        }, function(){ $("#table").load("${pageContext.request.contextPath}/admin/product.jsp #table"); });
    }
</script>
</body>
</html>
