<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ công ty | PTIT JOBS</title>

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
                        'ptit-light': '#fff1f0',
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
        .section-card { background: white; border: 1px solid #eee; border-radius: 12px; }
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
                <div class="flex flex-col gap-2 bg-white p-4 rounded-xl shadow-sm border border-gray-100">
                    <a href="${pageContext.request.contextPath}/job-manage" class="sidebar-link flex items-center gap-3 px-5 py-3 font-bold text-gray-500">
                        <i class="fa fa-file-lines w-5 text-center"></i> Tin tuyển dụng
                    </a>
                    <a href="${pageContext.request.contextPath}/recruiter/my-company" class="sidebar-link active flex items-center gap-3 px-5 py-3 font-bold">
                        <i class="fa fa-building w-5 text-center"></i> Hồ sơ công ty
                    </a>
                </div>
            </aside>

            <div class="lg:col-span-3">
                <div class="mb-6 flex items-center gap-2 text-sm font-medium text-gray-500">
                    <a href="${pageContext.request.contextPath}/recruiter/my-company" class="hover:text-ptit-red">Hồ sơ công ty</a>
                    <i class="fa fa-chevron-right text-[10px]"></i>
                    <span class="text-gray-900">Chỉnh sửa thông tin</span>
                </div>

                <div class="section-card overflow-hidden">
                    <div class="bg-gray-900 p-6 text-white">
                        <h1 class="text-xl font-bold">Cập nhật hồ sơ doanh nghiệp</h1>
                        <p class="text-xs text-gray-400 mt-1 uppercase tracking-wider font-semibold">Thông tin công khai trên hệ thống tuyển dụng</p>
                    </div>

                    <form action="${pageContext.request.contextPath}/recruiter/edit-company"
                          method="post"
                          enctype="multipart/form-data"
                          class="p-8 space-y-8">

                        <div class="grid md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-sm font-bold text-gray-700 mb-2">Tên công ty <span class="text-ptit-red">*</span></label>
                                <input type="text" name="name" value="${company.name}" required
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition font-medium">
                            </div>

                            <div>
                                <label class="block text-sm font-bold text-gray-700 mb-2">Địa điểm đặt trụ sở <span class="text-ptit-red">*</span></label>
                                <input type="text" name="location" value="${company.location}" required
                                       class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition font-medium" 
                                       placeholder="Ví dụ: Hà Đông, Hà Nội">
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-4">Logo thương hiệu</label>
                            <div class="flex items-center gap-6 p-4 bg-gray-50 rounded-2xl border border-dashed border-gray-300 w-fit">
                                <div class="w-24 h-24 bg-white border rounded-xl overflow-hidden shadow-sm flex items-center justify-center">
                                    <img id="previewImg"
                                         src="${pageContext.request.contextPath}/${company.logoUrl}"
                                         class="w-full h-full object-contain"
                                         onerror="this.src='https://placehold.co/200x200?text=No+Logo'">
                                </div>

                                <div class="space-y-2">
                                    <input type="file" name="logoFile" id="logoFile" accept="image/*"
                                           onchange="preview(event)"
                                           class="hidden">
                                    <label for="logoFile" class="inline-flex items-center gap-2 px-4 py-2 bg-white border border-gray-300 rounded-lg text-sm font-bold cursor-pointer hover:bg-gray-100 transition shadow-sm">
                                        <i class="fa fa-cloud-arrow-up text-ptit-red"></i> Chọn ảnh mới
                                    </label>
                                    <p class="text-[11px] text-gray-400 font-medium italic">* Để trống nếu muốn giữ nguyên ảnh hiện tại</p>
                                </div>
                            </div>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Giới thiệu về doanh nghiệp</label>
                            <textarea name="description" rows="8" required
                                      class="w-full px-4 py-3 border border-gray-200 rounded-xl focus:ring-2 focus:ring-red-100 focus:border-ptit-red outline-none transition resize-none leading-relaxed text-sm"
                                      placeholder="Hãy giới thiệu về lịch sử, môi trường làm việc và sứ mệnh của công ty...">${company.description}</textarea>
                        </div>

                        <div class="flex justify-end gap-4 pt-6 border-t border-gray-100">
                            <a href="${pageContext.request.contextPath}/recruiter/my-company"
                               class="px-8 py-3 text-gray-500 font-bold hover:text-gray-700 transition">
                                Hủy bỏ
                            </a>

                            <button type="submit"
                                    class="px-10 py-3 bg-ptit-red text-white font-extrabold rounded-xl hover:bg-ptit-hover transition shadow-lg shadow-red-100 active:scale-95">
                                <i class="fa fa-save me-2 text-xs"></i> LƯU THAY ĐỔI
                            </button>
                        </div>

                    </form>
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

<script>
    function preview(event) {
        const img = document.getElementById("previewImg");
        if(event.target.files.length > 0) {
            img.src = URL.createObjectURL(event.target.files[0]);
        }
    }
</script>

</body>
</html>