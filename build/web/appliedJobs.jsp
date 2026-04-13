<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách công việc đã ứng tuyển</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #f4f4f4; }
        .status-pending { color: orange; }
        .status-accepted { color: green; font-weight: bold; }
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
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${appliedList}" var="app">
                <tr>
                    <td>${app.jobTitle}</td>
                    <td>${app.companyName}</td>
                    <td>${app.appliedAt}</td>
                    <td>
                        <c:choose>
                            <c:when test="${app.status == 0}"><span class="status-pending">Đang chờ</span></c:when>
                            <c:when test="${app.status == 4}"><span class="status-accepted">Đã trúng tuyển</span></c:when>
                            <c:otherwise>Đã xem</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
