<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            color: #0f172a;
        }

        .auth-card {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            width: 100%;
            max-width: 420px;
            text-align: center;
            border-top: 5px solid #ea1e24; /* Đường viền đỏ chuẩn nhận diện */
        }

        .auth-icon {
            font-size: 56px;
            color: #ea1e24;
            margin-bottom: 20px;
        }

        .auth-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #1e293b;
        }

        .auth-desc {
            color: #64748b;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 25px;
        }

        .admin-info {
            background: #f1f5f9;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            font-size: 15px;
            font-weight: 600;
            color: #334155;
            text-align: left;
            border: 1px solid #e2e8f0;
        }

        .admin-info p {
            margin: 0 0 12px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-info p:last-child {
            margin: 0;
        }

        .admin-info i {
            color: #ea1e24;
            width: 20px;
            text-align: center;
        }

        .btn-back {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 14px;
            background: #ea1e24;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.2s;
        }

        .btn-back:hover {
            background: #d1151a;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(234, 30, 36, 0.2);
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="auth-icon"><i class="fas fa-user-shield"></i></div>
        <div class="auth-title">Khôi phục mật khẩu</div>
        <div class="auth-desc">
            Để đảm bảo an toàn dữ liệu, hệ thống hiện không hỗ trợ tự động cấp lại mật khẩu. Vui lòng liên hệ với Quản trị viên để được hỗ trợ.
        </div>
        
        <div class="admin-info">
            <p><i class="fas fa-envelope"></i> admin.support@ptit.edu.vn</p>
            <p><i class="fas fa-phone-alt"></i> Hotline: 0987.654.321</p>
            <p><i class="fab fa-facebook-messenger"></i> m.me/PtitJobsSupport</p>
        </div>

        <a href="${pageContext.request.contextPath}/auth/login" class="btn-back">
            <i class="fas fa-arrow-left"></i> Quay lại Đăng nhập
        </a>
    </div>

</body>
</html>