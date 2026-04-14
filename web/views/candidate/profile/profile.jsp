<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ | PTIT JOBS</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root { --ptit-red: #da1f26; }
        body { background-color: #f8f9fa; }
        
        /* Navbar Styling */
        .navbar { padding: 1.2rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .navbar-brand { font-weight: 800; font-size: 1.8rem; color: var(--ptit-red) !important; }
        .logo-box { background: var(--ptit-red); color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; }
        .nav-link { font-weight: 600; font-size: 1.05rem; margin: 0 10px; color: #333 !important; }
        .nav-link:hover { color: var(--ptit-red) !important; }

        /* Profile Card Styling */
        .profile-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .avatar-wrapper { position: relative; width: 150px; height: 150px; margin: 0 auto 20px; }
        .avatar-img { 
            width: 150px; height: 150px; 
            border-radius: 50%; 
            object-fit: cover; 
            border: 5px solid white; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.1); 
        }
        .avatar-placeholder {
            width: 150px; height: 150px;
            border-radius: 50%;
            background: #fff1f0;
            color: var(--ptit-red);
            display: flex; align-items: center; justify-content: center;
            font-size: 3rem; font-weight: bold;
            border: 5px solid white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .btn-ptit { background: var(--ptit-red); color: white; border-radius: 12px; font-weight: 600; padding: 12px 30px; border: none; }
        .btn-ptit:hover { background: #b3191f; color: white; }
        
        .form-label { font-weight: 600; color: #444; margin-bottom: 8px; }
        .form-control { border-radius: 10px; padding: 12px; border: 1px solid #eee; }
        .form-control:focus { border-color: var(--ptit-red); box-shadow: 0 0 0 0.25rem rgba(218, 31, 38, 0.1); }
        
        .upload-section { background: #fcfcfc; border-radius: 15px; padding: 20px; border: 1px dashed #ddd; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="/jobPtit/">
                <span class="logo-box">P</span> JOBS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item"><a class="nav-link" href="/jobPtit/">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="/jobPtit/applied-jobs">Việc làm đã nộp</a></li>
                    <li class="nav-item"><a class="nav-link" href="/jobPtit/categories">Ngành nghề</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary rounded-pill px-4 me-3"><i class="fa fa-user me-2"></i>Ứng viên</a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="text-danger text-decoration-none fw-bold">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card profile-card p-4 p-md-5">
                    <h2 class="h3 fw-bold text-dark mb-4 text-center">Chỉnh sửa thông tin cá nhân</h2>

                    <form method="post" action="profile" enctype="multipart/form-data" accept-charset="UTF-8">
                        
                        <div class="text-center mb-5">
                            <div class="avatar-wrapper">
                                <c:choose>
                                    <c:when test="${profile != null && profile.avatarUrl != null}">
                                        <img src="${pageContext.request.contextPath}/${profile.avatarUrl}" class="avatar-img" id="previewImg">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="avatar-placeholder">${profile.fullName.substring(0,1)}</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="mt-3">
                                <label for="avatar" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                                    <i class="fa fa-camera me-2"></i>Thay đổi ảnh đại diện
                                </label>
                                <input type="file" name="avatar" id="avatar" class="d-none" accept="image/*">
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" name="fullName" value="${profile.fullName}" class="form-control" placeholder="Nhập họ tên">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Vị trí ứng tuyển</label>
                                <input type="text" name="title" value="${profile.title}" class="form-control" placeholder="VD: Java Developer">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="phone" value="${profile.phone}" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" name="location" value="${profile.location}" class="form-control">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Giới thiệu bản thân</label>
                                <textarea name="aboutMe" rows="4" class="form-control" placeholder="Chia sẻ ngắn gọn về kinh nghiệm và mục tiêu của bạn...">${profile.aboutMe}</textarea>
                            </div>
                        </div>

                        <div class="upload-section mt-5 mb-4">
                            <label class="form-label d-block"><i class="fa fa-file-pdf text-danger me-2"></i>Hồ sơ CV (PDF)</label>
                            <c:if test="${profile != null && profile.cvUrl != null}">
                                <div class="mb-3">
                                    <a href="${pageContext.request.contextPath}/${profile.cvUrl}" target="_blank" class="text-danger text-decoration-none small fw-bold">
                                        <i class="fa fa-eye me-1"></i> Xem CV hiện tại của bạn
                                    </a>
                                </div>
                            </c:if>
                            <input type="file" name="cv" class="form-control" accept=".pdf">
                            <small class="text-muted mt-2 d-block text-center">Nên sử dụng định dạng PDF để giữ nguyên định dạng hồ sơ.</small>
                        </div>

                        <div class="text-center mt-5">
                            <button type="submit" class="btn btn-ptit px-5 w-100">
                                <i class="fa fa-save me-2"></i>Lưu thay đổi hồ sơ
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0 opacity-50 small">© 2026 Học viện Công nghệ Bưu chính Viễn thông. Developed for Learning Purposes.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>