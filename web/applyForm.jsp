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
            background-color: #f0f2f5; 
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
            box-shadow: 0 8px 24px rgba(0,0,0,0.1); 
            width: 100%; 
            max-width: 420px; 
            text-align: center;
        }
        h3 { color: #1a73e8; margin-top: 0; margin-bottom: 15px; }
        
        /* Chỉnh lại phần hiển thị tên công việc cho nổi bật theo mục 9 */
        .job-card {
            background-color: #f8f9fa;
            border: 1px dashed #1a73e8;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .job-title { color: #333; font-weight: bold; font-size: 18px; display: block; }
        .company-name { color: #666; font-size: 14px; }

        p { color: #555; line-height: 1.6; margin-bottom: 25px; font-size: 15px; }
        
        button { 
            width: 100%; padding: 14px; background-color: #1a73e8; 
            color: white; border: none; border-radius: 6px; 
            cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.3s;
        }
        button:hover { background-color: #1557b0; }
        
        .back-link { display: block; margin-top: 15px; color: #666; text-decoration: none; font-size: 14px; }
        .back-link:hover { text-decoration: underline; }
        
        .error-msg { color: #d93025; background: #fce8e6; padding: 10px; border-radius: 4px; margin-top: 15px; font-size: 14px; }
        .info-box { font-size: 13px; color: #1a73e8; background: #e8f0fe; padding: 10px; border-radius: 6px; margin-bottom: 20px; }
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
            💡 Hồ sơ của bạn (Full Name, Phone, CV) sẽ được gửi tự động đến Nhà tuyển dụng.
        </div>

        <p>Bạn có chắc chắn muốn nộp đơn vào vị trí này không?</p>
        
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