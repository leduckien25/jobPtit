<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Job"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PTIT Jobs - Chi tiết công việc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <style>
        :root { --ptit-red: #da1f26; }
        body { background-color: #f8f9fa; }
        
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            flex-direction: column;
        }

        .content-wrapper {
            flex: 1 0 auto;
        }

        footer {
            flex-shrink: 0;
        }
        
        /* Navbar Scaling */
        .navbar { padding: 1.2rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .navbar-brand { font-weight: 800; font-size: 1.8rem; color: var(--ptit-red) !important; }
        .logo-box { background: var(--ptit-red); color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; }
        .nav-link { font-weight: 600; font-size: 1.05rem; margin: 0 10px; color: #333 !important; }
        .nav-link:hover { color: var(--ptit-red) !important; }
        
        
        .job-card { border: none; border-radius: 12px; background: white; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .section-title { border-left: 5px solid var(--ptit-red); padding-left: 15px; margin-bottom: 20px; font-weight: 700; }

        /* NỘI DUNG GỘP CHUNG (CHỈ DÙNG 1 CỘT DESCRIPTION) */
        .job-description-text {
            white-space: pre-line; /* Quan trọng: Giữ xuống dòng từ DB */
            line-height: 1.8;
            color: #444;
            font-size: 1.05rem;
        }

        /* STICKY SIDEBAR */
        .sticky-sidebar {
            position: -webkit-sticky;
            position: sticky;
            top: 20px;
            z-index: 100;
        }

        .btn-apply { background-color: var(--ptit-red); color: white; border: none; padding: 12px 0; font-weight: 600; border-radius: 8px; }
        .btn-apply:hover { background-color: #a50e1e; color: white; }
    </style>
</head>
<body>
    <%
        Job job = (Job)request.getAttribute("job");
    %>
    
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
                    <li class="nav-item"><a class="nav-link" href="#">Việc làm đã nộp</a></li>
                    <li class="nav-item"><a class="nav-link" href="/jobPtit/categories">Ngành nghề</a></li>
                </ul>
                <div class="d-flex align-items-center">
                    <button class="btn btn-outline-secondary rounded-pill px-4 me-3"><i class="fa fa-user me-2"></i>Ứng viên</button>
                    <a href="#" class="text-danger text-decoration-none fw-bold">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row g-4">

            <div class="col-lg-8">
                <div class="job-card p-4 mb-4">
                    <h1 class="fw-bold h2 mb-2"><%=job.getTitle()%></h1>
                    <a href="#" class="text-decoration-none text-muted fs-5 mb-4 d-block">
                        <%= job.getCompany().getName() %>
                    </a>
                    <div class="d-flex gap-4 border-top pt-3">
                        <div>
                            <small class="text-muted d-block">Lương</small>
                            <strong class="text-success">
                                <%= (job.isIsNegotiable() || job.getSalaryMin() == null) ? "Thỏa thuận" : job.getSalaryMin() + " - " + job.getSalaryMax() + " Triệu" %>
                            </strong>
                        </div>
                        <div><small class="text-muted d-block">Địa điểm</small><strong><%=job.getLocation()%></strong></div>
                        <div>
                            <small class="text-muted d-block">Hình thức</small>
                            <strong class="text-dark">
                                <% 
                                    int type = job.getJobType();
                                    if (type == 1) { out.print("Full-Time"); }
                                    else  { out.print("Part-Time"); }
                                %>
                            </strong>
                        </div>
                    </div>
                </div>

                <div class="job-card p-4">
                    <h4 class="section-title">Chi tiết công việc</h4>
                    <div class="job-description-text">
                        <%=job.getDescription()%>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="sticky-sidebar">
                    <div class="job-card p-4 mb-4 text-center">
                        <button class="btn btn-apply w-100 mb-3 shadow">ỨNG TUYỂN NGAY</button>
                        <div class="pt-3 border-top text-start small">
                        <% DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");%>                            
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Ngày đăng:</span>
                                <span class="fw-bold"><%=job.getCreatedAt().format(formatter)%></span>
                            </div>
                            <% 
                                if(job.getExpiredAt() != null){
                            %>       <div class="d-flex justify-content-between">
                                        <span class="text-muted">Hết hạn:</span>
                                        <span class="fw-bold text-danger><%=job.getExpiredAt().format(formatter)%></span>
                                    </div>
                            <%    }
                            %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>