<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ | PTIT JOBS</title>
    
    <!-- Thêm Tailwind CSS để dùng class tiện lợi -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Style tuỳ chỉnh cho màu sắc chuẩn PTIT -->
    <style>
        .bg-ptit-red { background-color: #be1e2d; } /* Màu đỏ chuẩn PTIT */
        .text-ptit-red { color: #be1e2d; } /* Màu chữ đỏ PTIT */
        .hover\:bg-ptit-darkred:hover { background-color: #9a1825; } /* Màu đỏ đậm khi hover */
    </style>
</head>
<body class="bg-gray-50 font-sans">

    <!-- Header cố định -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center h-20">
                <div class="flex items-center">
                    <!-- Logo và tên website -->
                    <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/home">
                        <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                        <div class="flex flex-col">
                            <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                            <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Nội dung chính -->
    <main class="min-h-screen pt-12 pb-20">
        <div class="container mx-auto px-4 max-w-3xl">
            
            <!-- Link quay lại trang chủ -->
            <div class="mb-8">
                <a class="flex items-center gap-2 text-gray-600 hover:text-ptit-red transition" href="${pageContext.request.contextPath}/home">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-arrow-left"><path d="m12 19-7-7 7-7"/><path d="M19 12H5"/></svg>
                    Quay lại trang chủ
                </a>
            </div>

            <!-- Khung chỉnh sửa hồ sơ -->
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="p-8">
                    <h2 class="text-2xl font-bold text-gray-900 mb-6">Chỉnh sửa thông tin cá nhân</h2>

                    <!-- Form chỉnh sửa thông tin cá nhân -->
                    <form method="post" action="profile" enctype="multipart/form-data" accept-charset="UTF-8" class="space-y-6">
                        
                        <!-- Avatar và upload ảnh -->
                        <div class="flex flex-col items-center p-6 bg-red-50 rounded-xl mb-6">
                            <div class="relative inline-block mb-4">
                                <c:choose>
                                    <%-- Nếu đã có avatar trong DB thì hiển thị ảnh đó --%>
                                    <c:when test="${profile != null && profile.avatarUrl != null}">
                                        <img src="${pageContext.request.contextPath}/${profile.avatarUrl}" class="w-32 h-32 rounded-full border-4 border-white shadow-lg object-cover">
                                    </c:when>
                                    <%-- Nếu chưa có avatar thì hiển thị chữ cái đầu của tên --%>
                                    <c:otherwise>
                                        <div class="w-32 h-32 rounded-full bg-white border-4 border-white shadow-lg flex items-center justify-center text-ptit-red text-4xl font-bold">
                                            ${profile.fullName.substring(0,1)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <label class="block">
                                <span class="sr-only">Chọn ảnh mới</span>
                                <input type="file" name="avatar" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-red-100 file:text-ptit-red hover:file:bg-red-200 cursor-pointer"/>
                            </label>
                        </div>

                        <!-- Thông tin cá nhân cơ bản -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Họ tên</label>
                                <input type="text" name="fullName" value="${profile.fullName}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Tiêu đề (Vị trí ứng tuyển)</label>
                                <input type="text" name="title" value="${profile.title}" placeholder="VD: Senior Developer" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Số điện thoại</label>
                                <input type="text" name="phone" value="${profile.phone}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition">
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Địa chỉ</label>
                                <input type="text" name="location" value="${profile.location}" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition">
                            </div>
                        </div>

                        <!-- Giới thiệu bản thân -->
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Giới thiệu bản thân</label>
                            <textarea name="aboutMe" rows="4" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition">${profile.aboutMe}</textarea>
                        </div>

                        <!-- Upload CV -->
                        <div class="border-t border-gray-100 pt-6">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Tài liệu CV (PDF)</label>
                            <%-- Nếu ứng viên đã upload CV từ trước thì hiển thị link --%>
                            <c:if test="${profile != null && profile.cvUrl != null}">
                                <div class="flex items-center gap-2 mb-3 text-sm text-ptit-red font-medium">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-file-text"><path d="M14.5 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7.5L14.5 2z"/><polyline points="14 2 14 8 20 8"/></svg>
                                    <a href="${pageContext.request.contextPath}/${profile.cvUrl}" target="_blank" class="hover:underline">CV hiện tại của bạn</a>
                                </div>
                            </c:if>
                            <input type="file" name="cv" class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-gray-100 file:text-gray-700 hover:file:bg-gray-200 cursor-pointer"/>
                        </div>

                        <!-- Nút lưu thay đổi -->
                        <div class="pt-4">
                            <button type="submit" class="w-full bg-ptit-red text-white font-bold py-3 px-6 rounded-xl hover:bg-ptit-darkred transition shadow-lg flex items-center justify-center gap-2">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-save"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                                Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="text-center py-8 text-gray-500 text-sm">
        <p>© 2026 Học viện Công nghệ Bưu chính Viễn thông. All rights reserved.</p>
    </footer>

</body>
</html>