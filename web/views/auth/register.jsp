<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký | PTIT JOBS</title>
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

        /* ----- Layout Chia Đôi ----- */
        .split-layout { display: flex; width: 100%; min-height: 100vh; }

        /* ----- Cột Trái (Banner) ----- */
        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #e31818 0%, #f04e23 100%);
            color: white; padding: 60px;
            display: flex; flex-direction: column; position: relative; overflow: hidden;
        }

        .bg-circle-1 { position: absolute; width: 500px; height: 500px; background: rgba(255, 255, 255, 0.08); border-radius: 50%; top: 20%; left: -10%; z-index: 1; }
        .bg-circle-2 { position: absolute; width: 450px; height: 450px; background: rgba(255, 255, 255, 0.06); border-radius: 50%; bottom: -15%; right: -10%; z-index: 1; }

        .left-content { position: relative; z-index: 2; height: 100%; display: flex; flex-direction: column; }
        .logo-container { display: flex; align-items: center; gap: 12px; margin-bottom: 50px; }
        .logo-icon { width: 44px; height: 44px; background: white; color: var(--primary-red); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: 800; }
        .logo-text h1 { font-size: 22px; font-weight: 800; letter-spacing: 0.5px; }
        .logo-text p { font-size: 13px; opacity: 0.9; margin-top: 2px; font-weight: 500;}

        .main-headline { font-size: 42px; font-weight: 800; line-height: 1.3; margin-bottom: 15px; }
        .highlight-yellow { color: var(--accent-yellow); }
        .sub-headline { font-size: 15px; line-height: 1.6; opacity: 0.9; max-width: 400px; margin-bottom: 40px; }

        /* Danh sách tính năng (Banner) */
        .feature-list { display: flex; flex-direction: column; gap: 15px; }
        .feature-item {
            background: rgba(255, 255, 255, 0.15);
            padding: 16px 20px; border-radius: 12px;
            display: flex; align-items: center; gap: 15px;
            font-weight: 600; font-size: 15px;
        }
        .feature-item i { font-size: 18px; width: 24px; text-align: center; }

        /* ----- Cột Phải (Form) ----- */
        .right-panel {
            flex: 1; display: flex; align-items: center; justify-content: center;
            padding: 40px; background: var(--bg-body); overflow-y: auto;
        }
        .form-container { width: 100%; max-width: 420px; display: flex; flex-direction: column; align-items: center; margin: auto; }

        .welcome-badge {
            background: #dcfce7; color: #166534; padding: 6px 16px; border-radius: 20px;
            font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; gap: 6px; margin-bottom: 16px;
        }
        .form-title { font-size: 28px; font-weight: 800; color: var(--text-dark); margin-bottom: 8px; }
        .form-subtitle { font-size: 14px; color: var(--text-gray); margin-bottom: 30px; }

        /* Tabs Chọn Vai Trò */
        .role-tabs {
            display: flex; width: 100%; border: 1px solid var(--border-color);
            border-radius: 10px; padding: 4px; margin-bottom: 25px;
        }
        .role-tab {
            flex: 1; padding: 12px; text-align: center; font-size: 14px; font-weight: 600;
            border-radius: 6px; cursor: pointer; color: var(--text-gray); transition: all 0.2s;
        }
        .role-tab i { margin-right: 8px; }
        .role-tab.active { background: var(--primary-red); color: white; box-shadow: 0 4px 10px rgba(234, 30, 36, 0.3); }

        /* Alerts */
        .alert { width: 100%; padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .alert-error { background: #fee2e2; color: #991b1b; }

        /* Inputs */
        .register-form { width: 100%; }
        .form-group { margin-bottom: 18px; }
        .form-label { display: block; font-size: 13px; font-weight: 600; color: var(--text-dark); margin-bottom: 8px; }
        
        .input-wrap { position: relative; }
        .input-wrap i { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 14px; }
        .form-control {
            width: 100%; padding: 12px 16px 12px 42px; border: 1px solid var(--border-color);
            border-radius: 8px; font-size: 14px; color: var(--text-dark); outline: none; transition: border-color 0.2s;
        }
        .form-control::placeholder { color: #cbd5e1; }
        .form-control:focus { border-color: var(--primary-red); }

        /* Checkbox Điều khoản */
        .terms-group { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 25px; font-size: 13px; color: var(--text-gray); line-height: 1.5; }
        .terms-group input { margin-top: 3px; cursor: pointer; }
        .terms-group a { color: var(--primary-red); font-weight: 600; text-decoration: none; }
        .terms-group a:hover { text-decoration: underline; }

        .btn-submit {
            width: 100%; padding: 14px; background: var(--primary-red); color: white;
            border: none; border-radius: 8px; font-size: 15px; font-weight: 600;
            cursor: pointer; display: flex; justify-content: center; align-items: center; gap: 8px; transition: background 0.2s;
        }
        .btn-submit:hover { background: var(--primary-red-hover); }

        .form-footer { margin-top: 30px; text-align: center; font-size: 14px; color: var(--text-gray); }
        .form-footer a { color: var(--primary-red); font-weight: 700; text-decoration: none; }
        .form-footer a:hover { text-decoration: underline; }
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
                <h2 class="main-headline">
                    Bắt đầu hành trình<br>
                    <span class="highlight-yellow">sự nghiệp</span> của bạn
                </h2>
                <p class="sub-headline">Tham gia cộng đồng sinh viên PTIT và doanh nghiệp hàng đầu Việt Nam.</p>
            </div>

            <div id="candidate-features" class="feature-list">
                <div class="feature-item"><i class="fas fa-bolt"></i> Truy cập 5,000+ việc làm</div>
                <div class="feature-item"><i class="fas fa-shield-alt"></i> Bảo mật thông tin cá nhân</div>
                <div class="feature-item"><i class="fas fa-check-circle"></i> Ứng tuyển nhanh chóng</div>
            </div>

            <div id="recruiter-features" class="feature-list" style="display: none;">
                <div class="feature-item"><i class="fas fa-users"></i> Tiếp cận 10,000+ ứng viên</div>
                <div class="feature-item"><i class="fas fa-tag"></i> Đăng tin miễn phí</div>
                <div class="feature-item"><i class="fas fa-tasks"></i> Quản lý tuyển dụng dễ dàng</div>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <div class="form-container">
            <div class="welcome-badge">
                <i class="fas fa-magic"></i> Tạo tài khoản mới
            </div>
            
            <h2 class="form-title">Đăng ký</h2>
            <p class="form-subtitle">Chọn vai trò và bắt đầu ngay</p>

            <div class="role-tabs">
                <div id="tab-candidate" class="role-tab active" onclick="switchRole(1)"><i class="fas fa-user-graduate"></i> Ứng viên</div>
                <div id="tab-recruiter" class="role-tab" onclick="switchRole(2)"><i class="fas fa-briefcase"></i> Nhà tuyển dụng</div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <form class="register-form" action="${pageContext.request.contextPath}/auth/register" method="post">
                <input type="hidden" id="roleInput" name="role" value="1">

                <div class="form-group">
                    <label class="form-label" for="email">Email</label>
                    <div class="input-wrap">
                        <i class="far fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="email@ptit.edu.vn" required>
                    </div>
                </div>

                <div class="form-group" id="companyGroup" style="display: none;">
                    <label class="form-label" for="companyName">Tên công ty</label>
                    <div class="input-wrap">
                        <i class="far fa-building"></i>
                        <input type="text" id="companyName" name="companyName" class="form-control" placeholder="Công ty CP Công nghệ...">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Mật khẩu</label>
                    <div class="input-wrap">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required minlength="6">
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="passwordConfirm">Nhập lại mật khẩu</label>
                    <div class="input-wrap">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="passwordConfirm" name="password2" class="form-control" placeholder="••••••••" required minlength="6">
                    </div>
                </div>

                <div class="terms-group">
                    <input type="checkbox" id="terms" required>
                    <label for="terms">Tôi đồng ý với <a href="#">Điều khoản sử dụng</a> và <a href="#">Chính sách bảo mật</a></label>
                </div>

                <button type="submit" class="btn-submit">
                    Tạo tài khoản <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="form-footer">
                Đã có tài khoản? 
                <a href="${pageContext.request.contextPath}/auth/login">Đăng nhập ngay</a>
            </div>
        </div>
    </div>
</div>

<script>
    function switchRole(role) {
        // Cập nhật giá trị gửi về Java Backend
        document.getElementById('roleInput').value = role;

        // Xử lý giao diện Tab
        document.getElementById('tab-candidate').classList.remove('active');
        document.getElementById('tab-recruiter').classList.remove('active');

        // Khai báo các vùng cần thay đổi
        const candidateFeatures = document.getElementById('candidate-features');
        const recruiterFeatures = document.getElementById('recruiter-features');
        const companyGroup = document.getElementById('companyGroup');
        const companyInput = document.getElementById('companyName');

        if (role === 1) {
            // Chế độ Ứng viên
            document.getElementById('tab-candidate').classList.add('active');
            
            candidateFeatures.style.display = 'flex';
            recruiterFeatures.style.display = 'none';
            
            companyGroup.style.display = 'none';
            companyInput.removeAttribute('required'); // Bỏ yêu cầu bắt buộc nhập
        } else {
            // Chế độ Nhà tuyển dụng
            document.getElementById('tab-recruiter').classList.add('active');
            
            candidateFeatures.style.display = 'none';
            recruiterFeatures.style.display = 'flex';
            
            companyGroup.style.display = 'block';
            companyInput.setAttribute('required', 'true'); // Bắt buộc phải nhập tên công ty
        }
    }
</script>

</body>
</html>