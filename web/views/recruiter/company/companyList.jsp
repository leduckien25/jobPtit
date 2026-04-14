<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách công ty | PTIT JOBS</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ptit-red': '#da1f26',
                        'ptit-hover': '#b3191f',
                    }
                }
            }
        }
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; color: #333; }
        .logo-box { background: #da1f26; color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; font-weight: 800; }
        .company-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        .company-card:hover { transform: translateY(-5px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); }
    </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

    <nav class="bg-white shadow-sm border-b border-gray-100 py-4 sticky top-0 z-50">
        <div class="container mx-auto px-5 flex justify-between items-center">
            <a class="flex items-center text-2xl font-extrabold text-ptit-red" href="${pageContext.request.contextPath}/home">
                <span class="logo-box">P</span> JOBS
            </a>
            
            <div class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/home" class="font-bold text-gray-500 hover:text-ptit-red transition text-sm uppercase tracking-wider">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/companies" class="font-bold text-ptit-red border-b-2 border-ptit-red pb-1 text-sm uppercase tracking-wider">Công ty</a>
                <div class="h-6 w-px bg-gray-200"></div>
                <a href="${pageContext.request.contextPath}/profile" class="text-gray-700 hover:text-ptit-red transition font-bold text-sm uppercase tracking-wider">Ứng viên</a>
            </div>
        </div>
    </nav>

    <main class="flex-grow py-12">
        <div class="container mx-auto px-4 text-center mb-16">
            <h1 class="text-4xl font-extrabold text-gray-900 mb-4 uppercase tracking-tight">Hệ sinh thái doanh nghiệp</h1>
            <p class="text-gray-500 max-w-2xl mx-auto font-medium">Kết nối với hàng trăm đối tác chiến lược của PTIT để tìm kiếm cơ hội thực tập và làm việc chuyên nghiệp.</p>
        </div>

        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach items="${companies}" var="c">
                    <div class="bg-white rounded-2xl p-6 border border-gray-100 shadow-sm company-card flex flex-col justify-between">
                        <div>
                            <div class="flex items-start gap-5 mb-6">
                                <div class="w-20 h-20 rounded-xl bg-gray-50 p-2 flex-shrink-0 border border-gray-100 flex items-center justify-center overflow-hidden">
                                    <img src="${pageContext.request.contextPath}/${c.logoUrl}" 
                                         alt="${c.name}" 
                                         class="w-full h-full object-contain"
                                         onerror="this.src='https://placehold.co/100x100?text=Logo'">
                                </div>
                                
                                <div class="flex-1 min-w-0">
                                    <div class="flex items-center gap-2 mb-1">
                                        <c:if test="${c.isVerified == 1}">
                                            <span class="bg-blue-50 text-blue-600 text-[10px] font-black uppercase px-2 py-0.5 rounded flex items-center gap-1">
                                                <i class="fa fa-check-circle"></i> Verified
                                            </span>
                                        </c:if>
                                    </div>
                                    <h3 class="font-bold text-lg text-gray-900 truncate leading-tight mb-1" title="${c.name}">
                                        ${c.name}
                                    </h3>
                                    <p class="text-gray-400 text-xs font-bold flex items-center gap-1 uppercase tracking-tighter">
                                        <i class="fa fa-location-dot text-ptit-red"></i> ${c.location}
                                    </p>
                                </div>
                            </div>

                            <div class="pb-6 border-b border-gray-50">
                                <p class="text-gray-500 text-sm line-clamp-2 leading-relaxed">
                                    <c:out value="${c.description}" default="Thông tin giới thiệu về công ty đang được cập nhật." />
                                </p>
                            </div>
                        </div>

                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/company?id=${c.id}" 
                               class="block w-full text-center py-3 bg-gray-50 hover:bg-ptit-red hover:text-white text-gray-900 font-extrabold rounded-xl transition-all text-sm uppercase tracking-widest">
                                Xem chi tiết
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty companies}">
                <div class="text-center py-24 bg-white rounded-3xl border border-dashed border-gray-200">
                    <i class="fa fa-building-circle-exclamation text-gray-200 text-6xl mb-4"></i>
                    <h2 class="text-xl font-bold text-gray-400 uppercase">Chưa có doanh nghiệp nào</h2>
                </div>
            </c:if>
            
            <c:if test="${totalPages > 1}">
                <div class="flex justify-center mt-12 gap-2">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/companies?page=${i}"
                           class="w-10 h-10 flex items-center justify-center rounded-lg font-bold text-sm border transition-all 
                           ${i == currentPage ? 'bg-ptit-red border-ptit-red text-white shadow-md' : 'bg-white border-gray-200 text-gray-500 hover:border-ptit-red hover:text-ptit-red'}">
                            ${i}
                        </a>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </main>

    <footer class="bg-gray-900 text-white py-10 mt-10">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-500 text-xs font-bold uppercase tracking-[0.2em]">© 2026 PTIT JOBS. Học viện Công nghệ Bưu chính Viễn thông</p>
        </div>
    </footer>

</body>
</html>