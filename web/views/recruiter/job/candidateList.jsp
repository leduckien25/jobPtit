<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- BẮT BUỘC PHẢI CÓ DÒNG NÀY ĐỂ TRÁNH LỖI JASPER EXCEPTION --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách ứng viên | PTIT JOBS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; }
        .ptit-red { color: #da1f26; }
        .bg-ptit-red { background-color: #da1f26; }
        .section-card { background: white; border: 1px solid #eee; border-radius: 12px; }
        tr.candidate-row:hover { background-color: #fff1f0; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
    <nav class="bg-white shadow-sm py-3 border-b border-gray-100 sticky top-0 z-50">
        <div class="container mx-auto px-5 flex justify-between items-center">
            <a class="flex items-center text-2xl font-extrabold text-ptit-red" href="${pageContext.request.contextPath}/job-manage">
                <span class="bg-ptit-red text-white px-2 rounded-lg mr-2">P</span> JOBS
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout" class="text-sm font-bold ptit-red hover:underline">Đăng xuất</a>
        </div>
    </nav>

    <main class="container mx-auto px-4 py-10">
        <div class="grid lg:grid-cols-4 gap-8">
            <aside class="lg:col-span-1">
                <div class="flex flex-col gap-2">
                    <a href="${pageContext.request.contextPath}/job-manage" class="bg-ptit-red text-white flex items-center gap-3 px-5 py-3 font-bold rounded-xl shadow-lg shadow-red-100">
                        <i class="fa fa-file-lines"></i> Tin tuyển dụng
                    </a>
                </div>
            </aside>

            <div class="lg:col-span-3">
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h1 class="text-3xl font-extrabold text-gray-900">Danh sách ứng viên</h1>
                        <p class="text-gray-500 mt-1 font-medium">Vị trí: <span class="ptit-red uppercase font-bold">${jobTitle}</span></p>
                    </div>
                    <a href="${pageContext.request.contextPath}/job-manage" class="text-gray-400 font-bold hover:text-ptit-red transition text-sm">
                        <i class="fa fa-arrow-left mr-1"></i> Quay lại
                    </a>
                </div>

                <div class="section-card shadow-sm overflow-hidden">
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-gray-50 border-b border-gray-100 uppercase text-[10px] font-bold text-gray-400">
                            <tr>
                                <th class="px-6 py-4">Ứng viên</th>
                                <th class="px-6 py-4 text-center">Ngày nộp</th>
                                <th class="px-6 py-4 text-center">Trạng thái</th>
                                <th class="px-6 py-4 text-center">Hồ sơ (CV)</th>
                                <th class="px-6 py-4 text-right">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach items="${candidateList}" var="ad">
    
                                <%-- 1. XỬ LÝ ĐƯỜNG DẪN ẢNH (AVATAR) --%>
                                <c:set var="finalAvatar" value="" />
                                <c:choose>
                                    <%-- Giả sử file ảnh bạn lưu trong thư mục 'uploads' của project --%>
                                    <c:when test="${not empty ad.profile.avatarUrl}">
                                        <c:set var="finalAvatar" value="${pageContext.request.contextPath}/${ad.profile.avatarUrl}" />
                                    </c:when>
                                    <%-- Nếu không có ảnh, dùng ảnh mặc định tạo từ tên --%>
                                    <c:otherwise>
                                        <c:set var="finalAvatar" value="https://ui-avatars.com/api/?name=${fn:escapeXml(ad.profile.fullName)}&background=random" />
                                    </c:otherwise>
                                </c:choose>

                                <%-- 2. XỬ LÝ ĐƯỜNG DẪN CV --%>
                                <c:set var="finalCv" value="" />
                                <c:if test="${not empty ad.profile.cvUrl}">
                                    <c:set var="finalCv" value="${pageContext.request.contextPath}/${ad.profile.cvUrl}" />
                                </c:if>

                                <%-- 3. TRUYỀN DỮ LIỆU ĐÃ XỬ LÝ VÀO THẺ TR --%>
                                <tr class="candidate-row transition cursor-pointer group" 
                                    data-name="${not empty ad.profile.fullName ? fn:escapeXml(ad.profile.fullName) : ''}"
                                    data-title="${not empty ad.profile.title ? fn:escapeXml(ad.profile.title) : ''}"
                                    data-email="${not empty ad.email ? fn:escapeXml(ad.email) : ''}"
                                    data-phone="${not empty ad.profile.phone ? fn:escapeXml(ad.profile.phone) : ''}"
                                    data-about="${not empty ad.profile.aboutMe ? fn:escapeXml(ad.profile.aboutMe) : ''}"
                                    data-avatar="${finalAvatar}"
                                    data-cv="${finalCv}"
                                    onclick="handleRowClick(this)">

                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <%-- Hiển thị Avatar ở bảng ngoài --%>
                                            <img src="${finalAvatar}" class="w-10 h-10 rounded-full border shadow-sm object-cover bg-white">
                                            <div>
                                                <div class="font-bold text-gray-900 group-hover:text-red-600 transition">${ad.profile.fullName}</div>
                                                <div class="text-[10px] text-gray-400 font-bold uppercase">${ad.profile.title}</div>
                                            </div>
                                        </div>
                                    </td>

                                    <td class="px-6 py-4 text-center text-xs font-medium text-gray-500">
                                        ${ad.appliedAtFormatted}
                                    </td>

                                    <td class="px-6 py-4 text-center">
                                        <c:choose>
                                            <c:when test="${ad.status == 0}">
                                                <span class="px-2 py-1 rounded bg-yellow-50 text-yellow-600 text-[10px] font-bold uppercase tracking-wider">Mới nộp</span>
                                            </c:when>
                                            <c:when test="${ad.status == 3}">
                                                <span class="px-2 py-1 rounded bg-red-50 text-red-600 text-[10px] font-bold uppercase tracking-wider">Từ chối</span>
                                            </c:when>
                                            <c:when test="${ad.status == 4}">
                                                <span class="px-2 py-1 rounded bg-green-50 text-green-600 text-[10px] font-bold uppercase tracking-wider">Đã nhận</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 py-1 rounded bg-blue-50 text-blue-600 text-[10px] font-bold uppercase tracking-wider">Đang xem</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-6 py-4 text-center" onclick="event.stopPropagation()">
                                        <%-- Hiển thị nút XEM CV ở bảng ngoài --%>
                                        <c:choose>
                                            <c:when test="${not empty finalCv}">
                                                <a href="${finalCv}" target="_blank" 
                                                   class="inline-flex items-center gap-1 px-3 py-1.5 bg-red-50 text-ptit-red rounded-lg font-bold text-[10px] hover:bg-ptit-red hover:text-white transition shadow-sm">
                                                    <i class="fa fa-file-pdf"></i> XEM CV
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-[10px] font-bold text-gray-400 italic">Chưa nộp CV</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td class="px-6 py-4 text-right" onclick="event.stopPropagation()">
                                        <form action="${pageContext.request.contextPath}/recruiter/update-status" method="POST" class="inline">
                                            <input type="hidden" name="appId" value="${ad.appId}">
                                            <input type="hidden" name="jobId" value="${jobId}">
                                            <select name="newStatus" onchange="this.form.submit()" class="text-[10px] font-bold bg-gray-100 rounded p-1.5 border-none outline-none focus:ring-1 focus:ring-red-500">
                                                <option value="0" ${ad.status == 0 ? 'selected' : ''}>Chờ duyệt</option>
                                                <option value="1" ${ad.status == 1 ? 'selected' : ''}>Đã xem</option>
                                                <option value="2" ${ad.status == 2 ? 'selected' : ''}>Phỏng vấn</option>
                                                <option value="3" ${ad.status == 3 ? 'selected' : ''}>Từ chối</option>
                                                <option value="4" ${ad.status == 4 ? 'selected' : ''}>Nhận</option>
                                            </select>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty candidateList}">
                        <div class="py-20 text-center border-t border-gray-100">
                            <i class="fa fa-user-slash text-gray-200 text-5xl mb-4"></i>
                            <p class="text-gray-400 font-bold">Chưa có ai ứng tuyển cho vị trí này.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <div id="m" class="hidden fixed inset-0 z-[60] flex items-center justify-center bg-black/60 backdrop-blur-sm p-4" onclick="closeModal()">
        <div class="bg-white w-full max-w-xl rounded-2xl shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-200" onclick="event.stopPropagation()">
            <div class="h-20 bg-ptit-red relative">
                <button onclick="closeModal()" class="absolute top-4 right-4 text-white/70 hover:text-white transition">
                    <i class="fa fa-times text-xl"></i>
                </button>
            </div>
            <div class="px-8 pb-8">
                <div class="relative -mt-10 mb-6 flex items-end gap-4">
                    <img id="mAv" src="" class="w-24 h-24 rounded-2xl border-4 border-white shadow-lg object-cover bg-white">
                    <div class="pb-1">
                        <h2 id="mNa" class="text-2xl font-black text-gray-900"></h2>
                        <p id="mTi" class="ptit-red font-bold text-xs uppercase tracking-wider"></p>
                    </div>
                </div>
                <div class="grid grid-cols-2 gap-4 mb-6 text-sm text-gray-600 border-y py-4">
                    <div><i class="fa fa-envelope ptit-red mr-2 w-4"></i><span id="mEm"></span></div>
                    <div><i class="fa fa-phone ptit-red mr-2 w-4"></i><span id="mPh"></span></div>
                </div>
                <div class="mb-8">
                    <label class="text-[10px] font-bold text-gray-300 uppercase block mb-2">Giới thiệu ứng viên</label>
                    <div id="mAb" class="text-sm text-gray-600 bg-gray-50 p-5 rounded-2xl leading-relaxed italic border border-gray-100 min-h-[100px] whitespace-pre-wrap"></div>
                </div>
                <div class="flex gap-3">
                    <a id="mCv" href="#" target="_blank" class="flex-grow flex items-center justify-center gap-2 py-3.5 bg-ptit-red text-white font-bold rounded-xl hover:bg-red-700 transition shadow-lg shadow-red-100">
                        <i class="fa fa-file-pdf"></i> XEM HỒ SƠ GỐC (CV)
                    </a>
                    <button onclick="closeModal()" class="px-6 py-3.5 bg-gray-100 text-gray-600 font-bold rounded-xl hover:bg-gray-200 transition">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function handleRowClick(row) {
            const data = row.dataset;
            document.getElementById('mNa').innerText = data.name;
            document.getElementById('mTi').innerText = data.title || 'CHƯA CẬP NHẬT';
            document.getElementById('mEm').innerText = data.email;
            document.getElementById('mPh').innerText = data.phone || 'N/A';
            document.getElementById('mAb').innerText = data.about || 'Ứng viên này chưa viết giới thiệu bản thân.';
            document.getElementById('mAv').src = data.avatar || 'https://ui-avatars.com/api/?name=' + encodeURIComponent(data.name);
            document.getElementById('mCv').href = data.cv;
            
            document.getElementById('m').classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }

        function closeModal() {
            document.getElementById('m').classList.add('hidden');
            document.body.style.overflow = 'auto';
        }
    </script>
</body>
</html>