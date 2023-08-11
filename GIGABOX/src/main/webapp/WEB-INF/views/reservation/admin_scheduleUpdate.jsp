<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/reservation.js"></script>
<!-- 상영시간표 수정 시작 -->
<div class="page-main">
    <h2>상영시간표 수정</h2>
    <form action="admin_scheduleUpdate.do" id="admin_scheduleUpdate" method="post">
    	<input type="hidden" name="sch_num" value="${scheduleVO.sch_num}">
        <ul>
            <li>
                <label for="m_title">영화 제목</label>
                <select name="movie_num" id="movie_num">
                    <option value="0" selected>영화를 선택하세요</option>
                    <c:forEach items="${MovieList}" var="movie">
                        <option value="${movie.movie_num}" <c:if test="${scheduleVO.movie_num == movie.movie_num}">selected</c:if>>${movie.m_title}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <label for="th_name">극장</label>
                <select name="th_num" id="th_num">
                    <option value="0" selected>극장을 선택하세요</option>
                    <c:forEach items="${TheaterList}" var="theater">
                        <option value="${theater.th_num}" <c:if test="${scheduleVO.th_num == theater.th_num}">selected</c:if>>${theater.th_name}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <label for="hall_name">상영관</label>
                <select name="hall_num" id="hall_num">
                    <option value="0" selected>상영관을 선택하세요</option>
                    <c:forEach items="${HallList}" var="hall">
                        <option value="${hall.hall_num}" <c:if test="${scheduleVO.hall_num == hall.hall_num}">selected</c:if>>${hall.hall_name}</option>
                    </c:forEach>
                </select>
            </li>
            <li>
                <label for="sch_date">상영날짜</label>
                <input type="date" name="sch_date" id="sch_date" value="${scheduleVO.sch_date}">
            </li>
            <li>
                <label for="sch_start">상영시작시간</label>
                <input type="time" name="sch_start" id="sch_start" value="${scheduleVO.sch_start}"/>
            </li>
            <li>
                <label for="sch_end">상영종료시간</label>
                <input type="time" name="sch_end" id="sch_end" value="${scheduleVO.sch_end}"/>
            </li>
        </ul>
        <div class="align-center">
            <input type="submit" value="수정" class="button">
            <input type="button" value="목록" onclick="location.href='admin_schedule.do'">
        </div>
    </form>
</div>
