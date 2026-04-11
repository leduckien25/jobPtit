<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Công ty | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        :root {
            --primary-red: #ea1e24; --primary-red-hover: #d1151a;
            --bg-color: #f8fafc; --card-bg: #ffffff;
            --text-main: #0f172a; --text-muted: #64748b;
            --border-color: #e2e8f0; --success: #22c55e; --danger: #ef4444;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        
        /* Đã sửa bỏ display: flex ở body để Navbar về đúng vị trí */
        body { background-color: var(--bg-color); color: var(--text-main); margin: 0; }

        /* --- Navbar --- */
        .top-navbar { height: 64px; background: var(--card-bg); border-bottom: 1px solid var(--border-color); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; position: sticky; top: 0; z-index: 100; width: 100%;}
        .nav-left { display: flex; align-items: center; gap: 30px; }
        .logo-area { display: flex; align-items: center; gap: 10px; text-decoration: none; color: var(--text-main); }
        .logo-icon { width: 32px; height: 32px; background: var(--primary-red); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; }
        .logo-text { font-weight: 800; font-size: 18px; letter-spacing: -0.5px; display: flex; flex-direction: column; line-height: 1; }
        .logo-text span { font-size: 10px; color: var(--text-muted); font-weight: 500; margin-top: 2px;}
        .nav-right { display: flex; align-items: center; gap: 20px; }
        .user-profile { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 500; color: var(--text-muted); }
        .logout-btn { color: var(--primary-red); text-decoration: none; font-size: 14px; font-weight: 500; }

        /* --- Layout chia đôi cột Sidebar và Main --- */
        .page-container { display: flex; min-height: calc(100vh - 64px); width: 100%; }
        
        /* --- Sidebar --- */
        .sidebar { width: 250px; background: var(--card-bg); border-right: 1px solid var(--border-color); padding: 20px 10px; flex-shrink: 0; }
        .sidebar-menu { list-style: none; display: flex; flex-direction: column; gap: 5px; }
        .sidebar-menu li a { display: flex; align-items: center; gap: 12px; padding: 12px 20px; text-decoration: none; color: var(--text-muted); font-weight: 500; font-size: 14px; border-radius: 8px; transition: all 0.2s; }
        .sidebar-menu li a i { font-size: 16px; width: 20px; text-align: center; }
        .sidebar-menu li a:hover { background: #f8fafc; color: var(--text-main); }
        .sidebar-menu li a.active { background: var(--primary-red); color: white; }

        /* --- Main Content --- */
        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        
        .btn-back { display: inline-flex; align-items: center; gap: 8px; color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 500; margin-bottom: 20px; transition: 0.2s; }
        .btn-back:hover { color: var(--primary-red); }

        /* Card Header */
        .profile-header { background: white; border: 1px solid var(--border-color); border-radius: 12px; padding: 30px; display: flex; align-items: flex-start; gap: 25px; margin-bottom: 25px; }
        .company-logo { width: 100px; height: 100px; border-radius: 12px; border: 1px solid var(--border-color); background: #f1f5f9; display: flex; align-items: center; justify-content: center; font-size: 40px; color: #cbd5e1; flex-shrink: 0; overflow: hidden;}
        .company-logo img { width: 100%; height: 100%; object-fit: cover; }
        
        .header-info { flex: 1; }
        .header-title { display: flex; align-items: center; gap: 15px; margin-bottom: 10px; }
        .header-title h1 { font-size: 24px; font-weight: 700; color: var(--text-main); }
        
        .badge { padding: 6px 12px; border-radius: 6px; font-size: 12px; font-weight: 600; }
        .bg-pending { background: #fef08a; color: #854d0e; }
        .bg-approved { background: #dcfce7; color: #166534; }
        .bg-rejected { background: #fee2e2; color: #991b1b; }

        /* Đã sửa CSS lưới thông tin để không bị bóp nghẹt */
        .meta-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-top: 15px; }
        .meta-item { font-size: 14px; color: var(--text-muted); display: flex; align-items: flex-start; gap: 10px; line-height: 1.4; }
        .meta-item i { width: 16px; margin-top: 2px; color: var(--primary-red); flex-shrink: 0; }
        .meta-item span { display: block; }
        .meta-item strong { color: var(--text-main); display: block; margin-top: 2px; font-weight: 600; }

        /* Card Body (Mô tả) */
        .profile-body { background: white; border: 1px solid var(--border-color); border-radius: 12px; padding: 30px; margin-bottom: 25px; }
        .profile-body h3 { font-size: 18px; margin-bottom: 15px; padding-bottom: 15px; border-bottom: 1px solid var(--border-color); }
        .desc-content { font-size: 15px; line-height: 1.6; color: var(--text-muted); white-space: pre-wrap; }

        /* Alert Thông báo */
        .alert { padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; font-weight: 500; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }

        /* Action Form */
        .action-bar { display: flex; gap: 15px; background: white; padding: 20px 30px; border-radius: 12px; border: 1px solid var(--border-color); align-items: center; }
        .btn { padding: 10px 20px; border-radius: 8px; font-weight: 600; font-size: 14px; cursor: pointer; border: none; display: inline-flex; align-items: center; gap: 8px; transition: 0.2s;}
        .btn-approve { background: var(--success); color: white; }
        .btn-reject { background: var(--danger); color: white; }
        .btn:hover { opacity: 0.9; transform: translateY(-1px); }
    </style>
</head>
<body>

    <nav class="top-navbar">
        <div class="nav-left">
            <a href="#" class="logo-area"><div class="logo-icon">P</div><div class="logo-text">JOBS<span>PTIT.EDU.VN</span></div></a>
        </div>
        <div class="nav-right">
            <div class="user-profile"><i class="far fa-user-circle"></i> Quản trị viên</div>
            <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </nav>

    <div class="page-container">
        
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chart-pie"></i> Tổng quan hệ thống</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/jobs/list"><i class="fas fa-file-alt"></i> Duyệt bài đăng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/companies/list" class="active"><i class="far fa-building"></i> Quản lý công ty</a></li>
                
            </ul>
        </aside>

        <main class="main-content">
            
            <a href="${pageContext.request.contextPath}/admin/companies/list" class="btn-back">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <div class="profile-header">
                <div class="company-logo">
                    <c:choose>
                        <c:when test="${not empty company.logoUrl}">
                            <img src="${company.logoUrl}" alt="Logo">
                        </c:when>
                        <c:otherwise>
                            <i class="far fa-building"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="header-info">
                    <div class="header-title">
                        <h1>${company.name}</h1>
                        <c:choose>
                            <c:when test="${company.isVerified == 0}"><span class="badge bg-pending">Chờ duyệt</span></c:when>
                            <c:when test="${company.isVerified == 1}"><span class="badge bg-approved"><i class="fas fa-check-circle"></i> Đang hoạt động</span></c:when>
                            <c:otherwise><span class="badge bg-rejected"><i class="fas fa-ban"></i> Bị khóa</span></c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="meta-grid">
                        
                        <div class="meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Địa chỉ: <strong>${empty company.location ? 'Chưa cập nhật' : company.location}</strong></span>
                        </div>
                        
                        <div class="meta-item">
                            <i class="far fa-calendar-alt"></i>
                            <span>Ngày tạo: <strong><fmt:formatDate value="${company.createdAt}" pattern="dd/MM/yyyy HH:mm"/></strong></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="profile-body">
                <h3>Về công ty ${company.name}</h3>
                <div class="desc-content">
<c:choose><c:when test="${not empty company.description}">${company.description}</c:when><c:otherwise><span style="font-style: italic; opacity: 0.7;">Nhà tuyển dụng chưa cập nhật phần giới thiệu.</span></c:otherwise></c:choose>
                </div>
            </div>

            <div class="action-bar">
                <span style="font-weight: 600; margin-right: 15px;">Thao tác duyệt:</span>
                
                <c:if test="${company.isVerified != 1}">
                    <form action="${pageContext.request.contextPath}/admin/companies/approve" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${company.id}">
                        <button type="submit" class="btn btn-approve"><i class="fas fa-check"></i> Xác nhận & Duyệt</button>
                    </form>
                </c:if>
                
                <c:if test="${company.isVerified != 2}">
                    <form action="${pageContext.request.contextPath}/admin/companies/reject" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${company.id}">
                        <button type="submit" class="btn btn-reject" onclick="return confirm('Bạn có chắc muốn Khóa/Từ chối công ty này? Mọi tin đăng của công ty sẽ bị ẩn.');"><i class="fas fa-ban"></i> Từ chối / Khóa</button>
                    </form>
                </c:if>
            </div>

        </main>
    </div>
</body>
</html>