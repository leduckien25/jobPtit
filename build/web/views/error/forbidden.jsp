<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Cấm truy cập | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        body { 
            font-family: 'Inter', sans-serif; 
            background-color: #f8fafc; 
            color: #0f172a; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            height: 100vh; 
            margin: 0; 
        }

        .error-container { 
            text-align: center; 
            background: white; 
            padding: 50px 40px; 
            border-radius: 16px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.05); 
            max-width: 480px; 
            width: 90%; 
            border-top: 5px solid #ea1e24; /* Màu đỏ chủ đạo của hệ thống */
        }

        .error-icon { 
            font-size: 64px; 
            color: #ea1e24; 
            margin-bottom: 20px; 
        }

        .error-code { 
            font-size: 80px; 
            font-weight: 800; 
            color: #1e293b; 
            margin: 0; 
            line-height: 1; 
            letter-spacing: -2px;
        }

        .error-title { 
            font-size: 24px; 
            font-weight: 700; 
            margin: 15px 0 10px; 
        }

        .error-desc { 
            color: #64748b; 
            font-size: 15px; 
            margin-bottom: 35px; 
            line-height: 1.6; 
        }

        .btn-home { 
            background: #ea1e24; 
            color: white; 
            text-decoration: none; 
            padding: 14px 28px; 
            border-radius: 8px; 
            font-weight: 600; 
            font-size: 15px;
            transition: all 0.2s; 
            display: inline-flex; 
            align-items: center; 
            gap: 8px; 
        }

        .btn-home:hover { 
            background: #d1151a; 
            transform: translateY(-2px); 
            box-shadow: 0 4px 12px rgba(234, 30, 36, 0.2);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon"><i class="fas fa-user-lock"></i></div>
        <h1 class="error-code">403</h1>
        <div class="error-title">Truy cập bị từ chối</div>
        <div class="error-desc">
            Xin lỗi, tài khoản của bạn không có quyền truy cập vào khu vực này. Vui lòng quay lại bằng tài khoản phù hợp!
        </div>
        <a href="${pageContext.request.contextPath}/auth/login" class="btn-home">
            <i class="fas fa-home"></i> Quay về Đăng nhập
        </a>
    </div>
</body>
</html>