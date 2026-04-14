<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} | Hồ sơ công ty</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .bg-ptit-red { background-color: #be1e2d; }
        .text-ptit-red { color: #be1e2d; }
        .border-ptit-red { border-color: #be1e2d; }
    </style>
</head>

<body class="bg-gray-50 font-sans leading-normal tracking-normal">

<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center h-20">
            <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/job-manage">
                <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                <div class="flex flex-col">
                    <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                    <span class="text-gray-600 text-xs font-medium tracking-wider">RECRUITER Center</span>
                </div>
            </a>

            <nav class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/job-manage" class="font-semibold text-gray-600 hover:text-ptit-red transition">Quản lý tin đăng</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="font-bold text-red-600 hover:text-red-800 transition">Đăng xuất</a>
            </nav>
        </div>
    </div>
</header>

<main>
    <div class="relative h-64 md:h-80 w-full overflow-hidden">
        <img alt="Company Banner" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=1950">
        <div class="absolute inset-0 bg-gradient-to-t from-gray-900/70 to-transparent"></div>
    </div>

    <div class="container mx-auto px-4 -mt-24 relative z-10">
        <div class="bg-white rounded-[2rem] shadow-xl p-8 border border-gray-100 flex flex-col md:flex-row items-center md:items-end gap-8">
            
            <div class="w-40 h-40 md:w-48 md:h-48 rounded-2xl bg-white p-4 shadow-lg flex-shrink-0 -mt-20 border-4 border-white">
                <img src="${pageContext.request.contextPath}/${company.logoUrl}" 
                     alt="${company.name}" 
                     class="w-full h-full object-contain rounded-xl"
                     onerror="this.src='https://placehold.co/200x200?text=Logo'">
            </div>

            <div class="flex-1 text-center md:text-left pb-2">
                <div class="flex flex-col md:flex-row md:items-center gap-4 mb-3">
                    <h1 class="text-4xl font-black text-gray-900 leading-tight">${company.name}</h1>
                    
                    <c:choose>
                        <c:when test="${company.isVerified == 1}">
                            <span class="bg-green-100 text-green-600 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest w-fit mx-auto md:mx-0 border border-green-200">Đã xác thực</span>
                        </c:when>
                        <c:otherwise>
                            <span class="bg-yellow-100 text-yellow-600 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest w-fit mx-auto md:mx-0 border border-yellow-200">Chờ duyệt</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="flex items-center justify-center md:justify-start gap-2 text-gray-500 mb-6 font-medium">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
                    <span>${company.location}</span>
                </div>

                <div class="flex flex-wrap justify-center md:justify-start gap-3">
                    <a href="${pageContext.request.contextPath}/recruiter/edit-company" 
                       class="inline-flex items-center gap-2 px-6 py-3 bg-ptit-red text-white font-black rounded-xl shadow-lg shadow-red-200 hover:scale-105 active:scale-95 transition-all">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                        Chỉnh sửa hồ sơ
                    </a>
                    <a href="${pageContext.request.contextPath}/job-manage" 
                       class="inline-flex items-center gap-2 px-6 py-3 bg-white text-gray-700 font-bold rounded-xl border border-gray-200 hover:bg-gray-50 transition-all">
                        Quản lý tin đăng
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container mx-auto px-4 mt-12 mb-24 grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div class="lg:col-span-2 space-y-8">
            <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8 min-h-[400px]">
                <h2 class="text-2xl font-black text-gray-900 mb-6 flex items-center gap-3">
                    <span class="w-2 h-8 bg-ptit-red rounded-full"></span>
                    Giới thiệu công ty
                </h2>
                <div class="text-gray-600 leading-loose text-lg whitespace-pre-line">
                    ${company.description}
                </div>
            </div>
        </div>

        <div class="space-y-8">
            <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8">
                <h3 class="text-xl font-bold text-gray-900 mb-6">Thông tin chi tiết</h3>
                <div class="space-y-6">
                    <div>
                        <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-1">Địa chỉ</span>
                        <p class="text-gray-900 font-bold">${company.location}</p>
                    </div>
                    <div>
                        <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-1">Email liên hệ</span>
                        <p class="text-gray-900 font-bold italic">${sessionScope.LOGIN_USER.email}</p>
                    </div>
                    <div>
                        <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-1">Trạng thái xác thực</span>
                        <div class="mt-2">
                             <c:choose>
                                <c:when test="${company.isVerified == 1}">
                                    <p class="text-green-600 font-bold flex items-center gap-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"/></svg>
                                        Đã được phê duyệt
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-orange-500 font-bold flex items-center gap-2">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                                        Đang chờ hệ thống kiểm tra
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<footer class="bg-gray-900 text-white py-12">
    <div class="container mx-auto px-4 text-center">
        <p class="text-gray-500 text-sm font-medium tracking-wide">© 2026 PTIT JOBS Center. Sản phẩm dành cho thực tập sinh Cloud/DevOps.</p>
    </div>
</footer>

</body>
</html>