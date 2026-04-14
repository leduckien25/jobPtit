<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận ứng tuyển - MyJob</title>
    <style>
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        background-color: #f4f4f4; /* Màu nền xám nhạt giống trang chủ */
        display: flex; 
        justify-content: center; 
        align-items: center; 
        height: 100vh; 
        margin: 0; 
    }
    .container { 
        background: white; 
        padding: 40px; 
        border-radius: 12px; 
        box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
        width: 100%; 
        max-width: 450px; 
        text-align: center;
        border-top: 6px solid #e32124; /* Đường kẻ đỏ phía trên cùng tone trang chủ */
    }
    h3 { 
        color: #333; 
        margin-top: 0; 
        margin-bottom: 20px; 
        font-weight: bold;
    }
    
    .job-card {
        background-color: #fff5f5; /* Nền đỏ cực nhẹ */
        border: 1px solid #ffcccc;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    .job-title { 
        color: #e32124; /* Chữ màu đỏ PTIT */
        font-weight: bold; 
        font-size: 19px; 
        display: block; 
    }
    .company-name { color: #666; font-size: 14px; margin-top: 5px; display: block; }

    .info-box { 
        font-size: 13px; 
        color: #666; 
        background: #fdf2f2; 
        padding: 12px; 
        border-radius: 6px; 
        margin-bottom: 25px;
        border-left: 4px solid #e32124; /* Nhấn mạnh bằng thanh dọc đỏ */
        text-align: left;
    }
    
    button { 
        width: 100%; 
        padding: 14px; 
        background-color: #e32124; /* Nút bấm màu đỏ PTIT */
        color: white; 
        border: none; 
        border-radius: 8px; 
        cursor: pointer; 
        font-size: 16px; 
        font-weight: bold; 
        transition: background 0.3s;
        box-shadow: 0 4px 6px rgba(227, 33, 36, 0.2);
    }
    button:hover { 
        background-color: #b91a1d; /* Đỏ đậm hơn khi hover */
    }
    
    .back-link { 
        display: block; 
        margin-top: 20px; 
        color: #e32124; 
        text-decoration: none; 
        font-size: 14px; 
        font-weight: 500;
    }
    .back-link:hover { text-decoration: underline; }
    
    .error-msg { 
        color: #d93025; 
        background: #fff0f0; 
        padding: 10px; 
        border-radius: 4px; 
        margin-top: 15px; 
        font-size: 14px; 
    }
</style>
</head>
<body>

<div class="container">
    <form action="${pageContext.request.contextPath}/apply" method="post">
        <h3>Xác nhận ứng tuyển</h3>
        
        <div class="job-card">
            <span class="job-title">${param.jobTitle}</span>
            <span class="company-name">${param.companyName}</span>
        </div>

        <input type="hidden" name="jobId" value="${param.jobId}">
        
        <div class="info-box">
                 Hồ sơ của bạn sẽ được gửi tự động đến Nhà tuyển dụng.
        </div>

        <p>Bạn có muốn nộp đơn vào vị trí này không?</p>
        
        <c:choose>
            <c:when test="${empty sessionScope.LOGIN_USER}">
                <div class="error-msg">
                    Bạn cần <a href="${pageContext.request.contextPath}/auth/login">đăng nhập</a> để thực hiện nộp đơn.
                </div>
            </c:when>
            <c:otherwise>
                <%-- Chặn nộp đơn nếu không phải là Candidate (Role = 1) --%>
                <c:if test="${sessionScope.LOGIN_USER.role == 1}">
                    <button type="submit">Nộp đơn ứng tuyển ngay</button>
                </c:if>
                <c:if test="${sessionScope.LOGIN_USER.role != 1}">
                    <div class="error-msg">Chỉ tài khoản Ứng viên mới có thể nộp đơn.</div>
                </c:if>
            </c:otherwise>
        </c:choose>
        
        <a href="${pageContext.request.contextPath}/" class="back-link">Hủy và quay lại trang chủ</a>
    </form>
    
    <c:if test="${not empty msg}">
        <div class="error-msg">${msg}</div>
    </c:if>
</div>

</body>
</html>