<%-- 
    Document   : jobManager
    Created on : Mar 17, 2026, 12:14:17 AM
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tin tuyển dụng - JobPTIT</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ptit-red': '#C8102E',
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="bg-gray-50">

    <div id="root">
        <div class="flex flex-col min-h-screen">
            <header class="bg-white shadow-sm sticky top-0 z-50">
                <div class="container mx-auto px-4">
                    <div class="flex justify-between items-center h-20">
                        <div class="flex items-center">
                            <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/job-manage">
                                <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                                <div class="flex flex-col">
                                    <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                                    <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                                </div>
                            </a>
<!--                            <div class="hidden md:flex items-center gap-3 pl-4">
                                <a class="px-5 py-2 border border-gray-300 text-gray-700 text-sm font-bold rounded hover:bg-gray-50 transition" href="#">Quản lý tin</a>
                                <a class="px-5 py-2 bg-ptit-red text-white text-sm font-bold rounded hover:bg-red-700 transition" href="${pageContext.request.contextPath}/job">Đăng tin ngay</a>
                            </div>-->
                        </div>
                        <div class="hidden md:flex items-center gap-4">
                            <div class="flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-lg">
                                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-gray-600"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                <span class="text-gray-700 font-medium">Nhà tuyển dụng</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="block w-fit">
                                <button class="flex items-center gap-2 px-4 py-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors font-medium">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                                    </svg>
                                    Đăng xuất
                                </button>
                            </a>
                        </div>
                    </div>
                </div>
            </header>

            <main class="flex-grow">
                <div class="min-h-screen bg-gray-50 pt-24 pb-20">
                    <div class="container mx-auto px-4">
                        <div class="grid lg:grid-cols-4 gap-8">
                            <div class="lg:col-span-1 space-y-6">
                                <div class="space-y-2">
                                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-bold transition bg-ptit-red text-white shadow-lg shadow-red-100" href="#">Tin tuyển dụng</a>
                                    <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-bold transition text-gray-600 hover:bg-white hover:shadow-sm" href="${pageContext.request.contextPath}/company">Hồ sơ công ty</a>
                                </div>
                            </div>

                            <div class="lg:col-span-3">
                                <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
                                    <div>
                                        <h1 class="text-3xl font-bold text-gray-900">Quản lý Tin tuyển dụng</h1>
                                        <p class="text-gray-600 mt-1">Theo dõi và quản lý các tin đăng của bạn</p>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/job"> 
                                        <button class="flex items-center gap-2 px-6 py-3 bg-ptit-red text-white font-bold rounded-xl hover:bg-red-700 transition shadow-lg shadow-red-100 w-fit">
                                            Đăng tin mới 
                                        </button>
                                    </a>
                                </div>

                                <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
                                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
                                        <div class="text-3xl font-bold text-gray-900">${totalJobs}</div>
                                        <div class="text-sm text-gray-500">Tổng tin đăng</div>
                                    </div>
                                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
                                        <div class="text-3xl font-bold text-green-600">${jobs.size()}</div>
                                        <div class="text-sm text-gray-500">Đang hiển thị</div>
                                    </div>
                                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
                                        <div class="text-3xl font-bold text-blue-600">${totalViewsCount}</div>
                                        <div class="text-sm text-gray-500">Lượt xem</div>
                                    </div>
<!--                                    <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100">
                                        <div class="text-3xl font-bold text-ptit-red">38</div>
                                        <div class="text-sm text-gray-500">Đơn ứng tuyển</div>
                                    </div>-->
                                </div>

                                <c:if test="${not empty sessionScope.message}">
                                    <div class="p-4 mb-6 rounded-xl flex items-center gap-3 shadow-sm border 
                                        ${sessionScope.msgType == 'success' ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'}">
                                        <span class="text-xl">${sessionScope.msgType == 'success' ? '✅' : '❌'}</span>
                                        <span class="font-medium">${sessionScope.message}</span>
                                        <c:remove var="message" scope="session" />
                                        <c:remove var="msgType" scope="session" />
                                    </div>
                                </c:if>

                                <div class="bg-white p-4 rounded-2xl shadow-sm border border-gray-100 mb-6">
                                    <form action="${pageContext.request.contextPath}/job-manage" method="GET" class="flex flex-col md:flex-row gap-4">
                                        <div class="flex-grow relative">
                                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd" />
                                                </svg>
                                            </div>
                                            <input type="text" name="searchTitle" value="${searchTitle}"
                                                   class="block w-full pl-10 pr-3 py-2.5 border border-gray-200 rounded-xl focus:ring-ptit-red focus:border-ptit-red text-sm" 
                                                   placeholder="Tìm theo tiêu đề công việc...">
                                        </div>
                                        <div class="md:w-1/4 relative">
                                            <input type="text" name="searchLocation" value="${searchLocation}"
                                                   class="block w-full px-4 py-2.5 border border-gray-200 rounded-xl focus:ring-ptit-red focus:border-ptit-red text-sm" 
                                                   placeholder="Địa điểm...">
                                        </div>
                                        <button type="submit" class="px-6 py-2.5 bg-gray-900 text-white font-bold rounded-xl hover:bg-black transition shadow-sm">
                                            Tìm kiếm
                                        </button>
                                        <c:if test="${not empty searchTitle || not empty searchLocation}">
                                            <a href="${pageContext.request.contextPath}/job-manage" class="px-4 py-2.5 text-gray-500 hover:text-ptit-red flex items-center justify-center text-sm font-medium">
                                                Xóa lọc
                                            </a>
                                        </c:if>
                                    </form>
                                </div>

                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${not empty jobs}">
                                            <c:forEach items="${jobs}" var="j">
                                                <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100 hover:shadow-md transition">
                                                    <div class="flex flex-col md:flex-row md:items-center gap-4">
                                                        <div class="flex-1 min-w-0">
                                                            <div class="flex items-center gap-3 w-full">
                                                                <h3 class="text-lg font-bold text-gray-900 truncate" title="${j.title}">
                                                                    ${j.title}
                                                                </h3>
<!--                                                                <div class="flex-shrink-0">
                                                                    <c:choose>
                                                                        <c:when test="${j.status == 1}">
                                                                            <span class="whitespace-nowrap px-2.5 py-0.5 text-xs font-medium bg-green-100 text-green-700 rounded-full border border-green-200">
                                                                                ● Đang hoạt động
                                                                            </span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="whitespace-nowrap px-2.5 py-0.5 text-xs font-medium bg-gray-100 text-gray-600 rounded-full border border-gray-200">
                                                                                ● Tạm dừng
                                                                            </span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>-->
                                                            </div>

                                                            <div class="flex gap-4 text-sm text-gray-500 mt-2">
                                                                <span class="inline-block max-w-[150px] truncate" title="${j.location}">
                                                                    ${j.location}
                                                                </span> • 
                                                                <span class="font-medium ${j.isNegotiable ? 'text-ptit-red' : ''}">
                                                                    ${j.salaryRangeFormatted}
                                                                </span> • 
                                                                <span>
                                                                    <c:choose>
                                                                        <c:when test="${j.jobType == 1}">FullTime</c:when>
                                                                        <c:when test="${j.jobType == 2}">PartTime</c:when>
                                                                        <c:otherwise>Internship</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </div>
                                                            <div class="flex flex-wrap gap-4 text-xs text-gray-400 mt-1.5">
                                                                <span class="flex items-center gap-1">
                                                                    <span class="font-medium text-gray-500">Ngày đăng:</span> 
                                                                    <span>${j.createdAtFormatted}</span>
                                                                </span>
                                                                <span class="flex items-center gap-1">
                                                                    <span class="font-medium text-gray-500">Hạn nộp:</span> 
                                                                    <span>${j.deadlineFormatted}</span> 
                                                                </span>
                                                            </div>

<!--                                                            <div class="mt-2">
                                                                <a href="${pageContext.request.contextPath}/job-apply/${j.id}" 
                                                                   class="inline-flex items-center gap-1.5 text-xs font-bold text-ptit-red hover:text-red-700 transition-colors">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
                                                                    </svg>
                                                                    Danh sách ứng tuyển hồ sơ →
                                                                </a>
                                                            </div>-->
                                                        </div>
                                                        
                                                        <div class="flex items-center gap-4 flex-shrink-0">
                                                            <div class="text-center">
                                                                <div class="font-bold text-gray-900">${j.viewsCount}</div>
                                                                <div class="text-xs text-gray-400">Lượt xem</div>
                                                            </div>
<!--                                                            <div class="text-center text-ptit-red">
                                                                <div class="font-bold">18</div>
                                                                <div class="text-xs text-gray-400">Ứng viên</div>
                                                            </div>-->
                                                            <div class="flex items-center gap-2 ml-2"> 
                                                                <a href="${pageContext.request.contextPath}/job-edit/${j.id}">
                                                                    <button type="button" class="px-4 py-2 bg-ptit-red text-white text-sm font-bold rounded-xl hover:bg-red-700 transition">
                                                                        Chỉnh sửa
                                                                    </button>
                                                                </a>
                                                                <form action="${pageContext.request.contextPath}/job-manage" method="POST" onsubmit="return confirm('Bạn có chắc chắn muốn xóa công việc này?');" style="display:inline;">
                                                                    <input type="hidden" name="action" value="delete">

                                                                    <input type="hidden" name="id" value="${j.id}">

                                                                    <button type="submit" class="px-4 py-2 bg-gray-100 text-gray-600 text-sm font-bold rounded-xl hover:bg-red-50 hover:text-red-600 transition border border-gray-200 hover:border-red-200">
                                                                        Xóa
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center py-10 bg-white rounded-2xl border border-dashed border-gray-300">
                                                <p class="text-gray-500">Không tìm thấy tin tuyển dụng.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="mt-10 flex flex-col md:flex-row items-center justify-between gap-4 border-t border-gray-200 pt-6">
                                        <p class="text-sm text-gray-500">
                                            Hiển thị <span class="font-bold text-gray-900">${jobs.size()}</span> tin tuyển dụng
                                        </p>

                                        <nav class="flex items-center gap-2">
                                            <c:choose>
                                                <c:when test="${currentPage > 1}">
                                                    <a href="?page=${currentPage - 1}&searchTitle=${param.searchTitle}&searchLocation=${param.searchLocation}" 
                                                       class="w-10 h-10 flex items-center justify-center border border-gray-200 rounded-xl bg-white text-gray-600 hover:bg-gray-50 hover:border-ptit-red hover:text-ptit-red transition-all shadow-sm">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="15 18 9 12 15 6"></polyline>
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-10 h-10 flex items-center justify-center border border-gray-100 rounded-xl bg-gray-50 text-gray-300 cursor-not-allowed">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="15 18 9 12 15 6"></polyline>
                                                        </svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <a href="?page=${i}&searchTitle=${param.searchTitle}&searchLocation=${param.searchLocation}" 
                                                   class="w-10 h-10 flex items-center justify-center rounded-xl text-sm font-bold transition-all
                                                   ${i == currentPage ? 'bg-ptit-red text-white shadow-lg shadow-red-100 scale-105' : 'bg-white border border-gray-200 text-gray-600 hover:border-ptit-red hover:text-ptit-red'}">
                                                     ${i}
                                                </a>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${currentPage < totalPages}">
                                                    <a href="?page=${currentPage + 1}&searchTitle=${param.searchTitle}&searchLocation=${param.searchLocation}" 
                                                       class="w-10 h-10 flex items-center justify-center border border-gray-200 rounded-xl bg-white text-gray-600 hover:bg-gray-50 hover:border-ptit-red hover:text-ptit-red transition-all shadow-sm">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="9 18 15 12 9 6"></polyline>
                                                        </svg>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-10 h-10 flex items-center justify-center border border-gray-100 rounded-xl bg-gray-50 text-gray-300 cursor-not-allowed">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                            <polyline points="9 18 15 12 9 6"></polyline>
                                                        </svg>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="bg-gray-900 text-white py-8 text-center text-sm">
                <p>&copy; 2026 Học viện Công nghệ Bưu chính Viễn thông - PTIT</p>
            </footer>
        </div>
    </div>
</body>
</html>