<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa hồ sơ công ty | PTIT JOBS</title>

```
<script src="https://cdn.tailwindcss.com"></script>

<style>
    .bg-ptit-red { background-color: #be1e2d; }
    .text-ptit-red { color: #be1e2d; }
</style>
```

</head>
<body class="bg-gray-50 font-sans">

```
<!-- HEADER -->
<header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="container mx-auto px-4 h-20 flex justify-between items-center">
        <a class="flex items-center gap-2" href="${pageContext.request.contextPath}/job-manage">
            <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
            <div class="flex flex-col">
                <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                <span class="text-gray-600 text-xs font-medium tracking-wider">RECRUITER</span>
            </div>
        </a>
        <span class="text-sm text-gray-500">Xin chào, ${sessionScope.LOGIN_USER.email}</span>
    </div>
</header>

<!-- MAIN -->
<main class="container mx-auto px-4 py-12 max-w-4xl">

    <!-- breadcrumb -->
    <div class="mb-6 text-sm text-gray-500">
        <a href="${pageContext.request.contextPath}/job-manage" class="hover:text-ptit-red">Dashboard</a>
        <span> / </span>
        <span class="font-bold text-gray-800">Chỉnh sửa công ty</span>
    </div>

    <div class="bg-white rounded-3xl shadow-xl border border-gray-100 overflow-hidden">
        
        <!-- header đỏ -->
        <div class="bg-ptit-red p-6 text-white">
            <h1 class="text-2xl font-bold">Cập nhật thông tin công ty</h1>
            <p class="text-sm opacity-80">Thông tin hiển thị công khai cho ứng viên</p>
        </div>

        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/recruiter/edit-company"
              method="post"
              enctype="multipart/form-data"
              class="p-8 space-y-6">

            <!-- tên + location -->
            <div class="grid md:grid-cols-2 gap-6">
                <div>
                    <label class="text-sm font-semibold text-gray-600">Tên công ty</label>
                    <input type="text" name="name" value="${company.name}" required
                           class="w-full mt-2 px-4 py-3 border rounded-xl focus:ring-2 focus:ring-red-200 focus:border-ptit-red">
                </div>

                <div>
                    <label class="text-sm font-semibold text-gray-600">Địa điểm</label>
                    <input type="text" name="location" value="${company.location}" required
                           class="w-full mt-2 px-4 py-3 border rounded-xl focus:ring-2 focus:ring-red-200 focus:border-ptit-red">
                </div>
            </div>

            <!-- LOGO -->
            <div>
                <label class="text-sm font-semibold text-gray-600">Logo công ty</label>

                <div class="flex items-center gap-4 mt-3">
                    <!-- preview -->
                    <div class="w-20 h-20 border rounded-xl overflow-hidden bg-gray-100 flex items-center justify-center">
                        <img id="previewImg"
                             src="${pageContext.request.contextPath}/${company.logoUrl}"
                             class="w-full h-full object-contain"
                             onerror="this.src='https://placehold.co/100x100?text=Logo'">
                    </div>

                    <!-- upload -->
                    <input type="file" name="logoFile" accept="image/*"
                           onchange="preview(event)"
                           class="text-sm">
                </div>

                <p class="text-xs text-gray-400 mt-2">
                    * Không chọn ảnh mới → giữ nguyên logo cũ
                </p>
            </div>

            <!-- DESCRIPTION -->
            <div>
                <label class="text-sm font-semibold text-gray-600">Mô tả công ty</label>
                <textarea name="description" rows="6" required
                          class="w-full mt-2 px-4 py-3 border rounded-xl focus:ring-2 focus:ring-red-200 focus:border-ptit-red">${company.description}</textarea>
            </div>

            <!-- ACTION -->
            <div class="flex justify-end gap-4 pt-4 border-t">
                <a href="${pageContext.request.contextPath}/recruiter/my-company"
                   class="px-6 py-2 text-gray-500 hover:bg-gray-100 rounded-xl">
                    Hủy
                </a>

                <button type="submit"
                        class="px-6 py-2 bg-ptit-red text-white rounded-xl hover:bg-red-700">
                    Lưu thay đổi
                </button>
            </div>

        </form>
    </div>
</main>

<script>
    function preview(event) {
        const img = document.getElementById("previewImg");
        img.src = URL.createObjectURL(event.target.files[0]);
    }
</script>
```

</body>
</html>
