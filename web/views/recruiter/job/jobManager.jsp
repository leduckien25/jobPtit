<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tin tuyển dụng | PTIT JOBS</title>
    
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ptit-red': '#da1f26',
                        'ptit-hover': '#fff1f0',
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

    <main class="flex-grow py-10">
        <div class="container mx-auto px-4">
            <div class="grid lg:grid-cols-4 gap-8">
                
                <aside class="lg:col-span-1">
                    <div class="flex flex-col gap-2">
                        <a href="#" class="sidebar-link active flex items-center gap-3 px-5 py-3 font-bold">
                            <i class="fa fa-file-lines w-5 text-center"></i> Tin tuyển dụng
                        </a>
                        <a href="${pageContext.request.contextPath}/recruiter/my-company" class="sidebar-link flex items-center gap-3 px-5 py-3 font-bold text-gray-500">
                            <i class="fa fa-building w-5 text-center"></i> Hồ sơ công ty
                        </a>
                    </div>
                </aside>

                <div class="lg:col-span-3">
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-8">
                        <div>
                            <h1 class="text-3xl font-extrabold text-gray-900">Quản lý Tin tuyển dụng</h1>
                            <p class="text-gray-500 mt-1 font-medium text-sm">Kiểm soát và theo dõi hiệu quả các bài đăng của bạn.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/job" class="inline-block">
                            <button class="flex items-center gap-2 px-6 py-3 bg-ptit-red text-white font-bold rounded-xl hover:bg-red-700 transition shadow-lg shadow-red-100 active:scale-95">
                                <i class="fa fa-plus-circle"></i> Đăng tin mới
                            </button>
                        </a>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-8">
                        <div class="section-card flex flex-col justify-center">
                            <span class="text-2xl font-extrabold text-gray-900">${totalJobs}</span>
                            <span class="text-xs font-bold text-gray-400 uppercase tracking-widest mt-1">Tổng bài đăng</span>
                        </div>
                        <div class="section-card flex flex-col justify-center border-l-4 border-l-green-500">
                            <span class="text-2xl font-extrabold text-green-600">${jobs.size()}</span>
                            <span class="text-xs font-bold text-gray-400 uppercase tracking-widest mt-1">Đang hoạt động</span>
                        </div>
                        <div class="section-card flex flex-col justify-center border-l-4 border-l-blue-500">
                            <span class="text-2xl font-extrabold text-blue-600">${totalViewsCount}</span>
                            <span class="text-xs font-bold text-gray-400 uppercase tracking-widest mt-1">Tổng lượt xem</span>
                        </div>
                    </div>

                    <%-- THÔNG BÁO --%>
                    <c:if test="${not empty sessionScope.message}">
                        <div class="p-4 mb-6 rounded-xl border flex items-center gap-3 ${sessionScope.msgType == 'success' ? 'bg-green-50 border-green-200 text-green-700' : 'bg-red-50 border-red-200 text-red-700'}">
                            <i class="fa ${sessionScope.msgType == 'success' ? 'fa-check-circle' : 'fa-circle-exclamation'}"></i>
                            <span class="font-bold text-sm">${sessionScope.message}</span>
                            <c:remove var="message" scope="session" />
                        </div>
                    </c:if>

                    <div class="section-card p-4 mb-6">
                        <form action="${pageContext.request.contextPath}/job-manage" method="GET" class="flex flex-col md:flex-row gap-3">
                            <div class="flex-grow relative">
                                <i class="fa fa-search absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-sm"></i>
                                <input type="text" name="searchTitle" value="${searchTitle}" class="w-full pl-10 pr-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-ptit-red outline-none text-sm font-medium" placeholder="Tìm tiêu đề công việc...">
                            </div>
                            <button type="submit" class="px-8 py-2.5 bg-gray-900 text-white font-bold rounded-xl hover:bg-black transition text-sm">Lọc</button>
                            <c:if test="${not empty searchTitle}">
                                <a href="${pageContext.request.contextPath}/job-manage" class="px-4 py-2.5 text-gray-500 font-bold text-sm flex items-center hover:text-ptit-red">Xóa lọc</a>
                            </c:if>
                        </form>
                    </div>

                    <div class="space-y-4">
                        <c:choose>
                            <c:when test="${not empty jobs}">
                                <c:forEach items="${jobs}" var="j">
                                <%-- Cấu trúc thẻ cha có sự kiện click --%>
                                <div onclick="window.location.href='${pageContext.request.contextPath}/recruiter/candidates?jobId=${j.id}'" 
                                     class="section-card hover:border-ptit-red hover:shadow-md transition-all group cursor-pointer relative overflow-hidden">

                                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                                        <div class="flex-grow">
                                            <h3 class="text-lg font-extrabold text-gray-900 group-hover:text-ptit-red transition mb-1">${j.title}</h3>
                                            <div class="flex flex-wrap items-center gap-4 text-xs font-bold text-gray-500 uppercase tracking-tighter">
                                                <span class="flex items-center gap-1"><i class="fa fa-map-marker-alt"></i> ${j.location}</span>
                                                <span class="text-ptit-red"><i class="fa fa-money-bill-wave"></i> ${j.salaryRangeFormatted}</span>
                                                <span><i class="fa fa-clock"></i> ${j.createdAtFormatted}</span>
                                            </div>
                                        </div>

                                        <div class="flex items-center gap-3">
                                            <%-- GIỮ NGUYÊN LOGIC HIỂN THỊ LƯỢT XEM CỦA BẠN --%>
                                            <div class="text-right px-4 border-r border-gray-100">
                                                <div class="text-lg font-black text-gray-900">${j.viewsCount}</div>
                                                <div class="text-[10px] font-bold text-gray-400 uppercase">Xem</div>
                                            </div>

                                            <%-- Các nút chức năng - Dùng stopPropagation để không bị nhảy trang khi bấm Sửa/Xóa --%>
                                            <div class="flex gap-2 relative z-10" onclick="event.stopPropagation();">
                                                <a href="${pageContext.request.contextPath}/job-edit/${j.id}" 
                                                   class="p-2.5 bg-gray-50 text-gray-600 rounded-lg hover:bg-ptit-hover hover:text-ptit-red transition" 
                                                   title="Chỉnh sửa">
                                                    <i class="fa fa-edit"></i>
                                                </a>

                                                <form action="${pageContext.request.contextPath}/job-manage" method="POST" 
                                                      onsubmit="return confirm('Xác nhận xóa bài đăng này?')" class="m-0">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="id" value="${j.id}">
                                                    <button type="submit" class="p-2.5 bg-gray-50 text-gray-400 rounded-lg hover:bg-red-50 hover:text-red-600 transition" title="Xóa">
                                                        <i class="fa fa-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <%-- Thanh trang trí chạy dưới đáy khi di chuột vào --%>
                                    <div class="absolute bottom-0 left-0 w-0 h-1 bg-ptit-red transition-all group-hover:w-full"></div>
                                </div>
                            </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-20 section-card border-dashed">
                                    <i class="fa fa-folder-open text-gray-200 text-5xl mb-4"></i>
                                    <p class="text-gray-400 font-bold">Chưa có tin tuyển dụng nào.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <nav class="mt-10 flex justify-end gap-2">
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <a href="?page=${i}&searchTitle=${param.searchTitle}" class="w-10 h-10 flex items-center justify-center rounded-lg font-bold text-sm border transition-all ${i == currentPage ? 'bg-ptit-red border-ptit-red text-white shadow-md' : 'bg-white border-gray-200 text-gray-500 hover:border-ptit-red hover:text-ptit-red'}">
                                    ${i}
                                </a>
                            </c:forEach>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-gray-900 text-white py-8">
        <div class="container mx-auto px-4 text-center text-xs font-medium text-gray-500 uppercase tracking-widest">
            &copy; 2026 Học viện Công nghệ Bưu chính Viễn thông - JobPTIT System
        </div>
    </footer>

</body>
</html>