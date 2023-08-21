package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

import kr.spring.interceptor.AdminCheckInterceptor;
import kr.spring.interceptor.AutoLoginCheckInterceptor;
import kr.spring.interceptor.LoginCheckInterceptor;

//자바 코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
	
	/*======================
	  		 인터셉터
	 ======================*/
	
	private LoginCheckInterceptor loginCheck;
	private AdminCheckInterceptor adminCheck;
	private AutoLoginCheckInterceptor autoLoginCheck;
	
	@Bean
	public LoginCheckInterceptor interceptor2() {
		loginCheck = new LoginCheckInterceptor();
		return loginCheck;
	}
	
	@Bean
	public AdminCheckInterceptor interceptor3() {
		adminCheck = new AdminCheckInterceptor();
		return adminCheck;
	}
	@Bean
	public AutoLoginCheckInterceptor interceptor() {
	   autoLoginCheck = new AutoLoginCheckInterceptor();
	   return autoLoginCheck;
	}
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//AutoLoginCheckInterceptor 설정
		   registry.addInterceptor(autoLoginCheck)
		         .addPathPatterns("/**")
		         .excludePathPatterns("/member/login.do")
		         .excludePathPatterns("/member/logout.do");
		         //"/**"로 전체 호출하는데 exclude로 호출안할거 명시
		//LoginCheckInterceptor 설정
		   registry.addInterceptor(loginCheck)
		         .addPathPatterns("/member/myPage.do")
		         .addPathPatterns("/member/update.do")
		         .addPathPatterns("/member/changePassword.do")
		         .addPathPatterns("/member/delete.do")
		         .addPathPatterns("/board/memberReservationList.do")
		         .addPathPatterns("/cart/list.do")
		         .addPathPatterns("/order/order.do")
		         .addPathPatterns("/order/orderFail.do")
		         .addPathPatterns("/order/searchMember.do");
		//AdminCheckInterceptor 설정
		registry.addInterceptor(adminCheck)
				.addPathPatterns("/snack/admin_list.do")
				.addPathPatterns("/snack/admin_insert.do")
				.addPathPatterns("/snack/admin_update.do")
				.addPathPatterns("/snack/admin_delete.do")
				.addPathPatterns("/snack/admin_deleteChBox.do")
				.addPathPatterns("/point/admin_list.do")
				.addPathPatterns("/order/admin_list.do")
				.addPathPatterns("/order/admin_detail.do");
	}
	
	
	
	/*======================
			 타일스
	======================*/
	
	@Bean
	public TilesConfigurer tilesConfigurer() {
		final TilesConfigurer configurer = new TilesConfigurer();
		//해당 경로에 xml 설정 파일을 넣음
		configurer.setDefinitions(new String[] {
				"/WEB-INF/tiles-def/main.xml",
				"/WEB-INF/tiles-def/JBH.xml",
				"/WEB-INF/tiles-def/KHB.xml",
				"/WEB-INF/tiles-def/KHJ.xml",
				"/WEB-INF/tiles-def/LDH.xml",
				"/WEB-INF/tiles-def/OJE.xml",
				"/WEB-INF/tiles-def/OMJ.xml",
				"/WEB-INF/tiles-def/PHI.xml"
		});
		return configurer;
	}
	@Bean
	public TilesViewResolver tilesViewResolver() {
		final TilesViewResolver tilesViewResolver = 
				                    new TilesViewResolver();
		tilesViewResolver.setViewClass(TilesView.class);
		return tilesViewResolver;
	}
}
