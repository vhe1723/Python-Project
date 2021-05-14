<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.lang.Math" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<!-- DB와 연결 -->
<%@ include file="dbconn.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>


<body>
<%
   // *** 한글 깨짐 현상 해결 
   request.setCharacterEncoding("UTF-8");

   // 검색 변수 받아오기
   String standard = request.getParameter("standard");
   String keyword = request.getParameter("keyword");
   
   String loc1 = request.getParameter("loc1");
   String loc2 = request.getParameter("loc2");
   
   String ts = request.getParameter("term_start");
   int term_start = 0;
   if(!ts.equals("")) {
      ts = ts.substring(8,10) + ts.substring(0,2) + ts.substring(3,5);
      term_start = Integer.parseInt(ts);
   }
   String te = request.getParameter("term_end");
   int term_end = 0;
   if(!te.equals("")) {
      te = te.substring(8,10) + te.substring(0,2) + te.substring(3,5);
      term_end = Integer.parseInt(te);
   }
      
   
   // sql 쿼리문 전송을 위한 statment 객체 생성
   ResultSet rs = null;
   Statement stmt = conn.createStatement();
   
   // sql 쿼리문 - 검색 조건에 따른 where절
   String sql = "";
   sql = kwdSearch(sql, keyword, standard, loc1, loc2, term_start, term_end);
   
   // sql 쿼리문 - 검색 조건에 따라 tmp_hrd 테이블 생성
   String sql2 = "CREATE TABLE tmp_hrd AS SELECT * FROM hrd ";
   sql2 += sql + ";";
   
   // 쿼리문 실행
   stmt.executeUpdate("DROP TABLE tmp_hrd;");
   stmt.executeUpdate(sql2);
      
   // 화면 이동
   response.sendRedirect("marker-form.jsp");
   
%>

<%!
   // ***** 검색 관련 함수 *****
   
   // 훈련 기간
   String termSearch(String sql, int term_start, int term_end) {
      if(term_start != 0 && term_end != 0) {
         sql += "AND term_start >= " + term_start + " ";
         sql += "AND term_end <= " + term_end + " ";
      } else if(term_start != 0) {
         sql += "AND term_start >= " + term_start + " ";
      } else if(term_end != 0) {
         sql += "AND term_end <= " + term_end + " ";
      } 
      return sql;
   }

   // 훈련 기관 위치
   String adrSearch(String sql, String loc1, String loc2, int term_start, int term_end) {
      if(loc1.equals("0")) {
         sql = termSearch(sql, term_start, term_end);
      } else if(!loc1.equals("0") && !loc2.equals("시/군/구")) {
         sql += "AND adr LIKE '" + loc1 + "%' ";
         sql += "AND adr LIKE '%" + loc2 + "%' ";
         sql = termSearch(sql, term_start, term_end);
      } else if(!loc1.equals("0")) {
         sql += "AND adr LIKE '" + loc1 + "%' ";
         sql = termSearch(sql, term_start, term_end);
      }
      return sql;
   }

   // 훈련 과정 및 기관 키워드
   String kwdSearch(String sql, String keyword, String standard, String loc1, String loc2, int term_start, int term_end) {
      if(keyword.equals("")) {
         sql += "WHERE title IS NOT NULL ";
         sql = adrSearch(sql, loc1, loc2, term_start, term_end);
      } else if(standard.equals("undefined") || standard.equals("all")) {
         sql += "WHERE (title LIKE '%" + keyword + "%' ";
         sql += "OR place LIKE '%" + keyword + "%') ";
         sql = adrSearch(sql, loc1, loc2, term_start, term_end); 
      } else if(standard.equals("title")) {
         sql += "WHERE title LIKE '%" + keyword + "%' ";
         sql = adrSearch(sql, loc1, loc2, term_start, term_end);
      } else if(standard.equals("place")) {
         sql += "WHERE place LIKE '%" + keyword + "%' ";
         sql = adrSearch(sql, loc1, loc2, term_start, term_end);
      } 
      return sql;
   }

%>


</body>
</html>