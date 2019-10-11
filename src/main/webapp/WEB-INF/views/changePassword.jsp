<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}

input[type=text], input[type=number], input[type=email], input[type=password],
	select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	resize: vertical;
}

label {
	padding: 12px 12px 12px 0;
	display: inline-block;
}

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	float: right;
}
</style>
<head>
<meta charset="UTF-8">
<title>Change your password</title>
</head>
<body>
	<div id="login-box">
		<form method="post" action="/departmental/changePassword">
			<table>
				<tr>
					<td><label> Username </label></td>
					<td><input name="username" type="text"
						value="${pageContext.request.userPrincipal.name }"
						readonly="readonly" /></td>
				</tr>

				<tr>
					<td><label> Password </label></td>
					<td><input name="oldPass" type="password" /></td>
				</tr>

				<tr>
					<td><label> New Password </label></td>
					<td><input name="newPass" type="password" /></td>
				</tr>

				<tr>
					<td><label> Confirm New Password </label></td>
					<td><input name="confirmNewPass" type="password" /></td>
				</tr>

				<tr>
					<td colspan='2'><input type="submit" value="Update" /></td>
				</tr>

			</table>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
	</div>

</body>
</html>