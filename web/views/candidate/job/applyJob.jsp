<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận ứng tuyển | PTIT JOBS</title>
    
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
                    }
                }
            }
        }
    </script>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8f9fa; color: #333; }
        .logo-box { background: #da1f26; color: white; padding: 2px 10px; border-radius: 6px; margin-right: 8px; font-weight: 800; }
        .confirm-card { background: white; border: 1px solid #eee; border-radius: 20px; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05); }
    </style>
</head>
<body class="flex flex-col min-h-screen">

    <nav class="bg-white shadow-sm border-b border-gray-100 py-4 sticky top-0 z-50">
        <div class="container mx-auto px-5 flex justify-between items-center">
            <a class="flex items-center text-2xl font-extrabold text-ptit-red" href="${pageContext.request.contextPath}/home">
                <span class="logo-box">P</span> JOBS
            </a>
            <div class="text-sm font-bold text-gray-400 uppercase tracking-widest">
                Xác nhận nộp đơn
            </div>
        </div>
    </nav>

    <main class="flex-grow flex items-center justify-center py-12 px-4">
        <div class="confirm-card w-full max-w-md p-8 text-center">
            
            <form action="${pageContext.request.contextPath}/apply" method="post">
                <div class="mb-6">
                    <div class="w-16 h-16 bg-red-50 text-ptit-red rounded-full flex items-center justify-center mx-auto mb-4 text-2xl">
                        <i class="fa fa-paper-plane"></i>
                    </div>
                    <h2 class="text-2xl font-black text-gray-900 uppercase tracking-tight">Xác nhận ứng tuyển</h2>
                </div>
                
                <div class="bg-gray-50 rounded-2xl p-5 border border-gray-100 mb-6 group transition-all">
                    <span class="block text-lg font-extrabold text-gray-800 leading-tight mb-1">
                        ${param.jobTitle}
                    </span>
                    <span class="block text-sm font-bold text-ptit-red uppercase tracking-wider">
                        <i class="fa fa-building mr-1"></i> ${param.companyName}
                    </span>
                </div>

                <input type="hidden" name="jobId" value="${param.jobId}">
                
                <div class="bg-blue-50 border border-blue-100 rounded-xl p-4 mb-8 flex gap-3 text-left">
                    <i class="fa fa-circle-info text-blue-500 mt-1"></i>
                    <p class="text-xs font-medium text-blue-700 leading-relaxed">
                        Hệ thống sẽ tự động gửi hồ sơ cá nhân (Họ tên, SĐT, Email, CV) của bạn đến Nhà tuyển dụng này.
                    </p>
                </div>

                <p class="text-sm text-gray-500 font-medium mb-8">Bạn có chắc chắn muốn nộp đơn vào vị trí này?</p>
                
                <c:choose>
                    <c:when test="${empty sessionScope.LOGIN_USER}">
                        <div class="bg-red-50 text-red-600 p-4 rounded-xl border border-red-100 text-sm font-bold">
                            <i class="fa fa-lock mr-2"></i>
                            Vui lòng <a href="${pageContext.request.contextPath}/auth/login" class="underline hover:text-ptit-hover">đăng nhập</a> để ứng tuyển.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${sessionScope.LOGIN_USER.role == 1}">
                            <button type="submit" class="w-full py-4 bg-ptit-red text-white font-black rounded-xl hover:bg-ptit-hover transition-all shadow-lg shadow-red-100 uppercase tracking-widest text-sm">
                                Nộp đơn ngay
                            </button>
                        </c:if>
                        <c:if test="${sessionScope.LOGIN_USER.role != 1}">
                            <div class="bg-amber-50 text-amber-700 p-4 rounded-xl border border-amber-100 text-sm font-bold">
                                <i class="fa fa-triangle-exclamation mr-2"></i>
                                Chỉ tài khoản Ứng viên mới có thể nộp đơn.
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
                
                <div class="mt-6">
                    <a href="${pageContext.request.contextPath}/" class="text-gray-400 font-bold text-xs uppercase tracking-widest hover:text-gray-600 transition-colors">
                        <i class="fa fa-xmark mr-1"></i> Hủy bỏ
                    </a>
                </div>
            </form>
            
            <c:if test="${not empty msg}">
                <div class="mt-4 p-3 bg-red-50 text-red-600 rounded-lg text-xs font-bold border border-red-100">
                    <i class="fa fa-circle-exclamation mr-1"></i> ${msg}
                </div>
            </c:if>
        </div>
    </main>

    <footer class="py-8 text-center">
        <p class="text-gray-400 text-[10px] font-bold uppercase tracking-[0.2em]">© 2026 PTIT JOBS System</p>
    </footer>

</body>
</html>