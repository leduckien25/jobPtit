<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} | Hồ sơ công ty</title>

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
        .sidebar-link { transition: 0.2s; border-radius: 10px; }
        .sidebar-link:hover { background-color: #fff1f0; color: #da1f26; }
        .sidebar-link.active { background-color: #da1f26; color: white; box-shadow: 0 4px 12px rgba(218, 31, 38, 0.2); }
        .section-card { background: white; border: 1px solid #eee; border-radius: 12px; padding: 25px; }
    </style>
</head>

<body class="bg-gray-50 flex flex-col min-h-screen">

<nav class="bg-white shadow-sm border-b border-gray-100 py-3 sticky top-0 z-50">
    <div class="container mx-auto px-5 flex justify-between items-center">
        <a class="flex items-center text-2xl font-extrabold text-ptit-red" href="${pageContext.request.contextPath}/job-manage">
            <span class="logo-box">P</span> JOBS
        </a>
        <div class="flex items-center gap-4">
            <div class="flex items-center gap-2 px-3 py-1.5 bg-gray-100 rounded-full">
                <i class="fa fa-user-tie text-gray-500 text-sm"></i>
                <span class="font-bold text-gray-600 text-xs uppercase tracking-wider">RECRUITER</span>
            </div>
            <a href="${pageContext.request.contextPath}/auth/logout" class="text-ptit-red font-bold text-sm hover:underline">Đăng xuất</a>
        </div>
    </div>
</nav>

<main class="flex-grow">
    <div class="relative h-60 w-full">
        <img class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1497215728101-856f4ea42174">
        <div class="absolute inset-0 bg-black/40"></div>
    </div>

    <div class="container mx-auto px-4 -mt-16 relative z-10 pb-20">
        <div class="grid lg:grid-cols-4 gap-8">
            
            <aside class="lg:col-span-1">
                <div class="flex flex-col gap-2 bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                    <a href="${pageContext.request.contextPath}/job-manage" class="sidebar-link flex items-center gap-3 px-5 py-3 font-bold text-gray-500">
                        <i class="fa fa-file-lines w-5 text-center"></i> Tin tuyển dụng
                    </a>
                    <a href="#" class="sidebar-link active flex items-center gap-3 px-5 py-3 font-bold">
                        <i class="fa fa-building w-5 text-center"></i> Hồ sơ công ty
                    </a>
                </div>
            </aside>

            <div class="lg:col-span-3 space-y-6">
                
                <div class="section-card flex flex-col md:flex-row gap-8 items-center md:items-start">
                    <div class="w-32 h-32 bg-white rounded-xl shadow-md border-4 border-white -mt-16 flex items-center justify-center overflow-hidden">
                        <c:choose>
                            <c:when test="${not empty company.logoUrl}">
                                <img src="${pageContext.request.contextPath}/${company.logoUrl}" class="w-full h-full object-contain">
                            </c:when>
                            <c:otherwise>
                                <i class="fa fa-building text-4xl text-gray-200"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="flex-1 text-center md:text-left pt-2">
                        <div class="flex flex-col md:flex-row md:items-center gap-3 mb-2">
                            <h1 class="text-2xl font-extrabold text-gray-900">${company.name}</h1>
                            <c:choose>
                                <c:when test="${company.isVerified == 1}">
                                    <span class="bg-green-100 text-green-600 px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">Đã xác thực</span>
                                </c:when>
                                <c:when test="${company.isVerified == 0}">
                                    <span class="bg-yellow-100 text-yellow-600 px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">Chờ duyệt</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">Bị từ chối</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="text-gray-500 font-medium text-sm flex items-center justify-center md:justify-start gap-2">
                            <i class="fa fa-map-marker-alt text-ptit-red"></i> ${company.location}
                        </p>
                        
                        <div class="mt-6">
                            <a href="${pageContext.request.contextPath}/recruiter/edit-company" 
                               class="inline-flex items-center gap-2 px-6 py-2.5 bg-gray-900 text-white rounded-lg font-bold hover:bg-black transition active:scale-95 shadow-md">
                                <i class="fa fa-pen-to-square text-xs"></i> Chỉnh sửa hồ sơ
                            </a>
                        </div>
                    </div>
                </div>

                <div class="grid md:grid-cols-3 gap-6">
                    <div class="md:col-span-2 section-card">
                        <h2 class="text-lg font-bold text-gray-800 mb-4 flex items-center gap-2">
                            <i class="fa fa-align-left text-ptit-red"></i> Giới thiệu công ty
                        </h2>
                        <div class="text-gray-600 leading-relaxed text-sm whitespace-pre-line">
                            <c:choose>
                                <c:when test="${not empty company.description}">${company.description}</c:when>
                                <c:otherwise><span class="italic text-gray-400">Chưa có thông tin giới thiệu.</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="section-card space-y-6">
                        <div>
                            <h3 class="text-xs font-bold text-gray-400 uppercase tracking-widest mb-4">Thông tin liên hệ</h3>
                            <div class="space-y-4">
                                <div class="flex items-start gap-3">
                                    <i class="fa fa-location-dot mt-1 text-gray-400"></i>
                                    <span class="text-sm font-medium text-gray-700">${company.location}</span>
                                </div>
                                <div class="flex items-start gap-3">
                                    <i class="fa fa-calendar-day mt-1 text-gray-400"></i>
                                    <div class="text-sm">
                                        <span class="block text-gray-400 text-[10px] font-bold uppercase">Ngày tham gia</span>
                                        <span class="font-medium text-gray-700">14/04/2026</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

<footer class="bg-gray-900 text-white py-8 border-t border-gray-800">
    <div class="container mx-auto px-4 text-center text-xs font-medium text-gray-500 uppercase tracking-widest">
        &copy; 2026 Học viện Công nghệ Bưu chính Viễn thông - JobPTIT System
    </div>
</footer>

</body>
</html>