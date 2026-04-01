
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Hồ sơ ứng viên</h2>

        <img src="${profile.avatarUrl}" width="120"><br><br>

        <form method="post" action="profile">
           Họ tên: <input name="fullName" value="${profile.fullName}"><br><br>
           Tiêu đề: <input name="title" value="${profile.title}"><br><br>
           SĐT: <input name="phone" value="${profile.phone}"><br><br>
           Địa chỉ: <input name="location" value="${profile.location}"><br><br>

           Giới thiệu:<br>
           <textarea name="aboutMe">${profile.aboutMe}</textarea><br><br>

           <button>Cập nhật</button>
        </form>

    </body>
</html>
