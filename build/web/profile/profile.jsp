
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Hồ sơ ứng viên</h2>

        <c:if test="${profile != null}">
            <img src="${profile.avatarUrl}" width="120">
        </c:if>

        <form method="post" action="profile" enctype="multipart/form-data">
            Họ tên: <input name="fullName" value="${profile.fullName}"><br><br>
            Tiêu đề: <input name="title" value="${profile.title}"><br><br>
            SĐT: <input name="phone" value="${profile.phone}"><br><br>
            Địa chỉ: <input name="location" value="${profile.location}"><br><br>

            Giới thiệu:<br>
            <textarea name="aboutMe">${profile.aboutMe}</textarea><br><br>

            Avatar: <input type="file" name="avatar"><br><br>
            CV: <input type="file" name="cv"><br><br>

            <button>Cập nhật</button>
         </form>

    </body>
</html>
