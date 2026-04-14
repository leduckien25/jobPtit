<%@page import="java.util.Map"%>
<%@page import="model.Job"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobPTIT - Cổng thông tin Việc làm & Thực tập</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root { --ptit-red: #da1f26; }
        body { background-color: #f8f9fa; }
        
        /* Navbar Scaling */
        .navbar { padding: 1.2rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .navbar-brand { font-weight: 800; font-size: 1.8rem; color: var(--ptit-red) !important; }
        .logo-box { background: var(--ptit-red); color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; }
        .nav-link { font-weight: 600; font-size: 1.05rem; margin: 0 10px; color: #333 !important; }
        .nav-link:hover { color: var(--ptit-red) !important; }

        /* Hero & Search */
        .hero-section { background: var(--ptit-red); color: white; padding: 100px 0 140px; text-align: center; }
        .search-wrapper { margin-top: -50px; }
        .search-card { border-radius: 50px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15); padding: 10px; }
        
        /* Category Cards */
        .category-title { font-weight: 700; color: #111827; margin-bottom: 5px; }
        .cat-card { border: none; border-radius: 15px; transition: 0.3s; height: 100%; border: 1px solid #eee; }
        .cat-card:hover { transform: translateY(-8px); box-shadow: 0 10px 20px rgba(0,0,0,0.08); }
        .badge-trend { background: #fff1f0; color: var(--ptit-red); border-radius: 5px; font-weight: bold; }
        
        /* Job Rows */
        .job-item { background: white; border-radius: 12px; border: 1px solid #eee; transition: 0.2s; }
        .job-item:hover { border-color: var(--ptit-red); }
        .btn-ptit { background: var(--ptit-red); color: white; border-radius: 8px; font-weight: 600; }
        .btn-ptit:hover { background: #b3191f; color: white; }
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

    <header class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">Cổng thông tin Việc làm & Thực tập PTIT</h1>
            <p class="lead opacity-75">Kết nối sinh viên với hàng ngàn cơ hội nghề nghiệp từ các doanh nghiệp hàng đầu.</p>
        </div>
    </header>

    <div class="container search-wrapper">
        <div class="card search-card">
            <div class="card-body p-2">
                <form action="jobs" method="get">
                    <div class="row g-2 align-items-center">
                        <div class="col-md-4">
                            <div class="input-group border-0">
                                <span class="input-group-text bg-transparent border-0"><i class="fa fa-search text-muted"></i></span>
                                <input name="jobKeyword" type="text" class="form-control border-0 shadow-none" placeholder="Tên công việc, vị trí...">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <select name="category" class="form-select border-0 border-start shadow-none">
                                <option value="All">Tất cả ngành nghề</option>

                                <%
                                    List<Category> categories = (List<Category>)request.getAttribute("categories");

                                    if(categories != null){
                                        for(Category cat : categories){
                               %>
                                <option value="<%= cat.getSlug()%>"><%= cat.getName() %></option>                           
                               <%
                                        }
                                    }

                               %>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <select name="location" class="form-select border-0 border-start shadow-none" >
                                <option value="All">Tất cả địa điểm</option>
                                <option value="Hà Nội">Hà Nội</option>
                                <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                <option value="Đà Nẵng">Đà Nẵng</option> 
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-ptit w-100 py-3 rounded-pill">Tìm kiếm ngay</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <main class="container my-5 pt-5">
        <div class="d-flex align-items-center mb-4">
            <h2 class="h3 fw-bold text-danger mb-0">Nhu cầu tuyển dụng theo ngành nghề</h2>
        </div>
        <div class="row g-4">
            <%
                Map<Category, Integer> categoryMap = (Map<Category, Integer>)request.getAttribute("categoryMap");
                
                if(categoryMap != null){
                    for(Category cat : categoryMap.keySet()){
                    %>
                        <div class="col-md">
                            <div class="card cat-card p-4">
                                <a class="text-decoration-none" href="/jobPtit/jobs?category=<%=cat.getSlug()%>">
                                    <h5 class="category-title fw-bold"><%=cat.getName()%></h5>
                                    <p class="text-muted"><%=categoryMap.get(cat)%> vị trí đang tuyển</p>
                                </a>
                            </div>
                        </div>
                <%  }
                }
            %>
        </div>

        <h2 class="h3 fw-bold text-danger mt-5 mb-4">Việc làm mới nhất</h2>
        <div class="job-list">
            <%
                List<Job> recentJobs = (ArrayList<Job>)request.getAttribute("recentJobs");
            
                if(recentJobs != null && recentJobs.size() > 0){
                    for(Job job : recentJobs){
                    %>
                        <div class="job-item p-4 mb-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                            <div>
                                <h5 class="fw-bold text-danger mb-1"><%= job.getTitle() %></h5>
                                <p class="mb-0 text-muted"><%= job.getCompany().getName() %> <i class="fa fa-map-marker-alt"></i> Hà Nội <i class="fa fa-clock"></i> 30/03/2026</p>
                            </div>
                            <div class="text-md-end mt-3 mt-md-0">
                                <%
                                    if(job.getSalaryMax() != null && job.getSalaryMin() != null){
                                %>
                                       <span class="h5 fw-bold text-success d-block mb-2"><%= job.getSalaryMin() %> - <%= job.getSalaryMax() %> Triệu
                                <%    }
                                    else{
                                %>
                                       <span class="h5 fw-bold text-success d-block mb-2">Thỏa thuận
                                <%    }
                                %>
                                <a href="jobs/<%=job.getId()%>" class="btn btn-ptit px-4">Ứng tuyển ngay</a>
                            </div>
                        </div>
                    <%
                    }
                }
            %>    
            
            
        </div>
    </main>

    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p class="mb-0 opacity-50 small">© 2026 PTIT JOBS. Developed for Learning Purposes.</p>
        </div>
    </footer>
            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>