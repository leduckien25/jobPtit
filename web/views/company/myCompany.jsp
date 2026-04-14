<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} | Công ty của tôi</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .bg-ptit-red { background-color: #be1e2d; }
        .text-ptit-red { color: #be1e2d; }
    </style>
</head>

<body class="bg-gray-50 font-sans">

<!-- HEADER -->
<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center h-20">

            <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/home">
                <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                <div class="flex flex-col">
                    <span class="text-ptit-red font-bold text-xl">JOBS</span>
                    <span class="text-gray-600 text-xs">PTIT.EDU.VN</span>
                </div>
            </a>

            <nav class="hidden md:flex gap-6">
                <a href="${pageContext.request.contextPath}/job-manage" class="text-gray-600 hover:text-ptit-red">Quản lý tin</a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="text-red-500">Đăng xuất</a>
            </nav>

        </div>
    </div>
</header>

<!-- MAIN -->
<main>

    <!-- Banner -->
    <div class="relative h-72 w-full">
        <img class="w-full h-full object-cover"
             src="https://images.unsplash.com/photo-1497215728101-856f4ea42174">
        <div class="absolute inset-0 bg-black/50"></div>
    </div>

    <!-- HEADER CARD -->
    <div class="container mx-auto px-4 -mt-20 relative z-10">

        <div class="bg-white rounded-2xl shadow-xl p-8 flex flex-col md:flex-row gap-6 items-center">

            <!-- LOGO -->
            <div class="w-40 h-40 bg-white rounded-xl shadow border p-3">
                <img src="${pageContext.request.contextPath}/${company.logoUrl}?t=${System.currentTimeMillis()}"
                    class="w-full h-full object-contain">
            </div>

            <!-- INFO -->
            <div class="flex-1 text-center md:text-left">

                <div class="flex flex-col md:flex-row md:items-center gap-3">

                    <h1 class="text-3xl font-bold">${company.name}</h1>

                    <c:choose>
                        <c:when test="${company.isVerified == 1}">
                            <span class="bg-green-100 text-green-600 px-3 py-1 rounded-full text-xs">
                                Đã xác thực
                            </span>
                        </c:when>
                        <c:when test="${company.isVerified == 0}">
                            <span class="bg-yellow-100 text-yellow-600 px-3 py-1 rounded-full text-xs">
                                Chờ duyệt
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="bg-red-100 text-red-600 px-3 py-1 rounded-full text-xs">
                                Bị từ chối
                            </span>
                        </c:otherwise>
                    </c:choose>

                </div>

                <p class="text-gray-500 mt-2">📍 ${company.location}</p>

                <!-- NÚT EDIT -->
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/recruiter/edit-company"
                       class="px-6 py-2 bg-ptit-red text-white rounded-lg font-bold hover:bg-red-700">
                        ✏️ Chỉnh sửa công ty
                    </a>
                </div>

            </div>

        </div>

    </div>

    <!-- CONTENT -->
    <div class="container mx-auto px-4 mt-10 grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- DESCRIPTION -->
        <div class="lg:col-span-2 bg-white p-6 rounded-xl shadow">
            <h2 class="text-xl font-bold mb-4">Giới thiệu công ty</h2>
            <p class="text-gray-600 whitespace-pre-line">
                ${company.description}
            </p>
        </div>

        <!-- CONTACT -->
        <div class="bg-white p-6 rounded-xl shadow">
            <h3 class="font-bold mb-4">Thông tin</h3>
            <p><b>Địa chỉ:</b> ${company.location}</p>
        </div>

    </div>

    <!-- JOB LIST -->
    <div class="container mx-auto px-4 mt-10">

        <h2 class="text-2xl font-bold mb-6">Việc làm đang tuyển</h2>

        <c:choose>
            <c:when test="${empty jobs}">
                <p class="text-gray-500">Chưa có job nào</p>
            </c:when>

            <c:otherwise>
                <div class="grid md:grid-cols-2 gap-4">

                    <c:forEach var="job" items="${jobs}">
                        <div class="border rounded-xl p-4 hover:shadow">

                            <a href="${pageContext.request.contextPath}/job?id=${job.id}"
                               class="font-bold text-lg hover:text-ptit-red">
                                ${job.title}
                            </a>

                            <p class="text-gray-500">${job.location}</p>

                            <p class="text-green-600 font-semibold">
                                <c:choose>
                                    <c:when test="${job.isNegotiable}">
                                        Thỏa thuận
                                    </c:when>
                                    <c:otherwise>
                                        ${job.salaryMin} - ${job.salaryMax}
                                    </c:otherwise>
                                </c:choose>
                            </p>

                        </div>
                    </c:forEach>

                </div>
            </c:otherwise>
        </c:choose>

    </div>

</main>

<!-- FOOTER -->
<footer class="bg-gray-900 text-white text-center py-6 mt-10">
    © 2026 PTIT JOBS
</footer>

</body>
</html>