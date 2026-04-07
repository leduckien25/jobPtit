<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="model.Job"%>
<%@page import="dto.JobFilter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PTIT Jobs - Danh sách công việc</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
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
        
        /* Job Card Styling */
        .job-item { background: white; border-radius: 12px; border: 1px solid #eee; transition: 0.2s; }
        .job-item:hover { border-color: var(--ptit-red); }
        .btn-ptit { background: var(--ptit-red); color: white; border-radius: 8px; font-weight: 600; }
        .btn-ptit:hover { background: #b3191f; color: white; }

        .page-link {
            color: #333;
            padding: 10px 18px;
            font-weight: 600;
        }
        .page-item.active .page-link {
            background-color: var(--ptit-red);
            border-color: var(--ptit-red);
            color: white;
        }
        .page-link:hover {
            background-color: #eee;
            color: var(--ptit-red);
        }
        
        .sticky-sidebar { position: sticky; top: 100px; }
    </style>
</head>
<body>
    <%
        JobFilter filter = (JobFilter)request.getAttribute("filter");
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
    
    <%
        List<Job> jobs = (List<Job>)request.getAttribute("jobs");
    %>

    <div class="content-wrapper container py-5">
        <div class="row g-4">
            
            <aside class="col-lg-3">
                <div class="card border-0 shadow-sm p-4 sticky-sidebar rounded-4">
                    <h5 class="fw-bold mb-4"><i class="fa fa-sliders text-ptit me-2"></i>Bộ lọc</h5>
                    <form id="mainFilterForm" action="jobs" method="get">
                        <input type="hidden" name="sort" id="sortField" value="<%=filter.getSort() != null ? filter.getSort() : "newest"%>">
                        <input type="hidden" name="page" id="pageField" value="<%=filter.getPage()%>">
                        
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Từ khóa</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-0"><i class="fa fa-search text-muted"></i></span>
                                <input name="jobKeyword" type="text" value="<%=filter.getKeyword() != null ? filter.getKeyword() : "" %>" class="form-control bg-light border-0 shadow-none" placeholder="Tên công việc...">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Ngành nghề</label>
                            <select name="category" class="form-select bg-light border-0 shadow-none" onchange="this.form.submit()">
                                <option value="All" ${filter.getCategorySlug() == null ? 'selected' : ''}>
                                    Tất cả ngành nghề
                                </option>
                                <%
                                    List<Category> categories = (List<Category>)request.getAttribute("categories");
                                    
                                    for(Category cat : categories){ %>
                                        <option value="<%=cat.getSlug()%>" <%= filter.getCategorySlug() != null && filter.getCategorySlug().equals(cat.getSlug()) ? "selected" : ""%>>
                                                <%=cat.getName()%>
                                        </option>
                                <%    }
                                %>
                            </select>
                        </div>   
                            
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Địa điểm</label>
                            <select name="location" class="form-select bg-light border-0 shadow-none" onchange="this.form.submit()">
                                <option value="" <%= (filter.getLocation() == null || filter.getLocation().equals("All")) ? "selected" : "" %>>
                                    Tất cả địa điểm
                                </option>                                
                                <option value="Hà Nội" <%= (filter.getLocation() != null && filter.getLocation().equals("Hà Nội")) ? "selected" : "" %>>Hà Nội</option>
                                <option value="TP. Hồ Chí Minh" <%= (filter.getLocation() != null && filter.getLocation().equals("TP. Hồ Chí Minh")) ? "selected" : "" %>>TP. Hồ Chí Minh</option>
                                <option value="Đà Nẵng" <%= (filter.getLocation() != null && filter.getLocation().equals("Đà Nẵng")) ? "selected" : "" %>>Đà Nẵng</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Mức lương</label>
                            <select name="salaryRange" class="form-select bg-light border-0 shadow-none" onchange="this.form.submit()">
                                <option value="" ${filter.salaryRange == "All" ? "selected" : ""}>Tất cả mức lương</option>
                                <option value="0-10" ${filter.salaryRange == "0-10" ? "selected" : ""}>Dưới 10 triệu</option>
                                <option value="10-20" ${filter.salaryRange == "10-20" ? "selected" : ""}>10 - 20 triệu</option>
                                <option value="20-50" ${filter.salaryRange == "20-50" ? "selected" : ""}>20 - 50 triệu</option>
                                <option value="50+" ${filter.salaryRange == "50- " ? "selected" : ""}>Trên 50 triệu</option>
                                <option value="negotiable" ${filter.salaryRange == 'negotiable' ? "selected" : ""}>Thỏa thuận</option>
                            </select>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-secondary">Hình thức làm việc</label>
                            <div class="form-check small mb-1">
                                <input class="form-check-input" type="checkbox" name="jobType" value="1" id="ft" <%= filter.getJobType().contains("1") ? "checked" : ""%>>
                                <label class="form-check-label" for="ft">Full-time</label>
                            </div>
                            <div class="form-check small mb-1">
                                <input class="form-check-input" type="checkbox" name="jobType" value="2" id="pt" <%= filter.getJobType().contains("2") ? "checked" : ""%>>
                                <label class="form-check-label" for="pt">Part-time</label>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-ptit w-100 py-2 shadow-sm">Tìm kiếm ngay</button>
                    </form>
                </div>
            </aside>

            <main class="col-lg-9">
                <div class="d-flex justify-content-end align-items-center mb-4">
                    <div class="dropdown">
                        <button class="btn btn-white btn-sm border dropdown-toggle shadow-sm px-3" 
                                type="button" 
                                data-bs-toggle="dropdown" 
                                aria-expanded="false">
                            <i class="fa fa-sort-amount-down me-2 text-secondary"></i>
                            Sắp xếp: <span class="fw-semibold">${filter.sort == 'oldest' ? 'Cũ nhất' : 'Mới nhất'}</span>
                        </button>
                        
                        <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                            <li>
                                <a class="dropdown-item py-2 ${filter.sort != 'oldest' ? 'active' : ''}" 
                                href="javascript:void(0)" onclick="applySort('newest')">
                                <i class="fa fa-clock me-2"></i>Mới nhất
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item py-2 ${filter.sort == 'oldest' ? 'active' : ''}" 
                                href="javascript:void(0)" onclick="applySort('oldest')">
                                <i class="fa fa-history me-2"></i>Cũ nhất
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="d-flex flex-column gap-3">
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        if(jobs != null && jobs.size() > 0){
                           for(Job job : jobs){ %>
                                <div class="job-item p-4 mb-3 d-flex flex-column flex-md-row justify-content-between align-items-center">
                                    <div>
                                        <h5 class="fw-bold text-danger mb-1"><%= job.getTitle() %></h5>
                                        <p class="mb-0 text-muted"><%= job.getCompany().getName() %> <i class="fa fa-map-marker-alt"></i> <%=job.getLocation()%> <i class="fa fa-clock"></i> <%=job.getCreatedAt().format(formatter)%></p>
                                    </div>
                                    <div class="text-md-end mt-3 mt-md-0">
                                        <%
                                            if(job.getSalaryMax() != null && job.getSalaryMin() != null){
                                        %>
                                               <span class="h5 fw-bold text-success d-block mb-2"><%= job.getSalaryMin() %> - <%= job.getSalaryMax() %> Triệu
                                        <%    }
                                            else{
                                        %>
                                               <span class="h5 fw-bold text-success d-block mb-2">Thoả thuận
                                        <%    }
                                        %>
                                        <a href="jobs/<%=job.getId()%>" class="btn btn-ptit px-4">Ứng tuyển ngay</a>
                                    </div>
                                </div>
                        <%   }
                        }
                    %>
                    
                    <nav aria-label="Page navigation" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <%
                                int totalPages = (int)request.getAttribute("totalPages");
                                for(int i=1;i<=totalPages;i++){
                                    %>
                                    <li class="page-item <%=filter.getPage() == i ? "active": ""%>">
                                        <a class="page-link border-0 shadow-sm rounded-3 me-2 bg-ptit" href="javascript:void(0)" onclick="applyPage('<%=i%>')"><%=i%></a>
                                    </li>
                                    <%
                                }
                            %>
                        </ul>
                    </nav>
                </div>
            </main>
        </div>
    </div>
    
    <footer class="bg-dark text-white py-5 mt-5">
        <div class="container text-center">
            <p class="mb-0 opacity-50 small">© 2026 PTIT JOBS. Developed for Learning Purposes.</p>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function applySort(sortType) {
            document.getElementById('sortField').value = sortType;

            document.getElementById('mainFilterForm').submit();
        }
        function applyPage(page){
            document.getElementById('pageField').value = page;
            
            document.getElementById('mainFilterForm').submit();
        }
    </script>
</body>
</html>