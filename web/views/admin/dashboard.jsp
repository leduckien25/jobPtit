<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tổng quan Quản trị | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        :root { --primary-red: #ea1e24; --bg-color: #f8fafc; --card-bg: #ffffff; --text-main: #0f172a; --text-muted: #64748b; --border-color: #e2e8f0; --success: #22c55e; }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background-color: var(--bg-color); color: var(--text-main); }

        /* Khung cơ bản */
        .top-navbar { height: 64px; background: var(--card-bg); border-bottom: 1px solid var(--border-color); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; position: sticky; top: 0; z-index: 100;}
        .nav-left { display: flex; align-items: center; gap: 30px; }
        .logo-area { display: flex; align-items: center; gap: 10px; text-decoration: none; color: var(--text-main); }
        .logo-icon { width: 32px; height: 32px; background: var(--primary-red); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; }
        .logo-text { font-weight: 800; font-size: 18px; line-height: 1; display: flex; flex-direction: column;}
        .logo-text span { font-size: 10px; color: var(--text-muted); margin-top: 2px;}
        .nav-links { display: flex; gap: 20px; }
        .nav-link { text-decoration: none; color: var(--text-muted); font-weight: 500; font-size: 14px; }
        .nav-right { display: flex; align-items: center; gap: 20px; }
        .user-profile { font-size: 14px; font-weight: 500; color: var(--text-muted); }
        .logout-btn { color: var(--primary-red); text-decoration: none; font-size: 14px; font-weight: 500; }

        .page-container { display: flex; min-height: calc(100vh - 64px); }
        .sidebar { width: 250px; background: var(--card-bg); border-right: 1px solid var(--border-color); padding: 20px 10px; flex-shrink: 0;}
        .sidebar-menu { list-style: none; display: flex; flex-direction: column; gap: 5px; }
        .sidebar-menu li a { display: flex; align-items: center; gap: 12px; padding: 12px 20px; text-decoration: none; color: var(--text-muted); font-weight: 500; font-size: 14px; border-radius: 8px; }
        .sidebar-menu li a.active { background: var(--primary-red); color: white; }
        .main-content { flex: 1; padding: 30px 40px; }

        /* 1. Stats Cards */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 12px; padding: 24px; }
        .stat-num { font-size: 32px; font-weight: 700; margin-bottom: 4px; }
        .stat-label { font-size: 13px; color: var(--text-muted); font-weight: 500; }

        /* 2. Style BÀI ĐĂNG CỰC CHUẨN MỚI */
        .section-title { font-size: 16px; margin-bottom: 15px; font-weight: 700; }
        .job-list { display: flex; flex-direction: column; gap: 15px; }
        
        .job-card { 
            background: white; border: 1px solid var(--border-color); border-radius: 12px; 
            padding: 20px 24px; display: flex; justify-content: space-between; align-items: center; 
            cursor: pointer; /* Hiện hình bàn tay khi di chuột */
            transition: all 0.2s ease; /* Tạo hiệu ứng mượt */
        }
        /* Hiệu ứng viền đỏ và nổi bóng khi hover */
        .job-card:hover { 
            border-color: #cbd5e1; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.05); 
            transform: translateY(-2px); 
        }
        
        .jc-left { display: flex; flex-direction: column; gap: 10px; }
        .jc-title-row { display: flex; align-items: center; gap: 12px; }
        .jc-badge { font-size: 11px; font-weight: 700; padding: 4px 8px; border-radius: 4px; }
        .bg-yellow { background: #fef08a; color: #854d0e; }
        .bg-green { background: #dcfce7; color: #166534; }
        .bg-red { background: #fee2e2; color: #991b1b; }
        .jc-title { font-size: 18px; font-weight: 700; color: var(--text-main); }
        
        .jc-meta { display: flex; align-items: center; gap: 15px; font-size: 13px; color: var(--text-muted); }
        .jc-meta span { display: flex; align-items: center; gap: 5px; }
        
        .jc-right { display: flex; align-items: center; gap: 30px; }
        .jc-dates { font-size: 13px; color: var(--text-muted); text-align: right; line-height: 1.6; }
        
        .jc-actions { display: flex; gap: 10px; }
        .btn { padding: 8px 16px; border-radius: 6px; font-weight: 600; font-size: 13px; cursor: pointer; border: none; display: inline-flex; align-items: center; gap: 6px; }
        .btn-approve { background: var(--success); color: white; }
        .btn-reject { background: #fee2e2; color: #ef4444; }
        .btn:hover { opacity: 0.8; }
    </style>
</head>
<body>
    <nav class="top-navbar">
        <div class="nav-left">
            <a href="#" class="logo-area"><div class="logo-icon">P</div><div class="logo-text">JOBS<span>PTIT.EDU.VN</span></div></a>
            <div class="nav-links"><a href="#" class="nav-link">Báo cáo hệ thống</a><a href="#" class="nav-link">Cài đặt</a></div>
        </div>
        <div class="nav-right">
            <div class="user-profile"><i class="far fa-user-circle"></i> Quản trị viên</div>
            <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </nav>

    <div class="page-container">
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><i class="fas fa-chart-pie"></i> Tổng quan hệ thống</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/jobs/list"><i class="fas fa-file-alt"></i> Duyệt bài đăng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/companies/list"><i class="far fa-building"></i> Quản lý công ty</a></li>
                
            </ul>
        </aside>

        <main class="main-content">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-num" style="color: var(--primary-red);">${pendingJobs}</div>
                    <div class="stat-label">Bài đăng chờ duyệt</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num" style="color: #3b82f6;">${pendingCompanies}</div>
                    <div class="stat-label">Công ty chờ xác thực</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num" style="color: var(--success);"><fmt:formatNumber value="${activeJobs}"/></div>
                    <div class="stat-label">Tổng bài đăng (Active)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-num">10K+</div>
                    <div class="stat-label">Ứng viên đã đăng ký</div>
                </div>
            </div>

            <h3 class="section-title">Tin tuyển dụng mới nhất</h3>
            <div class="job-list">
                
                <c:forEach var="j" items="${recentJobs}">
                    <div class="job-card" onclick="window.location.href='${pageContext.request.contextPath}/admin/jobs/detail?id=${j.id}'">
                        <div class="jc-left">
                            <div class="jc-title-row">
                                <c:choose>
                                    <c:when test="${j.status == 0}"><span class="jc-badge bg-yellow">CHỜ DUYỆT</span></c:when>
                                    <c:when test="${j.status == 1}"><span class="jc-badge bg-green">ĐÃ DUYỆT</span></c:when>
                                    <c:otherwise><span class="jc-badge bg-red">TỪ CHỐI</span></c:otherwise>
                                </c:choose>
                                <div class="jc-title">${j.title}</div>
                            </div>
                            <div class="jc-meta">
                                <span><i class="far fa-building"></i> ${j.companyName}</span>
                                <span><i class="fas fa-map-marker-alt"></i> ${empty j.location ? 'Chưa cập nhật' : j.location}</span>
                                <span><i class="fas fa-dollar-sign"></i> 
                                    <c:choose>
                                        <c:when test="${j.isNegotiable == 1}">Thỏa thuận</c:when>
                                        <c:when test="${not empty j.salaryMin}">${j.salaryMin} - ${j.salaryMax} triệu</c:when>
                                        <c:otherwise>Không công bố</c:otherwise>
                                    </c:choose>
                                </span>
                                <span><i class="far fa-clock"></i> 
                                    <c:choose>
                                        <c:when test="${j.jobType == 1}">Full-time</c:when>
                                        <c:when test="${j.jobType == 2}">Part-time</c:when>
                                        <c:when test="${j.jobType == 3}">Internship</c:when>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <div class="jc-right">
                            <div class="jc-dates">
                                <div>Đăng ngày: <fmt:formatDate value="${j.createdAt}" pattern="yyyy-MM-dd"/></div>
                                <div>Hết hạn: <fmt:formatDate value="${j.expiredAt}" pattern="yyyy-MM-dd"/></div>
                            </div>
                            <div class="jc-actions">
                                <c:choose>
                                    <c:when test="${j.status == 0}">
                                        <form action="${pageContext.request.contextPath}/admin/jobs/approve" method="post" style="display:inline;" onclick="event.stopPropagation();">
                                            <input type="hidden" name="id" value="${j.id}">
                                            <button type="submit" class="btn btn-approve"><i class="fas fa-check"></i> Duyệt</button>
                                        </form>
                                        <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="post" style="display:inline;" onclick="event.stopPropagation();">
                                            <input type="hidden" name="id" value="${j.id}">
                                            <button type="submit" class="btn btn-reject"><i class="fas fa-times"></i> Từ chối</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: var(--text-muted); font-style: italic; font-size: 13px;">Đã xử lý</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty recentJobs}">
                    <div style="text-align: center; padding: 30px; color: var(--text-muted);">Hệ thống chưa có tin đăng nào.</div>
                </c:if>
                    
                <c:if test="${totalPages > 1}">
                    <div style="margin-top: 25px; display: flex; justify-content: flex-end; gap: 5px;">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}" 
                               style="padding: 8px 12px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 600;
                                      ${page == i ? 'background: var(--primary-red); color: white;' : 'background: white; border: 1px solid var(--border-color); color: var(--text-main);'}">
                                ${i}
                            </a>
                        </c:forEach>
                    </div>
                </c:if>

            </div>
        </main>
    </div>
</body>
</html>