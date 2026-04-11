<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nộp đơn ứng tuyển - MyJob</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f0f2f5; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        form { 
            background: white; 
            padding: 40px; 
            border-radius: 12px; 
            box-shadow: 0 8px 24px rgba(0,0,0,0.1); 
            width: 100%; 
            max-width: 400px; 
        }
        h3 { color: #1a73e8; text-align: center; margin-top: 0; margin-bottom: 25px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; color: #444; }
        input[type="text"] { 
            width: 100%; padding: 12px; border: 1px solid #ddd; 
            border-radius: 6px; box-sizing: border-box; font-size: 14px;
        }
        input[type="text"]:focus { border-color: #1a73e8; outline: none; box-shadow: 0 0 0 2px rgba(26,115,232,0.2); }
        button { 
            width: 100%; padding: 14px; background-color: #1a73e8; 
            color: white; border: none; border-radius: 6px; 
            cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.3s;
        }
        button:hover { background-color: #1557b0; }
    </style>
</head>
<body>

<form action="apply" method="post">
    <h3>Nộp đơn ứng tuyển</h3>
    
    <input type="hidden" name="jobId" value="${param.jobId}">
    
    <div class="form-group">
        <label>Họ và tên:</label>
        <input type="text" name="fullname" placeholder="Nhập tên của bạn..." required>
    </div>
    
    <div class="form-group">
        <label>CV (Link hoặc file):</label>
        <input type="text" name="cvUrl" placeholder="Dán đường dẫn CV tại đây..." required>
    </div>
    
    <button type="submit">Xác nhận nộp đơn</button>
</form>

</body>
</html>