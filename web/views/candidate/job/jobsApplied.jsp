<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việc làm đã nộp - JobPTIT</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root { --ptit-red: #da1f26; }
        body { background-color: #f8f9fa; min-height: 100vh; display: flex; flex-direction: column; }
        
        /* Navbar */
        .navbar { padding: 1.2rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .navbar-brand { font-weight: 800; font-size: 1.8rem; color: var(--ptit-red) !important; }
        .logo-box { background: var(--ptit-red); color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; }
        .nav-link { font-weight: 600; font-size: 1.05rem; margin: 0 10px; color: #333 !important; }

        /* Header */
        .page-header { background: white; padding: 40px 0; border-bottom: 1px solid #eee; margin-bottom: 40px; }
        
        /* Table Style */
        .applied-card { background: white; border-radius: 15px; border: none; box-shadow: 0 5px 15px rgba(0,0,0,0.05); overflow: hidden; }
        .table thead { background: #fdf2f2; }
        .table thead th { border: none; padding: 15px; color: #555; font-weight: 600; }
        .table tbody td { padding: 20px 15px; vertical-align: middle; border-bottom: 1px solid #f1f1f1; }
        
        /* Status Badges */
        .status-badge { padding: 6px 12px; border-radius: 50px; font-size: 0.85rem; font-weight: 600; display: inline-block; }
        .status-0 { background: #fff4e5; color: #ff9800; } /* Đang chờ */
        .status-4 { background: #e6fcf5; color: #0ca678; } /* Trúng tuyển */
        .status-3 { background: #fff5f5; color: #fa5252; } /* Từ chối */
        .status-default { background: #f1f3f5; color: #868e96; } /* Đã xem/Khác */

        .btn-delete { color: var(--ptit-red); border: 1px solid var(--ptit-red); border-radius: 8px; font-size: 0.85rem; padding: 5px 12px; text-decoration: none; transition: 0.3s; }
        .btn-delete:hover { background: var(--ptit-red); color: white; }
        
        footer { margin-top: auto; }
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
                    <li class="nav-item"><a class="nav-link" href="/jobPtit//applied-jobs">Việc làm đã nộp</a></li>
                    <li class="nav-item"><a class="nav-link" href="/jobPtit/categories">Ngành nghề</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary rounded-pill px-4 me-3"><i class="fa fa-user me-2"></i>Ứng viên</a>
                    <a href="${pageContext.request.contextPath}/auth/logout" class="text-danger text-decoration-none fw-bold">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    <header class="page-header">
        <div class="container">
            <h1 class="h2 fw-bold mb-0">Lịch sử ứng tuyển</h1>
            <p class="text-muted mb-0">Danh sách các công việc bạn đã gửi hồ sơ thành công.</p>
        </div>
    </header>

    <main class="container mb-5">
        <div class="applied-card card">
            <div class="table-responsive">
                <table class="table mb-0">
                    <thead>
                        <tr>
                            <th>Vị trí ứng tuyển</th>
                            <th>Công ty</th>
                            <th>Ngày nộp</th>
                            <th>Trạng thái</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${appliedList}" var="app">
                            <tr>
                                <td>
                                    <h6 class="fw-bold mb-0 text-dark">${app.jobTitle}</h6>
                                </td>
                                <td>
                                    <span class="text-muted"><i class="far fa-building me-1"></i>${app.companyName}</span>
                                </td>
                                <td>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${app.appliedAt}" pattern="dd/MM/yyyy HH:mm"/>
                                    </small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${app.status == 0}">
                                            <span class="status-badge status-0">Đang chờ</span>
                                        </c:when>
                                        <c:when test="${app.status == 4}">
                                            <span class="status-badge status-4">Đã trúng tuyển</span>
                                        </c:when>
                                        <c:when test="${app.status == 3}">
                                            <span class="status-badge status-3">Đã bị từ chối</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-default">Đã xem</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center align-middle">
                                    <c:if test="${app.status == 0}">
                                        <form action="${pageContext.request.contextPath}/DeleteApplication" method="POST" 
                                              onsubmit="return confirm('Hành động này sẽ rút hồ sơ của bạn khỏi vị trí này. Bạn chắc chắn chứ?')" 
                                              class="d-inline-block m-0">
                                            <input type="hidden" name="appId" value="${app.id}">
                                            <button type="submit" class="btn-cancel-custom">
                                                <i class="fa-regular fa-circle-xmark me-1"></i> Hủy đơn
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${app.status != 0}">
                                        <span class="text-muted small italic"><i class="fa fa-lock me-1"></i>Khóa</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty appliedList}">
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <p class="text-muted">Bạn chưa ứng tuyển công việc nào.</p>
                                    <a href="${pageContext.request.contextPath}/" class="btn btn-danger rounded-pill px-4">Tìm việc ngay</a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p class="mb-0 opacity-50 small">© 2026 PTIT JOBS. Developed for Learning Purposes.</p>
        </div>
    </footer>

</body>
</html>