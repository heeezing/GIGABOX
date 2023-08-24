<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/megabox.min.css" media="all" />
<script src="${pageContext.request.contextPath}/js/megabox.api.min.js"></script>
	<!-- container -->
	<div class="container has-lnb">
		<div class="page-util">
			<div class="inner-wrap">
				<div class="location">
					<span>Home</span>
					<a href="csList.do" title="고객센터 페이지로 이동">고객센터</a>
					<a href="csPersonalWrite.do" title="1:1 문의 페이지로 이동">1:1 문의</a>
				</div>

			</div>
		</div>

		<div class="inner-wrap">
			<div class="lnb-area addchat">
				<nav id="lnb" class="ty2">
					<p class="tit">
						<a href="csMain.do" title="고객센터">고객센터</a>
					</p>
					<ul>
						<li><a href="csMain.do" title="고객센터 홈">고객센터
								홈</a></li>
						<li><a href="csQnaList.do" title="자주 묻는 질문">자주 묻는 질문</a></li>
						<li><a href="csNotiList.do" title="공지사항">공지사항</a></li>
						<li><a href="csPersonalWrite.do" title="1:1문의">1:1문의</a></li>
						<li><a href="#" title="이용약관">이용약관</a></li>
					</ul>
					<div class="left-customer-info">
						<p class="tit">
							메가박스 고객센터 <span>Dream center</span>
						</p>
						<p class="time">
							<i class="iconset ico-clock"></i> 10:00~19:00
						</p>
					</div>
				</nav>
			</div>

			<div id="contents">
				<h2 class="tit">1:1 문의</h2>
				<div class="mypage-infomation mb30">
					<ul class="dot-list">
						<li><span style="font-weight: bold;">고객님의 문의에 답변하는 직원은 <span style="color: #EB323A;">고객 여러분의 가족 중 한 사람일 수 있습니다.</span></span><br>
							고객의 언어폭력(비하, 욕설, 협박, 성희롱 등)으로부터 직원을 보호하기 위해<br>
							관련 법에 따라 수사기관에 필요한 조치를 요구할 수 있으며, 형법에 의해 처벌 대상이 될 수 있습니다.<br>
						</li>
						<br>
						<li>문의하시기 전 FAQ를 확인하시면 궁금증을 더욱 빠르게 해결하실 수 있습니다. </li>
					</ul>
					
				</div>
				<p class="reset mt30 a-r font-orange">* 필수</p>

				<form action="csPersonalWrite.do" method="post" enctype="multipart/form-data" style="width: 100%;border: none;">
					<div class="table-wrap mt10">
						<table class="board-form va-m">
							<colgroup>
								<col style="width:150px;">
								<col>
								<col style="width:150px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">문의선택<em class="font-orange">*</em></th>
									<td colspan="3">
										<input id="cs_center" class="cs_checkbox" type="checkbox" name="th_num"  value="101"checked>
										<label>고객센터 문의</label>
										<input id="cs_theater" class="cs_checkbox" type="checkbox">
										<label>극장 문의</label>
										<script type="text/javascript">
										$(document).ready(function() {
											 $('input[type="checkbox"][class="cs_checkbox"]').click(function(){
											  if($(this).prop('checked')){
											     $('input[type="checkbox"][class="cs_checkbox"]').prop('checked',false);
											     $(this).prop('checked',true);
											    }
											   });
											 });
										</script>
										<select id="theater" name="th_num" class="small ml10"  disabled="disabled">
											<option value="101">극장선택</option>
											<c:forEach var="th" items="${theater}">
												<c:if test="${th.th_num != 101}">
												<option value="${th.th_num}">${th.th_name}</option>
												</c:if>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="ask-type">문의유형</label> <em class="font-orange">*</em></th>
									<td colspan="3">
										<select id="category1" name="category_num" class="small">
											<option value="">문의유형 선택</option><!-- 고객센터용 문의유형 -->
											<c:forEach var="ca" items="${category}">
												<c:if test="${ca.category_name ne '-' && ca.category_num <= 10}">
													<option value="${ca.category_num}">${ca.category_name}</option>
												</c:if>
											</c:forEach>
										</select>
										<select id="category2" name="category_num" class="small" disabled="disabled">
											<option value="">문의유형 선택</option><!-- 극장용 문의유형 -->
											<c:forEach var="ca" items="${category}">
												<c:if test="${ca.category_name ne '-' &&  ca.category_num > 10}">
													<option value="${ca.category_num}">${ca.category_name}</option>
												</c:if>
											</c:forEach>
										</select>				
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="name">이름</label> <em class="font-orange">*</em></th>
									<td>
										<input type="text" id="name" name="name" class="input-text w150px" value="${user.name}" maxlength="30" />
									</td>
									<th scope="row"><label for="email">이메일</label> <em class="font-orange">*</em></th>
									<td>
										<input type="text" name="email" id="qnaRpstEmail" class="input-text" value="${user.email}"  maxlength="50" />
									</td>
								</tr>			
								<tr>
									<th scope="row"><label for="title">제목</label> <em class="font-orange">*</em></th>
									<td colspan="3"><input type="text" name="title" id="title" class="input-text" maxlength="100" /></td>
								</tr>
								<tr>
									<th scope="row"><label for="textarea">내용</label> <em class="font-orange">*</em></th>
									<td colspan="3">
										<div class="textarea">
											<div id="textarea-notice" style="color: #999999; margin-left: 10px;">
												<ul>- 문의내용에 개인정보(이름,연락처,카드번호 등)가 포함되지 않도록 유의하시기 바랍니다.</ul>
												<ul> - 회원로그인 후 문의작성시 나의 문의내역을 통해 답변을 확인하실 수 있습니다.</ul>
											</div>
											<textarea id="textarea" name="content" rows="5" cols="30" title="내용입력" class="input-textarea"></textarea>
											<div class="util">
												<p class="count">
													<span id="textareaCnt">0</span> / 2000
												</p>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">사진첨부</th>
									<td colspan="3">
										<div class="upload-image-box">
											<p>* JPEG, PNG 형식의 5M 이하의 파일만 첨부 가능합니다. (최대 5개)</p>
											<div class="info-txt">
												<ul id="addFileHere">
													<li>
														<input type="file" name="files" value="파일선택" id="fileBtn">
														<input type="button" id="addFile"value="추가하기">
													</li>
												</ul>
												
												<script type="text/javascript">
												$(function(){
													let count=1;
													$('#addFile').click(function(){
															if(count < 5){
																$('#addFileHere').append('<li><input type="file" name="files" value="파일선택" id="fileBtn"></li>');
																count += 1;
															}else{
																alert('5개 이상 첨부할 수 없습니다.');
															}
													});
												});
												</script>
											</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="btn-group pt40">
						<button type="submit" class="button purple large">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!--// container --> 

<script type="text/javascript">
	$(function(){
		$('#cs_theater').click(function(){
			$('#theater').attr('disabled',false);
			$('#category1').attr('disabled',true);
			$('#category2').attr('disabled',false);
		});
		$('#cs_center').click(function(){
			$('#theater').attr('disabled',true);
			$('#category1').attr('disabled',false);
			$('#category2').attr('disabled',true);
		});
		
		
		$('#sendNum_btn').click(function(){
		});
	});

</script>
