<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Duyệt bài đăng | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        :root {
            --primary-red: #ea1e24; --primary-red-hover: #d1151a;
            --bg-color: #f8fafc; --card-bg: #ffffff;
            --text-main: #0f172a; --text-muted: #64748b;
            --border-color: #e2e8f0; --warning: #eab308;
            --success: #22c55e; --danger: #ef4444;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background-color: var(--bg-color); color: var(--text-main); margin: 0; }

        /* --- Navbar & Sidebar --- */
        .top-navbar { height: 64px; background: var(--card-bg); border-bottom: 1px solid var(--border-color); display: flex; align-items: center; justify-content: space-between; padding: 0 30px; position: sticky; top: 0; z-index: 100;}
        .nav-left { display: flex; align-items: center; gap: 30px; }
        .logo-area { display: flex; align-items: center; gap: 10px; text-decoration: none; color: var(--text-main); }
        .logo-icon { width: 32px; height: 32px; background: var(--primary-red); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; }
        .logo-text { font-weight: 800; font-size: 18px; letter-spacing: -0.5px; display: flex; flex-direction: column; line-height: 1; }
        .logo-text span { font-size: 10px; color: var(--text-muted); font-weight: 500; margin-top: 2px;}
        .nav-right { display: flex; align-items: center; gap: 20px; }
        .user-profile { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 500; color: var(--text-muted); }
        .logout-btn { color: var(--primary-red); text-decoration: none; font-size: 14px; font-weight: 500; }

        .page-container { display: flex; min-height: calc(100vh - 64px); }
        .sidebar { width: 250px; background: var(--card-bg); border-right: 1px solid var(--border-color); padding: 20px 10px; flex-shrink: 0;}
        .sidebar-menu { list-style: none; display: flex; flex-direction: column; gap: 5px; }
        .sidebar-menu li a { display: flex; align-items: center; gap: 12px; padding: 12px 20px; text-decoration: none; color: var(--text-muted); font-weight: 500; font-size: 14px; border-radius: 8px; transition: all 0.2s; }
        .sidebar-menu li a i { font-size: 16px; width: 20px; text-align: center; }
        .sidebar-menu li a:hover { background: #f8fafc; color: var(--text-main); }
        .sidebar-menu li a.active { background: var(--primary-red); color: white; }

        /* --- Main Content --- */
        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-header { margin-bottom: 25px; }
        .page-header h1 { font-size: 24px; font-weight: 700; margin-bottom: 5px; }

        /* Toolbar */
        .toolbar { display: flex; gap: 15px; margin-bottom: 25px; align-items: center; }
        .search-input { display: flex; align-items: center; background: white; border: 1px solid var(--border-color); border-radius: 8px; padding: 0 15px; flex: 1; }
        .search-input i { color: var(--text-muted); }
        .search-input input { border: none; outline: none; padding: 12px 10px; width: 100%; font-size: 14px; }
        .filter-select { padding: 10px 15px; border: 1px solid var(--border-color); border-radius: 8px; font-size: 14px; outline: none; background: white; cursor: pointer; }
        .btn-filter { background: var(--primary-red); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; }

        /* --- Job Cards (Đã được cập nhật giống Dashboard) --- */
        .data-list { display: flex; flex-direction: column; gap: 15px; }
        .data-card { 
            background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 12px; padding: 20px 24px; display: flex; 
            justify-content: space-between; align-items: center; 
            transition: all 0.2s ease; cursor: pointer; 
        }
        .data-card:hover { 
            border-color: #cbd5e1; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); 
            transform: translateY(-2px); 
        }
        
        .card-left { display: flex; flex-direction: column; gap: 10px; }
        .card-title-row { display: flex; align-items: center; gap: 12px; }
        .job-title { font-size: 17px; font-weight: 700; color: var(--text-main); }
        
        /* Badges */
        .badge { font-size: 11px; font-weight: 600; padding: 4px 8px; border-radius: 4px; display: inline-flex; align-items: center; gap: 4px;}
        .badge-warning { background: #fef08a; color: #854d0e; }
        .badge-success { background: #dcfce7; color: #166534; }
        .badge-danger { background: #fee2e2; color: #991b1b; }
        .badge-gray { background: #f1f5f9; color: #475569; }

        .job-meta { display: flex; align-items: center; gap: 20px; font-size: 13px; color: var(--text-muted); }
        .job-meta span { display: flex; align-items: center; gap: 6px; }
        .job-meta i { color: #94a3b8; }

        .card-right { display: flex; align-items: center; gap: 30px; }
        .card-dates { font-size: 12px; color: var(--text-muted); text-align: right; line-height: 1.6; }
        .card-stats { display: flex; align-items: center; gap: 15px; font-size: 13px; font-weight: 600; color: var(--text-muted); }
        
        .card-actions { display: flex; gap: 8px; }
        .btn-action { border: none; width: 34px; height: 34px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; font-size: 14px; cursor: pointer; color: white; transition: 0.2s; text-decoration: none; }
        .btn-approve { background: var(--success); }
        .btn-reject { background: var(--danger); }
        .btn-action:hover { opacity: 0.8; transform: translateY(-1px); }

        .alert { padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; font-weight: 500; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }
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
                <li><a href="${pageContext.request.contextPath}/admin/jobs/list" class="active"><i class="fas fa-file-alt"></i> Duyệt bài đăng</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/companies/list"><i class="far fa-building"></i> Quản lý công ty</a></li>
                
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>Quản lý Tin tuyển dụng</h1>
                <p style="color: var(--text-muted); font-size: 14px;">Kiểm duyệt và quản lý tất cả các bài đăng trên hệ thống</p>
            </div>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/jobs/list" method="get" class="toolbar">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tiêu đề công việc hoặc tên công ty...">
                </div>
                <select name="status" class="filter-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="0" ${statusStr == '0' ? 'selected' : ''}>Chờ duyệt</option>
                    <option value="1" ${statusStr == '1' ? 'selected' : ''}>Đang hiển thị</option>
                    <option value="2" ${statusStr == '2' ? 'selected' : ''}>Đã hết hạn</option>
                    <option value="3" ${statusStr == '3' ? 'selected' : ''}>Bị từ chối</option>
                </select>
                <button type="submit" class="btn-filter">Lọc tin</button>
            </form>

            <div class="data-list">
                
                <c:forEach var="j" items="${listJob}">
                    <div class="data-card" onclick="window.location.href='${pageContext.request.contextPath}/admin/jobs/detail?id=${j.id}'">
                        <div class="card-left">
                            <div class="card-title-row">
                                <c:choose>
                                    <c:when test="${j.status == 0}"><span class="badge badge-warning"><i class="fas fa-circle" style="font-size: 6px;"></i> CHỜ DUYỆT</span></c:when>
                                    <c:when test="${j.status == 1}"><span class="badge badge-success"><i class="fas fa-check"></i> ĐANG HIỂN THỊ</span></c:when>
                                    <c:when test="${j.status == 2}"><span class="badge badge-gray"><i class="fas fa-clock"></i> HẾT HẠN</span></c:when>
                                    <c:otherwise><span class="badge badge-danger"><i class="fas fa-ban"></i> TỪ CHỐI</span></c:otherwise>
                                </c:choose>
                                
                                <div class="job-title">${j.title}</div>
                            </div>
                            
                            <div class="job-meta">
                                <span><i class="far fa-building"></i> ${j.companyName}</span>
                                <span><i class="fas fa-map-marker-alt"></i> ${empty j.location ? 'Chưa cập nhật' : j.location}</span>
                                
                                <span><i class="fas fa-dollar-sign"></i> 
                                    <c:choose>
                                        <c:when test="${j.isNegotiable == true}">Thỏa thuận</c:when>
                                        <c:when test="${not empty j.salaryMin and not empty j.salaryMax}">
                                            <fmt:formatNumber value="${j.salaryMin / 1000000}" maxFractionDigits="1"/> - 
                                            <fmt:formatNumber value="${j.salaryMax / 1000000}" maxFractionDigits="1"/> Triệu
                                        </c:when>
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

                        <div class="card-right">
                            <div class="card-stats">
                                <span title="Lượt xem"><i class="far fa-eye"></i> ${j.viewsCount}</span>
                            </div>
                            
                            <div class="card-dates">
                                <fmt:parseDate value="${j.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreate" type="both" />
                                <div>Đăng ngày: <fmt:formatDate value="${parsedCreate}" pattern="yyyy-MM-dd"/></div>

                                <fmt:parseDate value="${j.expiredAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedExpire" type="both" />
                                <div>Hết hạn: <fmt:formatDate value="${parsedExpire}" pattern="yyyy-MM-dd"/></div>
                            </div>
                            
                            <div class="card-actions">
                                <c:if test="${j.status == 0}">
                                    <form action="${pageContext.request.contextPath}/admin/jobs/approve" method="post" style="display:inline;" onclick="event.stopPropagation();">
                                        <input type="hidden" name="id" value="${j.id}">
                                        <button type="submit" class="btn-action btn-approve" title="Duyệt đăng tin"><i class="fas fa-check"></i></button>
                                    </form>
                                </c:if>

                                <c:if test="${j.status == 0 or j.status == 1}">
                                    <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="post" style="display:inline;" onclick="event.stopPropagation(); return confirm('Bạn có chắc muốn từ chối/gỡ bài đăng này?');">
                                        <input type="hidden" name="id" value="${j.id}">
                                        <button type="submit" class="btn-action btn-reject" title="Từ chối / Gỡ bài"><i class="fas fa-times"></i></button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty listJob}">
                    <div style="text-align: center; padding: 50px; background: white; border-radius: 12px; border: 1px solid var(--border-color);">
                        <i class="fas fa-search" style="font-size: 40px; color: #cbd5e1; margin-bottom: 15px;"></i>
                        <p style="color: var(--text-muted);">Không tìm thấy bài đăng nào phù hợp.</p>
                    </div>
                </c:if>

            </div>

            <c:if test="${totalPages > 1}">
                <div style="margin-top: 25px; display: flex; justify-content: flex-end; gap: 5px;">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}&keyword=${keyword}&status=${statusStr}" 
                           style="padding: 8px 12px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 600;
                                  ${page == i ? 'background: var(--primary-red); color: white;' : 'background: white; border: 1px solid var(--border-color); color: var(--text-main);'}">
                            ${i}
                        </a>
                    </c:forEach>
                </div>
            </c:if>

        </main>
    </div>

</body>
</html>