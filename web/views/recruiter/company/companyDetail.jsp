<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} | Chi tiết doanh nghiệp</title>
    
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
        .section-card { background: white; border: 1px solid #eee; border-radius: 12px; padding: 32px; }
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

    <main class="flex-grow">
        <div class="relative h-64 md:h-80 w-full overflow-hidden bg-gray-900">
            <img alt="Banner" class="w-full h-full object-cover opacity-60" src="https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=1950">
            <div class="absolute inset-0 bg-gradient-to-t from-gray-900/80 to-transparent"></div>
        </div>

        <div class="container mx-auto px-4 -mt-24 relative z-10">
            <div class="bg-white rounded-3xl shadow-xl p-8 border border-gray-100 flex flex-col md:flex-row items-center md:items-end gap-8 mb-10">
                
                <div class="w-40 h-40 bg-white rounded-2xl p-4 shadow-lg flex-shrink-0 -mt-20 border-4 border-white flex items-center justify-center overflow-hidden">
                    <img alt="${company.name}" class="w-full h-full object-contain" 
                         src="${pageContext.request.contextPath}/${company.logoUrl}"
                         onerror="this.src='https://placehold.co/200x200?text=No+Logo'">
                </div>

                <div class="flex-1 text-center md:text-left pb-2">
                    <div class="flex flex-col md:flex-row md:items-center gap-4 mb-3">
                        <h1 class="text-4xl font-black text-gray-900 leading-tight">${company.name}</h1>
                        <c:if test="${company.isVerified == 1}">
                            <span class="bg-blue-50 text-blue-600 px-4 py-1 rounded-full text-[10px] font-black uppercase tracking-widest border border-blue-100">
                                <i class="fa fa-check-circle mr-1"></i> Verified
                            </span>
                        </c:if>
                    </div>
                    <div class="flex items-center justify-center md:justify-start gap-4 text-gray-500">
                        <span class="font-bold text-sm uppercase tracking-tighter flex items-center gap-1">
                            <i class="fa fa-location-dot text-ptit-red"></i> ${company.location}
                        </span>
                        <span class="h-4 w-px bg-gray-200"></span>
                        <span class="font-bold text-sm uppercase tracking-tighter flex items-center gap-1">
                            <i class="fa fa-briefcase text-ptit-red"></i> ${jobs.size()} Việc làm
                        </span>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 pb-20">
                <div class="lg:col-span-2 space-y-8">
                    <div class="section-card">
                        <h2 class="text-xl font-extrabold text-gray-900 mb-6 flex items-center gap-3">
                            <i class="fa fa-align-left text-ptit-red"></i>
                            Giới thiệu công ty
                        </h2>
                        <div class="text-gray-600 leading-relaxed text-base whitespace-pre-line">
                            <c:out value="${company.description}" default="Công ty chưa có thông tin giới thiệu chi tiết." />
                        </div>
                    </div>

                    <div class="section-card">
                        <h2 class="text-xl font-extrabold text-gray-900 mb-6 flex items-center gap-3">
                            <i class="fa fa-bolt text-ptit-red"></i>
                            Cơ hội nghề nghiệp đang mở
                        </h2>

                        <c:choose>
                            <c:when test="${empty jobs}">
                                <div class="text-center py-10">
                                    <p class="text-gray-400 font-bold italic">Doanh nghiệp hiện chưa có tin tuyển dụng nào.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid gap-4">
                                    <c:forEach var="job" items="${jobs}">
                                        <div class="group border border-gray-100 rounded-2xl p-5 hover:border-ptit-red hover:shadow-md transition-all">
                                            <div class="flex justify-between items-start">
                                                <div>
                                                    <a href="${pageContext.request.contextPath}/job?id=${job.id}"
                                                       class="text-lg font-extrabold text-gray-800 group-hover:text-ptit-red transition-colors block mb-1">
                                                        ${job.title}
                                                    </a>
                                                    <div class="flex items-center gap-4 text-xs font-bold text-gray-400 uppercase">
                                                        <span><i class="fa fa-location-dot mr-1"></i> ${job.location}</span>
                                                        <span class="text-green-600">
                                                            <i class="fa fa-money-bill-wave mr-1"></i>
                                                            <c:choose>
                                                                <c:when test="${job.isNegotiable}">Thỏa thuận</c:when>
                                                                <c:otherwise>${job.salaryMin} - ${job.salaryMax} Triệu</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/job?id=${job.id}" class="px-4 py-2 bg-gray-50 text-gray-900 font-black text-[10px] uppercase tracking-widest rounded-lg group-hover:bg-ptit-red group-hover:text-white transition-all">
                                                    Ứng tuyển
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="space-y-8">
                    <div class="section-card">
                        <h3 class="text-sm font-black text-gray-400 uppercase tracking-[0.2em] mb-6">Thông tin chi tiết</h3>
                        <div class="space-y-6">
                            <div class="flex items-start gap-4">
                                <div class="w-10 h-10 rounded-lg bg-gray-50 flex items-center justify-center text-ptit-red flex-shrink-0">
                                    <i class="fa fa-map-location-dot"></i>
                                </div>
                                <div>
                                    <span class="block text-[10px] font-black text-gray-400 uppercase">Trụ sở chính</span>
                                    <p class="text-gray-900 font-bold text-sm">${company.location}</p>
                                </div>
                            </div>
                            
                            <div class="flex items-start gap-4">
                                <div class="w-10 h-10 rounded-lg bg-gray-50 flex items-center justify-center text-ptit-red flex-shrink-0">
                                    <i class="fa fa-globe"></i>
                                </div>
                                <div>
                                    <span class="block text-[10px] font-black text-gray-400 uppercase">Website</span>
                                    <a href="#" class="text-blue-600 font-bold text-sm hover:underline italic underline-offset-4">đang cập nhật...</a>
                                </div>
                            </div>

                            <div class="flex items-start gap-4">
                                <div class="w-10 h-10 rounded-lg bg-gray-50 flex items-center justify-center text-ptit-red flex-shrink-0">
                                    <i class="fa fa-calendar-check"></i>
                                </div>
                                <div>
                                    <span class="block text-[10px] font-black text-gray-400 uppercase">Ngày gia nhập</span>
                                    <p class="text-gray-900 font-bold text-sm"><fmt:formatDate value="${company.createdAt}" pattern="dd/MM/yyyy"/></p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-8 pt-8 border-t border-gray-50">
                            <button class="w-full py-3 border-2 border-gray-100 rounded-xl font-black text-xs uppercase tracking-widest text-gray-400 hover:border-ptit-red hover:text-ptit-red transition-all">
                                <i class="fa fa-share-nodes mr-2"></i> Chia sẻ hồ sơ
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-gray-900 text-white py-10 mt-auto">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-500 text-xs font-bold uppercase tracking-[0.2em]">© 2026 PTIT JOBS. Học viện Công nghệ Bưu chính Viễn thông</p>
        </div>
    </footer>

</body>
</html>