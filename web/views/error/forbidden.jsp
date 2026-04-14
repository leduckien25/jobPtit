<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Cấm truy cập | PTIT JOBS</title>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root { --ptit-red: #da1f26; }
        
        body { 
            font-family: 'Inter', sans-serif !important; 
            background-color: #f8f9fa; 
            color: #333; 
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
            border-radius: 12px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.05); 
            max-width: 500px; 
            width: 90%; 
            border-top: 5px solid var(--ptit-red); 
        }

        /* Đồng bộ Logo P vuông đỏ để giữ nhận diện */
        .logo-box { 
            background: var(--ptit-red); 
            color: white; 
            padding: 5px 15px; 
            border-radius: 6px; 
            font-weight: 800; 
            font-size: 24px;
            display: inline-block;
            margin-bottom: 20px;
        }

        .error-code { 
            font-size: 100px; 
            font-weight: 800; 
            color: #1f2937; 
            margin: 0; 
            line-height: 1; 
        }

        .error-title { 
            font-size: 24px; 
            font-weight: 700; 
            color: var(--ptit-red);
            margin: 15px 0 10px; 
        }

        .error-desc { 
            color: #6b7280; 
            font-size: 15px; 
            margin-bottom: 35px; 
            line-height: 1.6; 
        }

        .btn-home { 
            background: var(--ptit-red); 
            color: white; 
            text-decoration: none; 
            padding: 12px 30px; 
            border-radius: 8px; 
            font-weight: 700; 
            font-size: 15px;
            transition: 0.3s; 
            display: inline-flex; 
            align-items: center; 
            gap: 10px; 
            border: none;
        }

        .btn-home:hover { 
            background: #b3191f; 
            color: white;
            transform: translateY(-2px); 
            box-shadow: 0 5px 15px rgba(218, 31, 38, 0.2);
        }

        .icon-lock {
            font-size: 50px;
            color: #ddd;
            margin-bottom: 10px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="logo-box">P</div>
        <div class="fw-bold text-muted small mb-3">JOBS SYSTEM</div>
        
        <i class="fa fa-shield-halved icon-lock"></i>
        <h1 class="error-code">403</h1>
        <div class="error-title">TRUY CẬP BỊ TỪ CHỐI</div>
        <div class="error-desc">
            Xin lỗi, tài khoản của bạn không có đủ thẩm quyền để truy cập vào tài nguyên này. Vui lòng kiểm tra lại quyền hạn hoặc đăng nhập bằng tài khoản Quản trị viên.
        </div>
        
        <a href="${pageContext.request.contextPath}/auth/login" class="btn-home">
            <i class="fas fa-sign-in-alt"></i> ĐĂNG NHẬP LẠI
        </a>
    </div>
</body>
</html>