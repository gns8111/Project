<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<html>
<head>

<link rel="stylesheet" href="css/updateformcss.css">
	<link rel="stylesheet" href="css/rangecss.css">
	<link rel="stylesheet" href="css/blockcss.css">
	<link rel="stylesheet" href="css/maintabcss.css">
	<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	       <script>
	        $(document).ready(function() {
            $("#keyword").keyup(function() {
                var k = $(this).val();
                $("#user-table > tbody > tr").hide();
                var temp = $("#user-table > tbody > tr > td:contains('" + k + "')");
                $(temp).parent().show();
            })
        })
        </script>
        
        <style>
         #container {width: 960px; margin: 0 auto;}
        #container #input-form {text-align: center;}
        #user-table {margin: 0 auto; text-align: center;}
        #input-form {margin-top: 10px; margin-bottom: 10px;}

        #user-table {border-collapse: collapse;}
        #user-table > thead > tr { background-color: #333; color:#fff; }
        #user-table > thead > tr > th { padding: 8px; width: 150px; }
        #user-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px; }
        
        </style>
</head>
<body>
 
 <div id="container" >
       <div id="input-form" >
            <input type="text" id="keyword" />
        </div>
        <table id="user-table" >
            <thead>
                <tr>
                    <th>��ȣ</th>
                    <th>�̸�</th>
                    <th>�������</th>
                    <th>�а�</th>
                    <th>�й�</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td>1</td>
                    <td>�ڰ��</td>
                    <td>1991.09.07</td>
                    <td>�濵�����а�</td>
                    <td>2000290031</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>�赿��</td>
                    <td>1991.07.07</td>
                    <td>�濵�а�</td>
                    <td>2000290032</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>�ϼ���</td>
                    <td>1991.05.15</td>
                    <td>��ȸ�а�</td>
                    <td>2000290033</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>��â��</td>
                    <td>1991.08.07</td>
                    <td>�����а�</td>
                    <td>2000290038</td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>�۽���</td>
                    <td>1989.04.07</td>
                    <td>�����а�</td>
                    <td>2000290039</td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>������</td>
                    <td>1988.02.07</td>
                    <td>�Ƿ��а�</td>
                    <td>2000290040</td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>������</td>
                    <td>1988.07.25</td>
                    <td>��ǰ�а�</td>
                    <td>2000290042</td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>����</td>
                    <td>1981.02.07</td>
                    <td>������а�</td>
                    <td>2002290031</td>
                </tr>
                <tr>
                    <td>9</td>
                    <td>�̵���</td>
                    <td>1993.09.07</td>
                    <td>�����а�</td>
                    <td>2000290055</td>
                </tr>
                <tr>
                    <td>10</td>
                    <td>������</td>
                    <td>1995.09.07</td>
                    <td>�濵�����а�</td>
                    <td>2000290056</td>
                </tr>
                <tr>
                    <td>11</td>
                    <td>������</td>
                    <td>1993.09.07</td>
                    <td>�����а�</td>
                    <td>2000290060</td>
                </tr>
            </tbody>
        </table>
    </div>

</body>




</html>