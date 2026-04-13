<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Công ty | PTIT JOBS</title>
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

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-color); color: var(--text-main); }

        /* ----- TOP NAVBAR ----- */
        .top-navbar {
            height: 64px; background: var(--card-bg); border-bottom: 1px solid var(--border-color);
            display: flex; align-items: center; justify-content: space-between; padding: 0 30px;
            position: sticky; top: 0; z-index: 100;
        }
        .nav-left { display: flex; align-items: center; gap: 30px; }
        .logo-area { display: flex; align-items: center; gap: 10px; text-decoration: none; color: var(--text-main); }
        .logo-icon { width: 32px; height: 32px; background: var(--primary-red); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 16px; }
        .logo-text { font-weight: 800; font-size: 18px; letter-spacing: -0.5px; display: flex; flex-direction: column; line-height: 1; }
        .logo-text span { font-size: 10px; color: var(--text-muted); font-weight: 500; margin-top: 2px;}
        .nav-right { display: flex; align-items: center; gap: 20px; }
        .user-profile { display: flex; align-items: center; gap: 8px; font-size: 14px; font-weight: 500; color: var(--text-muted); }
        .logout-btn { color: var(--primary-red); text-decoration: none; font-size: 14px; font-weight: 500; display: flex; align-items: center; gap: 6px; }

        /* ----- LAYOUT ----- */
        .page-container { display: flex; min-height: calc(100vh - 64px); }

        /* ----- SIDEBAR ----- */
        .sidebar { width: 250px; background: var(--card-bg); border-right: 1px solid var(--border-color); padding: 20px 10px; }
        .sidebar-menu { list-style: none; display: flex; flex-direction: column; gap: 5px; }
        .sidebar-menu li a { display: flex; align-items: center; gap: 12px; padding: 12px 20px; text-decoration: none; color: var(--text-muted); font-weight: 500; font-size: 14px; border-radius: 8px; transition: all 0.2s; }
        .sidebar-menu li a i { font-size: 16px; width: 20px; text-align: center; }
        .sidebar-menu li a:hover { background: #f8fafc; color: var(--text-main); }
        .sidebar-menu li a.active { background: var(--primary-red); color: white; }

        /* ----- MAIN CONTENT ----- */
        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-header { margin-bottom: 25px; }
        .page-header h1 { font-size: 24px; font-weight: 700; margin-bottom: 5px; }

        /* Alerts */
        .alert { padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; font-weight: 500; }
        .alert-success { background: #dcfce7; color: #166534; }
        .alert-error { background: #fee2e2; color: #991b1b; }

        /* Toolbar (Search & Filter) */
        .toolbar { display: flex; gap: 15px; margin-bottom: 20px; align-items: center; }
        .search-input { display: flex; align-items: center; background: white; border: 1px solid var(--border-color); border-radius: 8px; padding: 0 15px; flex: 1; }
        .search-input i { color: var(--text-muted); }
        .search-input input { border: none; outline: none; padding: 12px 10px; width: 100%; font-size: 14px; }
        .filter-select { padding: 10px 15px; border: 1px solid var(--border-color); border-radius: 8px; font-size: 14px; outline: none; background: white; cursor: pointer; }
        .btn-filter { background: var(--primary-red); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-filter:hover { background: var(--primary-red-hover); }

        /* Table */
        .table-container { background: white; border-radius: 12px; border: 1px solid var(--border-color); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: #f8fafc; padding: 16px; font-size: 12px; font-weight: 600; color: var(--text-muted); text-transform: uppercase; border-bottom: 1px solid var(--border-color); }
        td { padding: 16px; border-bottom: 1px solid var(--border-color); font-size: 14px; vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        
        /* HIỆU ỨNG DI CHUỘT CHO BẢNG */
        tbody tr { cursor: pointer; transition: 0.2s; }
        tbody tr:hover { background-color: #f1f5f9; }

        /* Badges */
        .badge { padding: 6px 10px; border-radius: 6px; font-size: 12px; font-weight: 600; display: inline-block; }
        .bg-pending { background: #fef08a; color: #854d0e; }
        .bg-approved { background: #dcfce7; color: #166534; }
        .bg-rejected { background: #fee2e2; color: #991b1b; }

        /* Action Buttons */
        .action-form { display: inline-block; margin-right: 5px; }
        .btn-sm { border: none; width: 32px; height: 32px; border-radius: 6px; display: inline-flex; align-items: center; justify-content: center; font-size: 13px; cursor: pointer; color: white; transition: 0.2s; }
        .btn-approve { background: var(--success); }
        .btn-reject { background: var(--danger); }
        .btn-sm:hover { opacity: 0.8; transform: scale(1.05); }

    </style>
</head>
<body>

    <nav class="top-navbar">
        <div class="nav-left">
            <a href="#" class="logo-area">
                <div class="logo-icon">P</div>
                <div class="logo-text">JOBS<span>PTIT.EDU.VN</span></div>
            </a>
        </div>
        <div class="nav-right">
            <div class="user-profile"><i class="far fa-user-circle"></i> Quản trị viên</div>
            <a href="${pageContext.request.contextPath}/auth/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </nav>

    <div class="page-container">
        
        <aside class="sidebar">
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-chart-pie"></i> Tổng quan hệ thống</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/admin/jobs/list">
                    <i class="fas fa-file-alt"></i> Duyệt bài đăng</a>
                </li>
                <li><a href="${pageContext.request.contextPath}/admin/companies/list" class="active">
                    <i class="far fa-building"></i> Quản lý công ty</a>
                </li>
               
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>Quản lý Công ty Doanh nghiệp</h1>
                <p style="color: var(--text-muted); font-size: 14px;">Xét duyệt và quản lý các công ty tham gia tuyển dụng</p>
            </div>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/companies/list" method="get" class="toolbar">
                <div class="search-input">
                    <i class="fas fa-search"></i>
                    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tên công ty hoặc địa chỉ...">
                </div>
                <select name="status" class="filter-select">
                    <option value="">Tất cả trạng thái</option>
                    <option value="0" ${statusStr == '0' ? 'selected' : ''}>Chờ duyệt</option>
                    <option value="1" ${statusStr == '1' ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="2" ${statusStr == '2' ? 'selected' : ''}>Bị khóa</option>
                </select>
                <button type="submit" class="btn-filter">Lọc dữ liệu</button>
            </form>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên Công ty</th>
                            <th>Địa chỉ</th>
                            <th>Ngày đăng ký</th>
                            <th>Trạng thái</th>
                            <th style="text-align: center;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${listCompany}">
                            <tr onclick="window.location.href='${pageContext.request.contextPath}/admin/companies/detail?id=${c.id}'">
                                <td style="color: var(--text-muted); font-weight: 500;">#${c.id}</td>
                                <td style="font-weight: 600; color: var(--text-main);">${c.name}</td>
                                <td>${empty c.location ? '<span style="color:#cbd5e1; font-style:italic;">Chưa cập nhật</span>' : c.location}</td>
                                <td style="color: var(--text-muted);">
                                    <fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.isVerified == 0}"><span class="badge bg-pending">Chờ duyệt</span></c:when>
                                        <c:when test="${c.isVerified == 1}"><span class="badge bg-approved">Đang hoạt động</span></c:when>
                                        <c:otherwise><span class="badge bg-rejected">Bị khóa</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="text-align: center;">
                                    <c:if test="${c.isVerified != 1}">
                                        <form action="${pageContext.request.contextPath}/admin/companies/approve" method="post" class="action-form" onclick="event.stopPropagation();">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <button type="submit" class="btn-sm btn-approve" title="Duyệt công ty"><i class="fas fa-check"></i></button>
                                        </form>
                                    </c:if>
                                    
                                    <c:if test="${c.isVerified != 2}">
                                        <form action="${pageContext.request.contextPath}/admin/companies/reject" method="post" class="action-form" onclick="event.stopPropagation(); return confirm('Bạn có chắc muốn khóa công ty này?');">
                                            <input type="hidden" name="id" value="${c.id}">
                                            <button type="submit" class="btn-sm btn-reject" title="Khóa/Từ chối"><i class="fas fa-ban"></i></button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty listCompany}">
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 40px; color: var(--text-muted);">
                                    <i class="far fa-folder-open" style="font-size: 40px; margin-bottom: 10px; display: block; opacity: 0.5;"></i>
                                    Không tìm thấy dữ liệu công ty nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <c:if test="${totalPages > 1}">
                <div style="margin-top: 20px; display: flex; justify-content: flex-end; gap: 5px;">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="?page=${i}&keyword=${keyword}&status=${statusStr}" 
                           style="padding: 8px 12px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 500;
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