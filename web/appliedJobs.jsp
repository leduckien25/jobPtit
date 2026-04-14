<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách công việc đã ứng tuyển</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; background-color: #f9f9f9; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #1a73e8; color: white; }
        .status-pending { color: orange; font-weight: bold; }
        .status-accepted { color: green; font-weight: bold; }
        .status-rejected { color: red; }
        /* Style cho nút xóa */
        .btn-delete {
            color: #d93025;
            text-decoration: none;
            font-size: 14px;
            padding: 5px 10px;
            border: 1px solid #d93025;
            border-radius: 4px;
        }
        .btn-delete:hover {
            background-color: #d93025;
            color: white;
        }
    </style>
</head>
<body>
    <h2>Việc làm bạn đã ứng tuyển</h2>
    <table>
        <thead>
            <tr>
                <th>Tên công việc</th>
                <th>Công ty</th>
                <th>Ngày nộp</th>
                <th>Trạng thái</th>
                <th>Thao tác</th> </tr>
        </thead>
        <tbody>
            <c:forEach items="${appliedList}" var="app">
                <tr>
                    <td>${app.jobTitle}</td>
                    <td>${app.companyName}</td>
                    <td>
                        <fmt:formatDate value="${app.appliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${app.status == 0}"><span class="status-pending">Đang chờ</span></c:when>
                            <c:when test="${app.status == 4}"><span class="status-accepted">Đã trúng tuyển</span></c:when>
                            <c:when test="${app.status == 3}"><span class="status-rejected">Đã bị từ chối</span></c:when>
                            <c:otherwise>Đã xem</c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <%-- Chỉ cho phép xóa khi đơn đang ở trạng thái "Đang chờ" (status == 0) --%>
                        <c:if test="${app.status == 0}">
                            <a href="${pageContext.request.contextPath}/apply?action=delete&appId=${app.id}" 
                               class="btn-delete" 
                               onclick="return confirm('Bạn có chắc chắn muốn hủy ứng tuyển công việc này?')">
                               Hủy đơn
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty appliedList}">
                <tr>
                    <td colspan="5" style="text-align: center;">Bạn chưa ứng tuyển công việc nào.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <br>
    <a href="${pageContext.request.contextPath}/index.jsp">Quay lại trang chủ</a>
</body>
</html>
