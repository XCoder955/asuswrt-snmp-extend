<!-- filepath: /root/project/asuswrt-snmp-extend/index.asp -->
<%@ Language="VBScript" %>
<%
' 定义 README 文件路径
Dim fso, file, filePath, readmeContent
filePath = Server.MapPath("README.md")

' 读取 README 文件内容
Set fso = Server.CreateObject("Scripting.FileSystemObject")
If fso.FileExists(filePath) Then
    Set file = fso.OpenTextFile(filePath, 1, False)
    readmeContent = file.ReadAll()
    file.Close()
    Set file = Nothing
Else
    readmeContent = "README.md 文件未找到。"
End If
Set fso = Nothing
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>asuswrt-snmp-extend</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }
        header {
            background: #0078d7;
            color: #fff;
            padding: 1rem 0;
            text-align: center;
        }
        main {
            padding: 2rem;
        }
        pre {
            background: #f4f4f4;
            padding: 1rem;
            border: 1px solid #ddd;
            overflow-x: auto;
        }
        footer {
            text-align: center;
            padding: 1rem 0;
            background: #333;
            color: #fff;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
    </style>
</head>
<body>
    <header>
        <h1>asuswrt-snmp-extend</h1>
    </header>
    <main>
        <h2>README 文件内容</h2>
        <pre><%= Server.HTMLEncode(readmeContent) %></pre>
    </main>
    <footer>
        <p>© 2023 asuswrt-snmp-extend</p>
    </footer>
</body>
</html>