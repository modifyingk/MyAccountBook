<%@page import="com.modifyk.accountbook.member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberVO info = (MemberVO)request.getAttribute("info");
	String username = info.getUsername();
	String gender = info.getGender();
	String birth = info.getBirth();
%>
<%= username %>/<%= gender %>/<%= birth %>