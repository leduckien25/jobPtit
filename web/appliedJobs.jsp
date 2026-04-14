<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách công việc đã ứng tuyển</title>
    <style>
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        padding: 40px; 
        background-color: #f4f4f4; 
        color: #333;
    }
    .main-container {
        max-width: 1000px;
        margin: 0 auto;
        background: white;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        border-top: 6px solid #e32124; /* Thanh đỏ đặc trưng */
    }
    h2 { 
        color: #333; 
        margin-bottom: 25px; 
        font-weight: bold;
        text-align: center;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    table { 
        width: 100%; 
        border-collapse: collapse; 
        margin-top: 10px; 
    }
    th { 
        background-color: #f8f9fa; 
        color: #555; 
        font-weight: 600;
        border-bottom: 2px solid #dee2e6;
        padding: 15px;
        text-align: left;
    }
    td { 
        padding: 15px; 
        border-bottom: 1px solid #eee;
        font-size: 15px;
    }
    tr:hover { background-color: #fff9f9; } /* Hiệu ứng hover dòng nhẹ */

    /* Trạng thái đơn hàng */
    .status-pending { 
        background: #fff4e5; color: #ff9800; 
        padding: 4px 10px; border-radius: 20px; font-size: 13px; 
    }
    .status-accepted { 
        background: #e6f4ea; color: #1e7e34; 
        padding: 4px 10px; border-radius: 20px; font-size: 13px; 
    }
    .status-rejected { 
        background: #fce8e6; color: #d93025; 
        padding: 4px 10px; border-radius: 20px; font-size: 13px; 
    }

    /* Nút Hủy đơn */
    .btn-delete {
        color: #e32124;
        text-decoration: none;
        font-size: 13px;
        padding: 6px 12px;
        border: 1px solid #e32124;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s;
    }
    .btn-delete:hover {
        background-color: #e32124;
        color: white;
        box-shadow: 0 2px 5px rgba(227, 33, 36, 0.3);
    }
    
    .back-home {
        display: inline-block;
        margin-top: 25px;
        color: #666;
        text-decoration: none;
        font-size: 14px;
    }
    .back-home:hover { color: #e32124; text-decoration: underline; }
</style>

<div class="main-container">
    <h2>Danh sách việc làm đã nộp</h2>
    <table>
        <thead>
            <tr>
                <th>Vị trí ứng tuyển</th>
                <th>Công ty</th>
                <th>Ngày nộp</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${appliedList}" var="app">
                <tr>
                    <td style="font-weight: 600;">${app.jobTitle}</td>
                    <td>${app.companyName}</td>
                    <td style="color: #888;">
                        <fmt:formatDate value="${app.appliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${app.status == 0}"><span class="status-pending">Đang chờ</span></c:when>
                            <c:when test="${app.status == 4}"><span class="status-accepted">Đã trúng tuyển</span></c:when>
                            <c:when test="${app.status == 3}"><span class="status-rejected">Đã bị từ chối</span></c:when>
                            <c:otherwise><span style="color:#999">Đã xem</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${app.status == 0}">
                            <a href="${pageContext.request.contextPath}/apply?action=delete&appId=${app.id}" 
                               class="btn-delete" 
                               onclick="return confirm('Bạn có chắc chắn muốn hủy đơn ứng tuyển này?')">
                                Hủy đơn
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty appliedList}">
                <tr>
                    <td colspan="5" style="text-align: center; padding: 40px; color: #999;">
                        Bạn chưa ứng tuyển công việc nào.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/" class="back-home">← Quay lại trang chủ</a>
</div>