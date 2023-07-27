package kr.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

//자바 코드 기반 설정 클래스
@Configuration
public class AppConfig implements WebMvcConfigurer{
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



