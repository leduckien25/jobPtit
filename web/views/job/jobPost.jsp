<%-- 
    Document   : jobPost
    Created on : Mar 17, 2026, 12:23:59 AM
    Author     : HP
--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng tin tuyển dụng - JobPtit</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ptit-red': '#E11D48',
                        'ptit-darkred': '#BE123C',
                    }
                }
            }
        }
    </script>
    <style>
        .sticky-bottom {
            position: sticky;
            bottom: 1.5rem;
            z-index: 40;
        }
        input:focus, textarea:focus, select:focus {
            ring: 2px;
            ring-color: #E11D48;
            outline: none;
        }
        /* Hiệu ứng chuyển trạng thái cho phần lương */
        .salary-disabled {
            opacity: 0.5;
            pointer-events: none;
            user-select: none;
        }
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
<!--                            <div class="hidden md:flex items-center gap-3 pl-6 border-l ml-6">
                                <a class="px-5 py-2 border border-gray-300 text-gray-700 text-sm font-bold rounded hover:bg-gray-50 transition" href="${pageContext.request.contextPath}/recruiter/dashboard">Quản lý tin</a>
                                <a class="px-5 py-2 bg-ptit-red text-white text-sm font-bold rounded hover:bg-red-700 transition" href="${pageContext.request.contextPath}/recruiter/post-job">Đăng tin ngay</a>
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
                <div class="pt-12 pb-20">
                    <div class="container mx-auto px-4 max-w-4xl">
                        <div class="mb-8">
                            <a class="inline-flex items-center gap-2 text-gray-600 hover:text-ptit-red transition mb-4 font-medium" href="${pageContext.request.contextPath}/job-manage">
                                ← Quay lại
                            </a>
                            <h1 class="text-3xl font-bold text-gray-900 mb-2">Đăng tin tuyển dụng mới</h1>
                            <p class="text-gray-600">Thu hút nhân tài PTIT bằng những bản mô tả công việc chi tiết và hấp dẫn.</p>
                        </div>

                        <%-- Thông báo --%>
                        <div class="mt-4">
                            <c:if test="${not empty sessionScope.message}">
                                <div class="p-4 mb-6 rounded-xl flex items-center gap-3 shadow-sm border 
                                    ${sessionScope.msgType == 'success' ? 'bg-green-50 text-green-700 border-green-200' : 'bg-red-50 text-red-700 border-red-200'}">
                                    <span class="text-xl">${sessionScope.msgType == 'success' ? '✅' : '❌'}</span>
                                    <span class="font-medium">${sessionScope.message}</span>
                                    <c:remove var="message" scope="session" />
                                    <c:remove var="msgType" scope="session" />
                                </div>
                            </c:if>
                        </div>

                        <form action="${pageContext.request.contextPath}/job" method="POST" class="space-y-8">
                            <input name="action" type="hidden" value="job-post"/>

                            <%-- SECTION 1: THÔNG TIN CHUNG --%>
                            <div class="bg-white rounded-2xl p-8 shadow-sm border border-gray-100">
                                <h2 class="text-xl font-bold text-gray-900 mb-6 flex items-center gap-2 text-ptit-red">💼 Thông tin chung</h2>
                                <div class="grid md:grid-cols-2 gap-6">
                                    <div class="md:col-span-2">
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Tiêu đề vị trí tuyển dụng *</label>
                                        <input name="title" value="${not empty oldJob ? oldJob.title : param.title}" 
                                               class="w-full px-4 py-3 rounded-xl border ${not empty errors.title ? 'border-red-500' : 'border-gray-200'} outline-none focus:border-ptit-red transition" type="text" placeholder="Ví dụ: Senior Frontend Developer">
                                        <c:if test="${not empty errors.title}"><p class="text-red-500 text-xs mt-1">${errors.title}</p></c:if>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Địa điểm làm việc *</label>
                                        <select name="location" class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white outline-none focus:border-ptit-red transition appearance-none cursor-pointer">
                                            <option value="ha-noi" ${(oldJob.location == 'ha-noi' || param['location'] == 'ha-noi') ? 'selected' : ''}>Hà Nội</option>
                                            <option value="da-nang" ${(oldJob.location == 'da-nang' || param['location'] == 'da-nang') ? 'selected' : ''}>Đà Nẵng</option>
                                            <option value="tp-hcm" ${(oldJob.location == 'tp-hcm' || param['location'] == 'tp-hcm') ? 'selected' : ''}>TP. Hồ Chí Minh</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Hình thức làm việc *</label>
                                        <select name="job-type" class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white outline-none focus:border-ptit-red transition appearance-none cursor-pointer">
                                            <option value="1" ${(oldJob.jobType == 1 || param['job-type'] == '1') ? 'selected' : ''}>FullTime</option>
                                            <option value="2" ${(oldJob.jobType == 2 || param['job-type'] == '2') ? 'selected' : ''}>PartTime</option>
                                            <option value="3" ${(oldJob.jobType == 3 || param['job-type'] == '3') ? 'selected' : ''}>Internship</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Loại hình công việc *</label>
                                        <select name="category" class="w-full px-4 py-3 rounded-xl border border-gray-200 bg-white outline-none focus:border-ptit-red transition appearance-none cursor-pointer">
                                            <c:forEach items="${categories}" var="cat">
                                                <option value="${cat.id}" ${(oldJob.categoryId == cat.id || param.category == cat.id) ? 'selected' : ''}>
                                                    ${cat.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

               
                                    <div class="md:col-span-1">
                                    <label class="block text-sm font-bold text-gray-700 mb-2">Hạn nộp hồ sơ *</label>
                                    <div class="relative">
                                        <input name="deadline" 
                                               value="${not empty oldJob ? oldJob.deadline : param.deadline}" 
                                               type="date"
                                               class="w-full px-4 py-3 rounded-xl border ${not empty errors.deadline ? 'border-red-500' : 'border-gray-200'} outline-none focus:border-ptit-red transition cursor-pointer"
                                               id="deadline-input">
                                        <c:if test="${not empty errors.deadline}">
                                            <p class="text-red-500 text-xs mt-1">${errors.deadline}</p>
                                        </c:if>
                                    </div>
                                    <p class="text-gray-400 text-[11px] mt-1.5 flex items-center gap-1">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                                        Tin tuyển dụng sẽ tự động ẩn sau ngày này.
                                    </p>
                                </div>
                                </div>
                            </div>

                            <%-- SECTION 2: MỨC LƯƠNG --%>
                            <div class="bg-white rounded-2xl p-8 shadow-sm border border-gray-100">
                                <h2 class="text-xl font-bold text-gray-900 mb-6 flex items-center gap-2 text-ptit-red">💰 Mức lương</h2>
                                
                                <div class="flex items-center gap-3 mb-6 p-4 bg-gray-50 rounded-xl border border-dashed border-gray-300 w-fit">
                                    <input id="negotiable" name="negotiable" type="checkbox" 
                                           ${not empty param.negotiable ? 'checked' : ''} 
                                           class="w-5 h-5 accent-ptit-red cursor-pointer"
                                           onchange="toggleSalaryInputs(this.checked)">
                                    <label for="negotiable" class="text-gray-700 font-bold cursor-pointer select-none">Mức lương thỏa thuận</label>
                                </div>

                                <div id="salary-range-container" class="grid md:grid-cols-2 gap-6 transition-all duration-300">
                                    <div>
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Mức lương tối thiểu (VNĐ)</label>
                                        <input id="salary-min" name="salary-min" value="${param['salary-min']}" 
                                               class="salary-input w-full px-4 py-3 rounded-xl border ${not empty errors.salaryMin ? 'border-red-500' : 'border-gray-200'} outline-none focus:border-ptit-red transition disabled:bg-gray-100 disabled:cursor-not-allowed" 
                                               type="number" placeholder="Ví dụ: 10000000">
                                        <c:if test="${not empty errors.salaryMin}"><p class="text-red-500 text-xs mt-1">${errors.salaryMin}</p></c:if>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-bold text-gray-700 mb-2">Mức lương tối đa (VNĐ)</label>
                                        <input id="salary-max" name="salary-max" value="${param['salary-max']}" 
                                               class="salary-input w-full px-4 py-3 rounded-xl border ${not empty errors.salaryMax ? 'border-red-500' : 'border-gray-200'} outline-none focus:border-ptit-red transition disabled:bg-gray-100 disabled:cursor-not-allowed" 
                                               type="number" placeholder="Ví dụ: 20000000">
                                        <c:if test="${not empty errors.salaryMax}"><p class="text-red-500 text-xs mt-1">${errors.salaryMax}</p></c:if>
                                    </div>
                                </div>
                            </div>

                            <%-- SECTION 3: MÔ TẢ --%>
                            <div class="bg-white rounded-2xl p-8 shadow-sm border border-gray-100">
                                <h2 class="text-xl font-bold text-gray-900 mb-6 flex items-center gap-2 text-ptit-red">📝 Nội dung chi tiết</h2>
                                <textarea name="description" rows="5" placeholder="Nhập mô tả công việc, yêu cầu ứng viên..." 
                                          class="w-full px-4 py-3 rounded-xl border border-gray-200 outline-none focus:border-ptit-red transition resize-none">${not empty oldJob ? oldJob.description : param.description}</textarea>
                            </div>


                            <%-- ACTION BUTTONS --%>
                            <div class="flex items-center justify-end gap-6 bg-white p-6 rounded-2xl border border-gray-100 shadow-lg sticky-bottom">
                                <a href="${pageContext.request.contextPath}/job-manage" class="px-8 py-4 text-gray-600 font-bold hover:text-red-600 transition">Hủy bỏ</a>
                                <button type="submit" class="px-12 py-4 bg-ptit-red text-white font-bold rounded-xl hover:bg-red-700 transition shadow-lg active:scale-95">Đăng tin ngay</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>

            <footer class="bg-gray-900 text-white pt-16 pb-8">
                <div class="container mx-auto px-4 text-center border-t border-gray-800 pt-8">
                    <p>© 2026 Học viện Công nghệ Bưu chính Viễn thông. All rights reserved.</p>
                </div>
            </footer>
        </div>
    </div>

    <script>
        function toggleSalaryInputs(isNegotiable) {
            const salaryInputs = document.querySelectorAll('.salary-input');
            const container = document.getElementById('salary-range-container');
            
            if (isNegotiable) {
                container.classList.add('salary-disabled');
                salaryInputs.forEach(input => {
                    input.value = ''; // Reset giá trị
                    input.disabled = true;
                    input.required = false;
                });
            } else {
                container.classList.remove('salary-disabled');
                salaryInputs.forEach(input => {
                    input.disabled = false;
                });
            }
        }

        // Kiểm tra trạng thái khi trang load (dành cho trường hợp quay lại trang khi có lỗi validate)
        document.addEventListener('DOMContentLoaded', function() {
            const negotiableCheckbox = document.getElementById('negotiable');
            if (negotiableCheckbox) {
                toggleSalaryInputs(negotiableCheckbox.checked);
            }
            const deadlineInput = document.getElementById('deadline-input');
                if (deadlineInput) {
                const today = new Date().toISOString().split('T')[0];
                deadlineInput.setAttribute('min', today);
            }
        });
    </script>

</body>
</html>