<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${company.name} | PTIT JOBS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'ptit-red': '#E1191E',
                        'ptit-darkred': '#B11216',
                    }
                }
            }
        }
    </script>
    <style>
        .scrollbar-hide::-webkit-scrollbar { display: none; }
        .scrollbar-hide { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-gray-50 min-h-screen font-sans">

    <header class="bg-white shadow-sm sticky top-0 z-50 h-20 flex items-center">
        <div class="container mx-auto px-4 flex justify-between items-center">
            <div class="flex items-center gap-2">
                <a href="home" class="flex items-center gap-2">
                    <div class="w-10 h-10 bg-ptit-red rounded-full flex items-center justify-center text-white font-bold text-xl">P</div>
                    <div class="flex flex-col">
                        <span class="text-ptit-red font-bold text-xl leading-none">JOBS</span>
                        <span class="text-gray-600 text-xs font-medium tracking-wider">PTIT.EDU.VN</span>
                    </div>
                </a>
            </div>
            <nav class="hidden md:flex items-center space-x-8">
                <a class="font-medium text-gray-600 hover:text-ptit-red transition" href="home">Trang chủ</a>
                <a class="font-medium text-gray-600 hover:text-ptit-red transition" href="industries">Ngành nghề</a>
                <a class="font-medium text-gray-600 hover:text-ptit-red transition" href="news">Tin tức</a>
            </nav>
        </div>
    </header>

    <main class="flex-grow">
        <div class="relative h-[400px] w-full overflow-hidden">
            <img alt="Banner" class="w-full h-full object-cover" src="https://images.unsplash.com/photo-1497215728101-856f4ea42174?auto=format&fit=crop&q=80&w=1950&q=80">
            <div class="absolute inset-0 bg-gradient-to-t from-gray-950 via-gray-900/60 to-transparent"></div>
        </div>

        <div class="container mx-auto px-4 -mt-36 relative z-10">
            <div class="bg-white/90 backdrop-blur-3xl rounded-[2.5rem] shadow-xl p-8 border border-white/50 flex flex-col md:flex-row items-center md:items-end gap-8 mb-10">
                <div class="w-44 h-44 md:w-52 md:h-52 rounded-[2rem] bg-white p-4 shadow-2xl flex-shrink-0 -mt-24 border-8 border-white">
                    <img alt="${company.name}" class="w-full h-full object-contain rounded-2xl" 
                         src="${pageContext.request.contextPath}/${company.logoUrl}">
                </div>
                
                <div class="flex-1 text-center md:text-left pb-4">
                    <div class="flex flex-col md:flex-row md:items-center gap-4 mb-2">
                        <h1 class="text-4xl font-black text-gray-900 tracking-tight">${company.name}</h1>
                        <span class="bg-blue-100 text-blue-600 px-4 py-1.5 rounded-full text-[10px] font-black uppercase tracking-wider flex items-center gap-2 w-fit mx-auto md:mx-0">
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M21.801 10A10 10 0 1 1 17 3.335"/><path d="m9 11 3 3L22 4"/></svg> Xác thực
                        </span>
                    </div>
                    <p class="text-xl text-gray-500 font-medium italic mb-6">"Tiên phong công nghệ - Dẫn lối tương lai"</p>
                    
                    <div class="flex flex-wrap justify-center md:justify-start gap-4 text-xs font-bold">
                        <div class="flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-xl text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-ptit-red"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                            <span>500-1000 nhân viên</span>
                        </div>
                        <div class="flex items-center gap-2 px-4 py-2 bg-gray-100 rounded-xl text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-ptit-red"><circle cx="12" cy="12" r="10"/><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20"/><path d="M2 12h20"/></svg>
                            <span>${company.location}</span>
                        </div>
                    </div>
                </div>

                <div class="pb-4">
                    <button class="bg-ptit-red hover:bg-ptit-darkred text-white font-black py-4 px-10 rounded-2xl transition-all shadow-lg active:scale-95">
                        Theo dõi
                    </button>
                </div>
            </div>

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">
                <div class="lg:col-span-2 space-y-10">
                    <div class="bg-white rounded-[2.5rem] shadow-sm border border-gray-100 p-10">
                        <h2 class="text-2xl font-black text-gray-900 mb-6 flex items-center gap-3">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-ptit-red"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
                            Giới thiệu công ty
                        </h2>
                        <div class="text-gray-600 leading-loose text-lg space-y-4">
                            ${company.description}
                        </div>
                    </div>

                    <div class="bg-white rounded-[2.5rem] shadow-sm border border-gray-100 p-10">
                        <h2 class="text-2xl font-black text-gray-900 mb-8">Phúc lợi dành cho bạn</h2>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="flex items-start gap-4 p-5 rounded-2xl bg-gray-50 border border-transparent hover:border-ptit-red/20 transition-all">
                                <div class="w-12 h-12 bg-white rounded-xl shadow flex items-center justify-center text-ptit-red">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" x2="12" y1="2" y2="22"></line><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg>
                                </div>
                                <div>
                                    <h4 class="font-bold text-gray-900">Lương thưởng</h4>
                                    <p class="text-gray-500 text-sm">Tháng lương 13++ và thưởng dự án</p>
                                </div>
                            </div>
                            </div>
                    </div>
                </div>

                <div class="space-y-10">
                    <div class="bg-white rounded-[2.5rem] shadow-sm border border-gray-100 p-8">
                        <h3 class="text-xl font-black text-gray-900 mb-8">Thông tin liên hệ</h3>
                        <div class="space-y-6">
                            <div>
                                <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-2">Địa chỉ</span>
                                <div class="flex items-start gap-3">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="text-ptit-red mt-1"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                    <p class="text-gray-900 font-bold text-sm">${company.location}</p>
                                </div>
                            </div>
                            <div>
                                <span class="text-gray-400 text-[10px] font-black uppercase tracking-widest block mb-2">Website</span>
                                <a href="#" class="text-blue-600 font-bold text-sm hover:underline italic">https://abc-tech.com</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-gray-900 text-white mt-20 py-12">
        <div class="container mx-auto px-4 text-center">
            <p class="text-gray-500 text-sm">© 2026 Học viện Công nghệ Bưu chính Viễn thông. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>