<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng tin tuyển dụng | PTIT JOBS</title>
    
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
                    },
                    fontFamily: {
                        'inter': ['Inter', 'sans-serif'],
                    }
                }
            }
        }
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }
        .logo-box { background: #da1f26; color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; font-weight: 800; }
        .salary-disabled { opacity: 0.5; pointer-events: none; user-select: none; background-color: #f3f4f6; }
        .form-card { background: white; border: 1px solid #eee; border-radius: 12px; }
    </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

    <nav class="bg-white shadow-sm border-b border-gray-100 py-3 sticky top-0 z-50">
        <div class="container mx-auto px-5 flex justify-between items-center">
            <a class="flex items-center text-2xl font-extrabold text-ptit-red" href="${pageContext.request.contextPath}/job-manage">
                <span class="logo-box">P</span> JOBS
            </a>
            <div class="flex items-center gap-4">
                <span class="font-bold text-gray-500 text-sm uppercase tracking-wider"><i class="fa fa-user-tie me-1"></i>RECRUITER</span>
                <div class="h-6 w-px bg-gray-200"></div>
                <a href="${pageContext.request.contextPath}/auth/logout" class="text-ptit-red font-bold text-sm hover:underline">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <main class="flex-grow py-10">
        <div class="container mx-auto px-4 max-w-4xl">
            <div class="mb-8">
                <a class="text-gray-500 hover:text-ptit-red transition mb-4 inline-block font-semibold text-sm" href="${pageContext.request.contextPath}/job-manage">
                    <i class="fa fa-arrow-left me-1"></i> Quay lại quản lý
                </a>
                <h1 class="text-3xl font-extrabold text-gray-900">Đăng tin tuyển dụng</h1>
                <p class="text-gray-500 mt-1">Tìm kiếm nhân tài xuất sắc từ cộng đồng sinh viên PTIT.</p>
            </div>

            <%-- Thông báo phản hồi --%>
            <c:if test="${not empty sessionScope.message}">
                <div class="p-4 mb-6 rounded-lg border flex items-center gap-3 ${sessionScope.msgType == 'success' ? 'bg-green-50 border-green-200 text-green-700' : 'bg-red-50 border-red-200 text-red-700'}">
                    <i class="fa ${sessionScope.msgType == 'success' ? 'fa-check-circle' : 'fa-times-circle'} text-xl"></i>
                    <span class="font-bold">${sessionScope.message}</span>
                    <c:remove var="message" scope="session" />
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/job" method="POST" class="space-y-6">
                <input name="action" type="hidden" value="job-post"/>

                <div class="form-card p-8">
                    <h2 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
                        <i class="fa fa-briefcase text-ptit-red"></i> Thông tin vị trí
                    </h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-sm font-bold text-gray-700 mb-2">Tiêu đề vị trí tuyển dụng <span class="text-ptit-red">*</span></label>
                            <input name="title" value="${not empty oldJob ? oldJob.title : param.title}" 
                                   class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red focus:border-ptit-red outline-none transition" 
                                   type="text" placeholder="Ví dụ: Java Backend Developer (Junior/Senior)">
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Địa điểm làm việc <span class="text-ptit-red">*</span></label>
                            <select name="location" class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none cursor-pointer bg-white">
                                <option value="Hà Nội" ${oldJob.location == 'Hà Nội' ? 'selected' : ''}>Hà Nội</option>
                                <option value="Đà Nẵng" ${oldJob.location == 'Đà Nẵng' ? 'selected' : ''}>Đà Nẵng</option>
                                <option value="TP. Hồ Chí Minh" ${oldJob.location == 'TP. Hồ Chí Minh' ? 'selected' : ''}>TP. Hồ Chí Minh</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Hình thức làm việc <span class="text-ptit-red">*</span></label>
                            <select name="job-type" class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none cursor-pointer bg-white">
                                <option value="1">Toàn thời gian (Full-time)</option>
                                <option value="2">Bán thời gian (Part-time)</option>
                                <option value="3">Thực tập (Internship)</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Loại hình công việc <span class="text-ptit-red">*</span></label>
                            <select name="category" class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none cursor-pointer bg-white">
                                <c:forEach items="${categories}" var="cat">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Hạn nộp hồ sơ <span class="text-ptit-red">*</span></label>
                            <input name="deadline" type="date" id="deadline-input" 
                                   class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none cursor-pointer">
                        </div>
                    </div>
                </div>

                <div class="form-card p-8">
                    <h2 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
                        <i class="fa fa-coins text-ptit-red"></i> Mức lương
                    </h2>
                    
                    <div class="flex items-center gap-2 mb-6">
                        <input id="negotiable" name="negotiable" type="checkbox" onchange="toggleSalaryInputs(this.checked)"
                               class="w-5 h-5 accent-ptit-red cursor-pointer">
                        <label for="negotiable" class="text-gray-700 font-bold cursor-pointer">Mức lương thỏa thuận</label>
                    </div>

                    <div id="salary-range-container" class="grid grid-cols-1 md:grid-cols-2 gap-6 transition-opacity">
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Lương tối thiểu (VNĐ)</label>
                            <input name="salary-min" type="number" placeholder="10.000.000"
                                   class="salary-input w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none">
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-gray-700 mb-2">Lương tối đa (VNĐ)</label>
                            <input name="salary-max" type="number" placeholder="20.000.000"
                                   class="salary-input w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none">
                        </div>
                    </div>
                </div>

                <div class="form-card p-8">
                    <h2 class="text-lg font-bold text-gray-800 mb-6 flex items-center gap-2">
                        <i class="fa fa-pen-to-square text-ptit-red"></i> Nội dung chi tiết
                    </h2>
                    <textarea name="description" rows="8" placeholder="Mô tả công việc, yêu cầu ứng viên và quyền lợi..." 
                              class="w-full px-4 py-3 rounded-lg border border-gray-200 focus:ring-2 focus:ring-ptit-red outline-none resize-none transition-all"></textarea>
                </div>

                <div class="flex items-center justify-end gap-4 py-6">
                    <a href="${pageContext.request.contextPath}/job-manage" class="px-6 py-3 text-gray-500 font-bold hover:text-gray-700 transition">Hủy bỏ</a>
                    <button type="submit" class="px-10 py-3 bg-ptit-red text-white font-extrabold rounded-lg hover:bg-ptit-hover transition transform active:scale-95 shadow-md">
                        <i class="fa fa-paper-plane me-2"></i> ĐĂNG TIN NGAY
                    </button>
                </div>
            </form>
        </div>
    </main>

    <footer class="bg-gray-900 text-white py-10 mt-10">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-400 text-sm">© 2026 Học viện Công nghệ Bưu chính Viễn thông. Cổng thông tin việc làm JobPtit.</p>
        </div>
    </footer>

    <script>
        function toggleSalaryInputs(isNegotiable) {
            const salaryInputs = document.querySelectorAll('.salary-input');
            const container = document.getElementById('salary-range-container');
            
            if (isNegotiable) {
                container.classList.add('salary-disabled');
                salaryInputs.forEach(input => {
                    input.value = '';
                    input.disabled = true;
                });
            } else {
                container.classList.remove('salary-disabled');
                salaryInputs.forEach(input => {
                    input.disabled = false;
                });
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('deadline-input').setAttribute('min', today);
        });
    </script>
</body>
</html>