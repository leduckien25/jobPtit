<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        :root {
            --primary-red: #ea1e24; 
            --primary-red-hover: #d1151a;
            --accent-yellow: #ffde59;
            --text-dark: #0f172a;
            --text-gray: #64748b;
            --border-color: #e2e8f0;
            --bg-body: #ffffff;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; min-height: 100vh; display: flex; background-color: var(--bg-body); }

        .split-layout { display: flex; width: 100%; min-height: 100vh; }

        /* Cột trái */
        .left-panel {
            flex: 1; background: linear-gradient(135deg, #e31818 0%, #f04e23 100%);
            color: white; padding: 60px; display: flex; flex-direction: column;
            position: relative; overflow: hidden;
        }
        .bg-circle-1 { position: absolute; width: 500px; height: 500px; background: rgba(255, 255, 255, 0.08); border-radius: 50%; top: 20%; left: -10%; z-index: 1; }
        .bg-circle-2 { position: absolute; width: 450px; height: 450px; background: rgba(255, 255, 255, 0.06); border-radius: 50%; bottom: -15%; right: -10%; z-index: 1; }
        
        .left-content { position: relative; z-index: 2; height: 100%; display: flex; flex-direction: column; }
        .logo-container { display: flex; align-items: center; gap: 12px; margin-bottom: auto; }
        .logo-icon { width: 44px; height: 44px; background: white; color: var(--primary-red); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: 800; }
        .logo-text h1 { font-size: 22px; font-weight: 800; letter-spacing: 0.5px; }
        .logo-text p { font-size: 13px; opacity: 0.9; margin-top: 2px; font-weight: 500;}

        .main-headline { font-size: 48px; font-weight: 800; line-height: 1.25; margin-bottom: 20px; }
        .highlight-yellow { color: var(--accent-yellow); }
        .sub-headline { font-size: 16px; line-height: 1.6; opacity: 0.9; max-width: 400px; }

        .stats-container { display: flex; gap: 50px; margin-top: auto; }
        .stat-item { display: flex; flex-direction: column; gap: 6px; align-items: center; text-align: center; }
        .stat-icon { width: 40px; height: 40px; background: rgba(255,255,255,0.2); border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 16px; margin-bottom: 5px; }
        .stat-number { font-size: 22px; font-weight: 800; }
        .stat-label { font-size: 13px; opacity: 0.9; font-weight: 500; }

        /* Cột phải */
        .right-panel { flex: 1; display: flex; align-items: center; justify-content: center; padding: 40px; background: var(--bg-body); }
        .form-container { width: 100%; max-width: 400px; display: flex; flex-direction: column; align-items: center; }

        .welcome-badge { background: #fef2f2; color: var(--primary-red); padding: 6px 16px; border-radius: 20px; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; gap: 6px; margin-bottom: 16px; }
        .form-title { font-size: 28px; font-weight: 800; color: var(--text-dark); margin-bottom: 8px; }
        .form-subtitle { font-size: 14px; color: var(--text-gray); margin-bottom: 30px; }

        /* Tabs */
        .role-tabs { display: flex; width: 100%; border: 1px solid var(--border-color); border-radius: 10px; padding: 4px; margin-bottom: 25px; }
        .role-tab { flex: 1; padding: 10px; text-align: center; font-size: 14px; font-weight: 600; border-radius: 6px; cursor: pointer; color: var(--text-gray); transition: all 0.2s; }
        .role-tab i { margin-right: 8px; }
        .role-tab.active { background: var(--primary-red); color: white; }

        /* Alerts JSP */
        .alert { width: 100%; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-error { background: #fee2e2; color: #991b1b; }
        .alert-success { background: #dcfce7; color: #166534; }

        /* Inputs */
        .login-form { width: 100%; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-size: 13px; font-weight: 600; color: var(--text-dark); margin-bottom: 8px; }
        
        .input-wrap { position: relative; }
        .input-wrap i { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 14px; }
        
        .form-control { width: 100%; padding: 12px 16px 12px 42px; border: 1px solid var(--border-color); border-radius: 8px; font-size: 14px; color: var(--text-dark); outline: none; transition: border-color 0.2s; }
        .form-control::placeholder { color: #cbd5e1; }
        .form-control:focus { border-color: var(--primary-red); }

        .form-options { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; font-size: 13px; }
        .checkbox-label { display: flex; align-items: center; gap: 8px; color: var(--text-gray); cursor: pointer; }
        .forgot-link { color: var(--primary-red); font-weight: 600; text-decoration: none; }
        .forgot-link:hover { text-decoration: underline; }

        .btn-submit { width: 100%; padding: 14px; background: var(--primary-red); color: white; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; display: flex; justify-content: center; align-items: center; gap: 8px; transition: background 0.2s; }
        .btn-submit:hover { background: var(--primary-red-hover); }

        .form-footer { margin-top: 40px; text-align: center; font-size: 14px; color: var(--text-gray); }
        .form-footer a { color: var(--primary-red); font-weight: 700; text-decoration: none; }
        .form-footer a:hover { text-decoration: underline; }

        @media (max-width: 992px) {
            .split-layout { flex-direction: column; }
            .left-panel { padding: 40px 20px; min-height: 400px; }
            .main-headline { font-size: 36px; }
            .stats-container { margin-top: 40px; flex-wrap: wrap; justify-content: center; }
        }
    </style>
</head>
<body>

<div class="split-layout">
    <div class="left-panel">
        <div class="bg-circle-1"></div>
        <div class="bg-circle-2"></div>
        <div class="left-content">
            <div class="logo-container">
                <div class="logo-icon">P</div>
                <div class="logo-text">
                    <h1>PTIT JOBS</h1>
                    <p>Kết nối Tài năng - Kiến tạo Tương lai</p>
                </div>
            </div>

            <div>
                <h2 class="main-headline">Khám phá cơ hội<br><span class="highlight-yellow">nghề nghiệp</span> của bạn</h2>
                <p class="sub-headline">Hơn 5,000+ công việc từ các doanh nghiệp hàng đầu đang chờ đợi sinh viên PTIT tài năng.</p>
            </div>

            <div class="stats-container">
                <div class="stat-item">
                    <div class="stat-icon"><i class="far fa-building"></i></div>
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Doanh nghiệp</div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                    <div class="stat-number">10K+</div>
                    <div class="stat-label">Ứng viên</div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="stat-number">95%</div>
                    <div class="stat-label">Tỉ lệ việc làm</div>
                </div>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <div class="form-container">
            <div class="welcome-badge">
                <i class="fas fa-sparkles"></i> Chào mừng bạn trở lại!
            </div>
            
            <h2 class="form-title">Đăng nhập</h2>
            <p class="form-subtitle">Tiếp tục hành trình sự nghiệp của bạn</p>

            

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${sessionScope.successMsg}
                </div>
                <c:remove var="successMsg" scope="session"/>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form class="login-form" action="${pageContext.request.contextPath}/auth/login" method="post">
                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <div class="input-wrap">
                        <i class="far fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control"
                               value="${email}" placeholder="email@ptit.edu.vn" required autofocus>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Mật khẩu</label>
                    <div class="input-wrap">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="••••••••" required>
                    </div>
                </div>

                <div class="form-options">
                    <label class="checkbox-label">
                        <input type="checkbox" name="remember"> Ghi nhớ đăng nhập
                    </label>
                    <a href="#" class="forgot-link">Quên mật khẩu?</a>
                </div>

                <button type="submit" class="btn-submit">
                    Đăng nhập <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="form-footer">
                Chưa có tài khoản? 
                <a href="${pageContext.request.contextPath}/auth/register">Đăng ký ngay</a>
            </div>

        </div>
    </div>
</div>

<script>
    // Thêm script nhỏ để click qua lại 2 tab cho đẹp UI
    function switchLoginTab(element) {
        document.querySelectorAll('.role-tab').forEach(tab => tab.classList.remove('active'));
        element.classList.add('active');
    }
</script>

</body>
</html>