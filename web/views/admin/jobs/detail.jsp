<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Bài đăng | PTIT JOBS</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        :root {
            --primary-red: #ea1e24; --primary-red-hover: #d1151a;
            --success-green: #16a34a; --success-bg: #dcfce7;
            --bg-color: #f3f4f6; --card-bg: #ffffff;
            --text-main: #1f2937; --text-muted: #6b7280;
            --border-color: #e5e7eb;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background-color: var(--bg-color); color: var(--text-main); margin: 0; }

        /* --- Navbar & Sidebar (Giữ nguyên form hệ thống) --- */
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
        .sidebar-menu li a.active { background: var(--primary-red); color: white; }

        /* --- Main Content Layout --- */
        .main-content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        
        .btn-back { display: inline-flex; align-items: center; gap: 8px; color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 500; margin-bottom: 20px; transition: 0.2s; }
        .btn-back:hover { color: var(--primary-red); }

        .content-grid { display: flex; gap: 24px; align-items: flex-start; }
        .col-left { flex: 1; display: flex; flex-direction: column; gap: 20px; }
        .col-right { width: 340px; flex-shrink: 0; position: sticky; top: 88px; } /* Sticky cho cột phải */

        /* --- UI Components: Cards --- */
        .info-card { background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 12px; padding: 24px; }
        
        /* Left Column: Job Header */
        .job-title { font-size: 22px; font-weight: 700; color: var(--text-main); margin-bottom: 16px; line-height: 1.4; }
        .job-tags { display: flex; flex-wrap: wrap; gap: 16px; margin-bottom: 24px; }
        .job-tag { display: flex; align-items: center; gap: 6px; font-size: 14px; color: var(--text-muted); font-weight: 500; }
        .tag-salary { background: var(--success-bg); color: var(--success-green); padding: 6px 12px; border-radius: 100px; font-weight: 600; }
        
        /* Action Buttons */
        .admin-actions { display: flex; gap: 12px; border-top: 1px solid var(--border-color); padding-top: 20px; }
        .btn { padding: 12px 24px; border-radius: 8px; font-weight: 600; font-size: 15px; cursor: pointer; border: none; display: inline-flex; align-items: center; gap: 8px; transition: 0.2s; text-decoration: none; }
        .btn-approve { background: var(--primary-red); color: white; }
        .btn-approve:hover { background: var(--primary-red-hover); }
        .btn-reject { background: #fee2e2; color: var(--primary-red); border: 1px solid #fca5a5; }
        .btn-reject:hover { background: #fecaca; }

        /* Left Column: Content Sections */
        .section-title { font-size: 18px; font-weight: 700; color: var(--text-main); margin-bottom: 16px; display: flex; align-items: center; gap: 10px; }
        .section-title::before { content: ""; display: block; width: 4px; height: 20px; background-color: var(--primary-red); border-radius: 4px; }
        .section-content { font-size: 15px; line-height: 1.8; color: #4b5563; }
        
        .list-items { list-style: none; padding: 0; margin-top: 10px; }
        .list-items li { display: flex; align-items: flex-start; gap: 10px; margin-bottom: 12px; font-size: 15px; line-height: 1.6; color: #4b5563; }
        .list-items li i.red-check { color: var(--primary-red); margin-top: 4px; }
        .list-items li i.green-check { color: var(--success-green); margin-top: 4px; }

        /* Right Column: Company Info */
        .company-header { display: flex; gap: 16px; margin-bottom: 20px; }
        .company-logo { width: 64px; height: 64px; border-radius: 8px; border: 1px solid var(--border-color); display: flex; align-items: center; justify-content: center; background: #f0f9ff; color: #0284c7; font-size: 24px; font-weight: 700; flex-shrink: 0; overflow: hidden;}
        .company-logo img { width: 100%; height: 100%; object-fit: cover; }
        .company-info h3 { font-size: 16px; font-weight: 700; color: var(--text-main); margin-bottom: 4px; }
        .company-info a { font-size: 13px; color: var(--primary-red); text-decoration: none; font-weight: 500; }
        .company-info a:hover { text-decoration: underline; }

        .company-meta { list-style: none; margin-bottom: 24px; }
        .company-meta li { display: flex; align-items: center; gap: 10px; font-size: 14px; color: #4b5563; margin-bottom: 12px; }
        .company-meta li i { color: #9ca3af; width: 16px; text-align: center; }

        .btn-share { width: 100%; background: white; border: 1px solid var(--border-color); color: var(--text-main); font-weight: 600; padding: 12px; border-radius: 8px; cursor: pointer; display: flex; justify-content: center; align-items: center; gap: 8px; transition: 0.2s; }
        .btn-share:hover { background: #f9fafb; border-color: #d1d5db; }

        /* Alerts */
        .alert { padding: 12px 16px; border-radius: 8px; font-size: 14px; margin-bottom: 20px; font-weight: 500; }
        .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
        .alert-error { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
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
            
            <a href="${pageContext.request.contextPath}/admin/jobs/list" class="btn-back">
                <i class="fas fa-chevron-left"></i> Quay lại danh sách
            </a>

            <c:if test="${not empty sessionScope.successMsg}">
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${sessionScope.successMsg}</div>
                <c:remove var="successMsg" scope="session" />
            </c:if>
            <c:if test="${not empty sessionScope.errorMsg}">
                <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMsg}</div>
                <c:remove var="errorMsg" scope="session" />
            </c:if>

            <div class="content-grid">
                <div class="col-left">
                    
                    <div class="info-card">
                        <div class="job-title">
                            ${job.title} 
                            <c:if test="${job.status == 0}"><span style="font-size: 12px; background: #fef08a; color: #854d0e; padding: 2px 8px; border-radius: 4px; vertical-align: middle; margin-left: 8px;">Chờ duyệt</span></c:if>
                        </div>
                        
                        <div class="job-tags">
                            <div class="job-tag tag-salary">
                                <i class="fas fa-dollar-sign"></i> 
                                <c:choose>
                                    <c:when test="${job.isNegotiable == true}">Thỏa thuận</c:when>
                                    <c:when test="${not empty job.salaryMin}">${job.salaryMin} - ${job.salaryMax} Triệu</c:when>
                                    <c:otherwise>Không công bố</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="job-tag">
                                <i class="fas fa-map-marker-alt"></i> ${empty job.location ? 'Chưa cập nhật' : job.location}
                            </div>
                            <div class="job-tag">
                           
                                <fmt:parseDate value="${j.expiredAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedExpire" type="both" />
                                <div>Hết hạn: <fmt:formatDate value="${parsedExpire}" pattern="yyyy-MM-dd"/></div>
                            </div>
                        </div>

                        <c:if test="${job.status == 0 or job.status == 1}">
                            <div class="admin-actions">
                                <c:if test="${job.status == 0}">
                                    <form action="${pageContext.request.contextPath}/admin/jobs/approve" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${job.id}">
                                        <button type="submit" class="btn btn-approve">
                                            <i class="fas fa-upload"></i> Duyệt tin ngay
                                        </button>
                                    </form>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${job.id}">
                                    <button type="submit" class="btn btn-reject" onclick="return confirm('Xác nhận từ chối/gỡ bỏ tin đăng này?');">
                                        <i class="fas fa-ban"></i> Từ chối / Gỡ bài
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </div>

                    <div class="info-card">
                        <div class="section-title">Mô tả công việc</div>
                        <div class="section-content">
                            <c:choose>
                                <c:when test="${not empty job.description}">${job.description}</c:when>
                                <c:otherwise><span style="font-style: italic; color: #9ca3af;">Người đăng không cung cấp mô tả chi tiết.</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                  

                </div>

                <div class="col-right">
                    <div class="info-card">
                        <div class="company-header">
                            <div class="company-logo">
                                <c:choose>
                                    <c:when test="${not empty job.companyLogo}">
                                        <img src="${job.companyLogo}" alt="Logo">
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:substring(job.companyName, 0, 1)}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="company-info">
                                <h3>${job.companyName}</h3>
                                <a href="${pageContext.request.contextPath}/admin/companies/detail?id=${job.companyId}">Xem trang công ty</a>
                            </div>
                        </div>

                        <ul class="company-meta">
                            <li>
                                <i class="far fa-building"></i>
                                Kinh nghiệm: Chưa yêu cầu
                            </li>
                            <li>
                                <i class="fas fa-layer-group"></i>
                                Cấp bậc: Nhân viên
                            </li>
                            <li>
                                <i class="far fa-calendar-alt"></i>
                                Loại hình: 
                                <c:choose>
                                    <c:when test="${job.jobType == 1}">Toàn thời gian</c:when>
                                    <c:when test="${job.jobType == 2}">Bán thời gian</c:when>
                                    <c:when test="${job.jobType == 3}">Thực tập sinh</c:when>
                                    <c:otherwise>Khác</c:otherwise>
                                </c:choose>
                            </li>
                        </ul>

                        <button class="btn-share" onclick="alert('Đã sao chép liên kết tin tuyển dụng!');">
                            <i class="fas fa-share-alt"></i> Chia sẻ tin tuyển dụng
                        </button>
                    </div>
                </div>

            </div>

        </main>
    </div>
</body>
</html>