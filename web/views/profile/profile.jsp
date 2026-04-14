<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ | PTIT JOBS</title>
    
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .bg-ptit-red { background-color: #be1e2d; }
        .text-ptit-red { color: #be1e2d; }
        .hover\:bg-ptit-darkred:hover { background-color: #9a1825; }
    </style>
</head>
<body class="bg-gray-50 font-sans">

    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center h-20">
                <div class="flex items-center">
                    <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/">
                        <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                        <div class="flex flex-col">
                            <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                            <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                        </div>
                    </a>
                </div>
                <div class="flex items-center gap-4">
                    <span class="text-sm font-medium text-gray-500 italic">Ứng viên: ${sessionScope.LOGIN_USER.email}</span>
                </div>
            </div>
        </div>
    </header>

    <main class="min-h-screen pt-12 pb-20">
        <div class="container mx-auto px-4 max-w-3xl">
            
            <div class="mb-8">
                <a class="flex items-center gap-2 text-gray-600 hover:text-ptit-red transition font-medium" href="${pageContext.request.contextPath}/">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m12 19-7-7 7-7"/><path d="M19 12H5"/></svg>
                    Quay lại trang chủ
                </a>
            </div>

            <div class="bg-white rounded-[2rem] shadow-xl border border-gray-100 overflow-hidden">
                <div class="p-10">
                    <h2 class="text-3xl font-black text-gray-900 mb-8 tracking-tight">Hồ sơ cá nhân</h2>

                    <form method="post" action="profile" enctype="multipart/form-data" accept-charset="UTF-8" class="space-y-8">
                        
                        <div class="flex flex-col items-center p-8 bg-slate-50 rounded-[2rem] mb-10 border border-slate-100">
                            <div class="relative inline-block mb-6">
                                <c:choose>
                                    <%-- Nếu đã có ảnh đại diện --%>
                                    <c:when test="${not empty profile.avatarUrl}">
                                        <img src="${pageContext.request.contextPath}/${profile.avatarUrl}?t=${System.currentTimeMillis()}" 
                                             class="w-32 h-32 rounded-full border-4 border-white shadow-2xl object-cover ring-4 ring-red-50">
                                    </c:when>
                                    <%-- Nếu chưa có ảnh: Hiện chữ cái đầu hoặc chữ U --%>
                                    <c:otherwise>
                                        <div class="w-32 h-32 rounded-full bg-white border-4 border-white shadow-2xl flex items-center justify-center text-ptit-red text-5xl font-black uppercase ring-4 ring-red-50">
                                            <c:out value="${not empty profile.fullName ? profile.fullName.substring(0,1) : 'U'}" />
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <label class="block">
                                <span class="sr-only">Thay đổi ảnh đại diện</span>
                                <input type="file" name="avatar" accept="image/*"
                                       class="block w-full text-sm text-gray-500 file:mr-4 file:py-2.5 file:px-6 file:rounded-xl file:border-0 file:text-xs file:font-black file:uppercase file:tracking-widest file:bg-ptit-red file:text-white hover:file:bg-red-700 cursor-pointer transition-all"/>
                            </label>
                            <p class="text-[10px] text-gray-400 mt-4 uppercase font-bold tracking-widest">Định dạng: JPG, PNG (Max 2MB)</p>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div class="space-y-2">
                                <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400 ml-1">Họ và tên</label>
                                <input type="text" name="fullName" value="${profile.fullName}" required
                                       class="w-full px-5 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition font-bold text-gray-700">
                            </div>

                            <div class="space-y-2">
                                <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400 ml-1">Vị trí mong muốn</label>
                                <input type="text" name="title" value="${profile.title}" placeholder="VD: Java Developer"
                                       class="w-full px-5 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition text-gray-700 font-medium">
                            </div>

                            <div class="space-y-2">
                                <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400 ml-1">Số điện thoại</label>
                                <input type="text" name="phone" value="${profile.phone}"
                                       class="w-full px-5 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition text-gray-700 font-medium">
                            </div>

                            <div class="space-y-2">
                                <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400 ml-1">Địa điểm cư trú</label>
                                <input type="text" name="location" value="${profile.location}"
                                       class="w-full px-5 py-3 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition text-gray-700 font-medium">
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400 ml-1">Giới thiệu bản thân</label>
                            <textarea name="aboutMe" rows="5" 
                                      class="w-full px-5 py-4 bg-gray-50 border border-gray-200 rounded-2xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition text-gray-700 leading-relaxed">${profile.aboutMe}</textarea>
                        </div>

                        <div class="pt-8 border-t border-gray-100 space-y-4">
                            <label class="block text-[10px] font-black uppercase tracking-widest text-gray-400">Tài liệu CV (PDF)</label>
                            
                            <c:if test="${not empty profile.cvUrl}">
                                <div class="flex items-center gap-3 p-4 bg-red-50 rounded-xl border border-red-100">
                                    <div class="w-10 h-10 bg-ptit-red rounded-lg flex items-center justify-center text-white">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg>
                                    </div>
                                    <div class="flex-1">
                                        <p class="text-xs font-black uppercase text-ptit-red tracking-tighter">CV Đã tải lên</p>
                                        <a href="${pageContext.request.contextPath}/${profile.cvUrl}" target="_blank" class="text-sm font-bold text-gray-700 hover:underline">Xem tài liệu hiện tại</a>
                                    </div>
                                </div>
                            </c:if>
                            
                            <input type="file" name="cv" accept=".pdf"
                                   class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-xs file:font-bold file:bg-gray-200 file:text-gray-700 hover:file:bg-gray-300 cursor-pointer transition-all"/>
                        </div>

                        <div class="pt-10 flex gap-4">
                            <button type="submit" class="flex-1 bg-ptit-red text-white font-black uppercase tracking-widest py-4 px-6 rounded-2xl hover:scale-[1.02] active:scale-95 transition-all shadow-xl shadow-red-100 flex items-center justify-center gap-3">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                                Lưu hồ sơ
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <footer class="text-center py-12 text-gray-400 text-[10px] font-bold uppercase tracking-[0.2em]">
        &copy; 2026 PTIT JOBS • Recruitment Portal for Students
    </footer>

</body>
</html>