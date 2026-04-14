<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tiêu đề trang dùng tên công ty động từ biến company -->
    <title>${company.name} | Chi tiết công ty</title>
    
    <!-- Tailwind CSS để sử dụng các class tiện lợi -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Style tuỳ chỉnh màu sắc chuẩn PTIT -->
    <style>
        .bg-ptit-red { background-color: #be1e2d; } /* Nền đỏ PTIT */
        .text-ptit-red { color: #be1e2d; } /* Chữ đỏ PTIT */
        .border-ptit-red { border-color: #be1e2d; } /* Border đỏ PTIT */
    </style>
</head>
<body class="bg-gray-50 font-sans leading-normal tracking-normal">

    <!-- HEADER: logo + navbar -->
    <header class="bg-white shadow-sm sticky top-0 z-50">
        <div class="container mx-auto px-4">
            <div class="flex justify-between items-center h-20">
                <!-- Logo PTIT JOBS -->
                <div class="flex items-center">
                    <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/home">
                        <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                        <div class="flex flex-col">
                            <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                            <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                        </div>
                    </a>
                </div>
                <!-- Navbar: Trang chủ + Việc làm -->
                <nav class="hidden md:flex items-center space-x-8">
                    <a class="font-medium text-gray-600 hover:text-ptit-red" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    <a class="font-medium text-gray-600 hover:text-ptit-red" href="${pageContext.request.contextPath}/jobs">Việc làm</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- MAIN CONTENT -->
    <main class="flex-grow">
        <!-- Banner ảnh lớn -->
        <div class="relative h-64 md:h-80 w-full overflow-hidden">
            <img alt="Company Banner" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=1950&q=80">
            <!-- Overlay gradient để chữ nổi bật hơn -->
            <div class="absolute inset-0 bg-gradient-to-t from-gray-900/60 to-transparent"></div>
        </div>

        <!-- Khung thông tin công ty nổi trên banner -->
        <div class="container mx-auto px-4 -mt-24 relative z-10">
            <div class="bg-white rounded-[2rem] shadow-xl p-8 border border-gray-100 flex flex-col md:flex-row items-center md:items-end gap-8 mb-10">
                
                <!-- Logo công ty -->
                <div class="w-40 h-40 md:w-48 md:h-48 rounded-2xl bg-white p-4 shadow-lg flex-shrink-0 -mt-20 border-4 border-white">
                    <img alt="${company.name}" class="w-full h-full object-contain rounded-xl" 
                         src="${pageContext.request.contextPath}/${company.logoUrl}">
                </div>

                <!-- Tên công ty + trạng thái xác thực + vị trí -->
                <div class="flex-1 text-center md:text-left pb-2">
                    <div class="flex flex-col md:flex-row md:items-center gap-4 mb-3">
                        <!-- Tên công ty -->
                        <h1 class="text-4xl font-black text-gray-900 leading-tight">${company.name}</h1>
                        <!-- Tag xác thực -->
                        <c:choose>
                            <c:when test="${company.isVerified == 1}">
                                <span class="bg-blue-100 text-blue-600 px-4 py-1 rounded-full text-[10px] font-black uppercase">
                                    Đã xác thực
                                </span>
                            </c:when>
                            <c:when test="${company.isVerified == 0}">
                                <span class="bg-yellow-100 text-yellow-600 px-4 py-1 rounded-full text-[10px] font-black uppercase">
                                    Chờ duyệt
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="bg-red-100 text-red-600 px-4 py-1 rounded-full text-[10px] font-black uppercase">
                                    Bị từ chối
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Vị trí công ty -->
                    <div class="flex items-center justify-center md:justify-start gap-2 text-gray-500 mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="lucide lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
                        <span class="font-medium">${company.location}</span>
                    </div>
                </div>

            </div>

            <!-- Grid: giới thiệu công ty + thông tin liên hệ -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <!-- Giới thiệu công ty (chiếm 2 cột) -->
                <div class="lg:col-span-2 space-y-8">
                    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8">
                        <h2 class="text-2xl font-black text-gray-900 mb-6 flex items-center gap-3">
                            <!-- Thanh đỏ bên trái tiêu đề -->
                            <span class="w-2 h-8 bg-ptit-red rounded-full"></span>
                            Giới thiệu công ty
                        </h2>
                        <div class="text-gray-600 leading-loose text-lg whitespace-pre-line">
                            <!-- Nội dung giới thiệu công ty -->
                            ${company.description}
                        </div>
                    </div>
                </div>
                
                <!-- Thông tin liên hệ (1 cột bên phải) -->
                <div class="space-y-8">
                    <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8">
                        <h3 class="text-xl font-bold text-gray-900 mb-6">Thông tin liên hệ</h3>
                        <div class="space-y-6">
                            <div>
                                <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-2">Địa chỉ</span>
                                <p class="text-gray-900 font-bold">${company.location}</p>
                            </div>
                            <div>
                                <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-2">Website</span>
                                <a href="#" class="text-blue-600 font-bold hover:underline">abc-tech.com.vn</a>
                            </div>
                        </div>
                    </div>
                </div>
                            
                <!-- Danh sách việc làm -->
                <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-8 mt-8">
                    <h2 class="text-2xl font-black text-gray-900 mb-6 flex items-center gap-3">
                        <span class="w-2 h-8 bg-ptit-red rounded-full"></span>
                        Việc làm đang tuyển
                    </h2>

                    <c:choose>
                        <c:when test="${empty jobs}">
                            <p class="text-gray-500">Hiện tại chưa có việc làm nào.</p>
                        </c:when>

                        <c:otherwise>
                            <div class="space-y-4">
                                <c:forEach var="job" items="${jobs}">
                                    <div class="border rounded-xl p-5 hover:shadow-md transition">

                                        <!-- Title -->
                                        <a href="${pageContext.request.contextPath}/job?id=${job.id}"
                                           class="text-lg font-bold text-gray-800 hover:text-ptit-red">
                                            ${job.title}
                                        </a>

                                        <!-- Location -->
                                        <p class="text-gray-500 mt-1">
                                            📍 ${job.location}
                                        </p>

                                        <!-- Salary -->
                                        <p class="text-green-600 font-semibold mt-2">
                                            <c:choose>
                                                <c:when test="${job.isNegotiable}">
                                                    Thỏa thuận
                                                </c:when>
                                                <c:otherwise>
                                                    ${job.salaryMin} - ${job.salaryMax} VND
                                                </c:otherwise>
                                            </c:choose>
                                        </p>

                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
            </div>
        </div>
    </main>

    <!-- FOOTER -->
    <footer class="bg-gray-900 text-white py-12 mt-20">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-500">© 2026 PTIT JOBS. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

</body>
</html>