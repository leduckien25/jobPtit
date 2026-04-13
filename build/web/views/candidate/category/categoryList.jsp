<%@page import="java.util.Map"%>
<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám phá nghề nghiệp | PTIT JOBS</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root { --ptit-red: #da1f26; }
        body { background-color: #f8f9fa; }
        
        /* Navbar Scaling */
        .navbar { padding: 1.2rem 0; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .navbar-brand { font-weight: 800; font-size: 1.8rem; color: var(--ptit-red) !important; }
        .logo-box { background: var(--ptit-red); color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; }
        .nav-link { font-weight: 600; font-size: 1.05rem; margin: 0 10px; color: #333 !important; }
        .nav-link:hover { color: var(--ptit-red) !important; }

        
        /* Search Section */
        .search-container { max-width: 600px; margin: 0 auto; position: relative; }
        .search-input { padding: 15px 20px 15px 50px; border-radius: 50px; border: 1px solid #e5e7eb; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        .search-icon { position: absolute; left: 20px; top: 50%; transform: translateY(-50%); color: #9ca3af; }

        /* Category Cards */
        .category-card { 
            background: white; border: 1px solid #f1f1f1; border-radius: 16px; padding: 30px; 
            transition: all 0.3s ease; text-decoration: none; display: block; height: 100%;
        }
        .category-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); border-color: var(--ptit-red); }
        .icon-box { 
            width: 60px; height: 60px; border-radius: 12px; background: #fff5f5; 
            display: flex; align-items: center; justify-content: center; margin-bottom: 20px; 
            color: var(--ptit-red); font-size: 1.8rem; transition: 0.3s;
        }
        .category-card:hover .icon-box { transform: scale(1.1); background: var(--ptit-red); color: white; }
        .category-title { font-weight: 700; color: #111827; margin-bottom: 5px; }
        .job-count { color: #6b7280; font-size: 0.9rem; font-weight: 500; }

        footer { background: #111827; color: #9ca3af; padding: 60px 0 30px; margin-top: 80px; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">
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
                    <a href="${pageContext.request.contextPath}/auth/logout" class="text-danger text-decoration-none fw-bold">Đăng xuất</a>
                </div>
            </div>
        </div>
    </nav>

    
    <main class="container py-5 flex-grow-1"> 
        <div class="text-center mb-5 pb-3">
            <h1 class="display-5 fw-bold text-dark mb-3">Khám phá nghề nghiệp</h1>
            <p class="text-secondary mx-auto" style="max-width: 600px;">Tìm kiếm cơ hội việc làm phù hợp với bạn trong hàng ngàn công việc từ các ngành nghề hot nhất hiện nay.</p>
            <div class="search-container mt-4">
                <i class="bi bi-search search-icon"></i>
                <input type="text" id="searchInput" class="form-control search-input" placeholder="Tìm kiếm ngành nghề...">
            </div>
        </div>

        <div class="row g-4" id="categoryGrid">
            <%
                Map<Category, Integer> categoryMap = (Map<Category, Integer>)request.getAttribute("categoryMap");
            
                if(categoryMap != null){
                    for(Category cat : categoryMap.keySet()){ %>
                        <div class="category-item col-12 col-sm-6 col-md-4 col-lg-3">
                            <a href="/jobPtit/jobs?category=<%= cat.getSlug() %>" class="category-card">
                                <h5 class="category-title text-truncate"><%=cat.getName()%></h5>
                                <p class="job-count mb-0"><%= categoryMap.get(cat) %> việc làm</p>
                            </a>
                        </div>
            <%      }
                }
            %>
        </div>
    </main>

    <footer class="bg-dark text-white py-5 mt-5">
        <div class="container text-center">
            <p class="mb-0 opacity-50 small">© 2026 PTIT JOBS. Developed for Learning Purposes.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.getElementById('searchInput').addEventListener('input', function() {
        let filter = this.value.toLowerCase().trim();

        let items = document.querySelectorAll('.category-item');

        items.forEach(function(item) {
            let title = item.querySelector('.category-title').textContent.toLowerCase();

            if (title.indexOf(filter) > -1) {
                item.style.display = ""; 
                item.style.opacity = "1";
            } else {
                item.style.display = "none"; 
            }
        });

        let visibleItems = Array.from(items).filter(i => i.style.display !== "none");
    });
    </script>
</body>
</html>