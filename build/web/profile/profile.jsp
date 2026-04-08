<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ</title>
</head>
<body>

<h2>Hồ sơ ứng viên</h2>

<!-- AVATAR -->
<c:if test="${profile != null && profile.avatarUrl != null}">
    <img src="${pageContext.request.contextPath}/${profile.avatarUrl}" width="120"><br><br>
</c:if>

<!-- CV -->
<c:if test="${profile != null && profile.cvUrl != null}">
    <a href="${pageContext.request.contextPath}/${profile.cvUrl}" target="_blank">
        📄 Xem CV
    </a>
    <br><br>
</c:if>

<form method="post" action="profile" enctype="multipart/form-data" accept-charset="UTF-8">

    Họ tên:
    <input name="fullName" value="${profile.fullName}"><br><br>

    Tiêu đề:
    <input name="title" value="${profile.title}"><br><br>

    SĐT:
    <input name="phone" value="${profile.phone}"><br><br>

    Địa chỉ:
    <input name="location" value="${profile.location}"><br><br>

    Giới thiệu:<br>
    <textarea name="aboutMe">${profile.aboutMe}</textarea><br><br>

    Avatar:
    <input type="file" name="avatar"><br><br>

    CV:
    <input type="file" name="cv"><br><br>

    <button type="submit">Cập nhật</button>

</form>

</body>
</html>