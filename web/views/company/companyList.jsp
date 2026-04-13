<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách công ty | PTIT JOBS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .bg-ptit-red { background-color: #be1e2d; }
        .text-ptit-red { color: #be1e2d; }
        .border-ptit-red { border-color: #be1e2d; }
    </style>
</head>
<body class="bg-gray-50 font-sans leading-normal tracking-normal">

    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4 h-20 flex justify-between items-center">
            <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/home">
                <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                <div class="flex flex-col">
                    <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                    <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                </div>
            </a>
            <nav class="hidden md:flex items-center space-x-8">
                <a class="font-medium text-gray-600 hover:text-ptit-red" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <a class="font-medium text-ptit-red border-b-2 border-ptit-red" href="${pageContext.request.contextPath}/companies">Công ty</a>
            </nav>
        </div>
    </header>

    <main class="container mx-auto px-4 py-12">
        <div class="text-center mb-12">
            <h1 class="text-4xl font-black text-gray-900 mb-4">Khám phá các doanh nghiệp đối tác</h1>
            <p class="text-gray-500 max-w-2xl mx-auto">Tìm kiếm nơi thực tập và làm việc lý tưởng từ mạng lưới đối tác tin cậy của PTIT.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <c:forEach items="${companies}" var="c">
                <div class="bg-white rounded-3xl p-6 shadow-sm border border-gray-100 hover:shadow-xl transition-all duration-300 group">
                    <div class="flex items-start gap-5">
                        <div class="w-20 h-20 rounded-2xl bg-gray-50 p-2 flex-shrink-0 border border-gray-100 group-hover:scale-105 transition-transform">
                            <img src="${pageContext.request.contextPath}/${c.logoUrl}" 
                                 alt="${c.name}" 
                                 class="w-full h-full object-contain"
                                 onerror="this.src='https://placehold.co/100x100?text=Logo'">
                        </div>
                        
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <span class="bg-blue-50 text-blue-600 text-[10px] font-black uppercase px-2 py-0.5 rounded">
                                      Verified
                                </span>
                            </div>
                            <h3 class="font-black text-xl text-gray-900 line-clamp-1 group-hover:text-ptit-red transition-colors">
                                ${c.name}
                            </h3>
                            <p class="text-gray-500 text-sm flex items-center gap-1 mt-1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
                                ${c.location}
                            </p>
                        </div>
                    </div>

                    <div class="mt-6 pt-6 border-t border-gray-50">
                        <p class="text-gray-600 text-sm line-clamp-2 mb-6 h-10">
                            ${c.description}
                        </p>
                        
                        <a href="${pageContext.request.contextPath}/company?id=${c.id}" 
                           class="block w-full text-center py-3 bg-gray-50 hover:bg-ptit-red hover:text-white text-gray-900 font-bold rounded-xl transition-all">
                            Xem chi tiết
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty companies}">
            <div class="text-center py-20">
                <div class="text-6xl mb-4">🏢</div>
                <h2 class="text-2xl font-bold text-gray-400">Chưa có công ty nào được đăng ký</h2>
            </div>
        </c:if>
    </main>

    <footer class="bg-gray-900 text-white py-12 mt-20">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-500">© 2026 PTIT JOBS. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

</body>
</html>