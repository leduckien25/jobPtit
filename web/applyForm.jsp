<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            max-width: 400px; 
            text-align: center;
        }
        h3 { color: #1a73e8; margin-top: 0; margin-bottom: 20px; }
        p { color: #555; line-height: 1.6; margin-bottom: 25px; }
        button { 
            width: 100%; padding: 14px; background-color: #1a73e8; 
            color: white; border: none; border-radius: 6px; 
            cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.3s;
        }
        button:hover { background-color: #1557b0; }
        .back-link { display: block; margin-top: 15px; color: #666; text-decoration: none; font-size: 14px; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <form action="apply" method="post">
        <h3>Xác nhận ứng tuyển</h3>
        
        <input type="hidden" name="jobId" value="${param.jobId}">
        
        <p>Hệ thống sẽ sử dụng <strong>Thông tin cá nhân</strong> và <strong>CV</strong> đã lưu trong Profile của bạn để nộp vào vị trí này.</p>
        
        <button type="submit">Ứng tuyển ngay</button>
        
        <a href="index.jsp" class="back-link">Quay lại danh sách việc làm</a>
    </form>
    
    <%-- Hiển thị thông báo nếu có lỗi từ Servlet --%>
    <p style="color: red; margin-top: 10px;">${msg}</p>
</div>

</body>
</html>