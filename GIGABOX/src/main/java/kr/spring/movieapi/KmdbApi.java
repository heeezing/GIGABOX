package kr.spring.movieapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import kr.spring.movie.vo.MovieVO;

public class KmdbApi {

    public static void main(String[] args) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2"); /*URL*/
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=7C19X7UCO798503H925F"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("listCount","UTF-8") + "=" + URLEncoder.encode("15", "UTF-8")); /*출력 갯수*/
        urlBuilder.append("&" + URLEncoder.encode("detail","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*detail 출력여부*/
        urlBuilder.append("&" + URLEncoder.encode("sort","UTF-8") + "=" + URLEncoder.encode("prodYear,1", "UTF-8")); /*제작년도 정렬*/
        urlBuilder.append("&" + URLEncoder.encode("releaseDts","UTF-8") + "=" + URLEncoder.encode("20230701", "UTF-8")); /*개봉일 시작*/
        urlBuilder.append("&" + URLEncoder.encode("releaseDte","UTF-8") + "=" + URLEncoder.encode( "20230805", "UTF-8")); /*개봉일 끝(SYSDATE로 하고싶은데)*/
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("극영화", "UTF-8")); /*개봉일 끝(SYSDATE로 하고싶은데)*/
        URL url = new URL(urlBuilder.toString());

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;

        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
        System.out.println("=====================");

        List<MovieVO> movielist = new ArrayList<MovieVO>();
        JSONObject jObject = new JSONObject(sb.toString());
        JSONArray array = jObject.getJSONArray("Data");
        for (int i = 0; i < array.length(); i++) {
            JSONObject jo = (JSONObject) array.get(i);
            JSONArray jArray = jo.getJSONArray("Result");
            String title ="";
            String titleEng = "";
            for (int j = 0; j < jArray.length(); j++) {
            	MovieVO vo = new MovieVO(); 
                JSONObject ko = (JSONObject) jArray.get(j);
                title = ko.getString("title");
                titleEng = ko.getString("titleEng");
                vo.setM_title(title);
                vo.setM_titleEng(titleEng);

				JSONObject kObject = ko.getJSONObject("directors");
				JSONArray larray = kObject.getJSONArray("director");
				String directorNm = "";
				for(int x=0;x<larray.length();x++) {
					if(x>0)directorNm += ", ";
					JSONObject mo = (JSONObject)larray.get(x);
					directorNm = mo.getString("directorNm");

					System.out.println("감독 : " + directorNm);
				}
				vo.setM_director(directorNm);
				
				String nation = ko.getString("nation");
				vo.setM_nation(nation);
				String company = ko.getString("company");
				vo.setM_company(company);
				
				JSONObject aObject = ko.getJSONObject("plots");
				JSONArray barray = aObject.getJSONArray("plot");
				String plotText = "";
				for(int c=0;c<barray.length();c++) {
					if(c>0) plotText +=", ";
					JSONObject eo = (JSONObject)barray.get(c);
					plotText = eo.getString("plotText");
				
					System.out.println("줄거리 : " + plotText);
				}
				vo.setM_plot(plotText);
		
				String runtime = ko.getString("runtime");
				vo.setM_runtime(runtime);
				String rating = ko.getString("rating");
				vo.setM_rating(rating);
				String genre = ko.getString("genre");
				vo.setM_genre(genre);
				
				JSONObject fObject = ko.getJSONObject("ratings");
				JSONArray garray = fObject.getJSONArray("rating");
				String releaseDate = "";
				for(int h=0;h<garray.length();h++) {
					if(h>0) releaseDate += ", ";
					JSONObject io = (JSONObject)garray.get(h);
					releaseDate = io.getString("releaseDate");
					
					System.out.println("개봉일 : " + releaseDate);
				}				
				vo.setM_opendate2(releaseDate);

				String posters = ko.getString("posters");
				vo.setM_poster2(posters);
				String stlls = ko.getString("stlls");
				vo.setM_stllimg2(stlls);
				
				
				JSONObject pObject = ko.getJSONObject("vods");
				JSONArray qarray = pObject.getJSONArray("vod");
				String vodUrl = "";
				for(int r=0;r<qarray.length();r++) {
					if(r>0) vodUrl += ", ";
					JSONObject so = (JSONObject)qarray.get(r);
					vodUrl += so.getString("vodUrl");
					
					System.out.println("예고편 : " + vodUrl);
				}	
				vo.setM_vod(vodUrl);
				
				JSONObject zObject = ko.getJSONObject("actors");
				JSONArray xarray = zObject.getJSONArray("actor");
				String actorNm = "";
				for(int y=0;y<qarray.length();y++) {
					if(y>0) actorNm +=", ";
					JSONObject wo = (JSONObject)xarray.get(y);
					actorNm += wo.getString("actorNm");
					
					System.out.println("배우명 : " + actorNm);
					
				}	
				vo.setM_actor(actorNm);
				
				System.out.println("제목 : " + title);
				System.out.println("영문제목 : " + titleEng);
				System.out.println("제작국가 : " + nation);
				System.out.println("제작사 : " + company);
				System.out.println("상영시간 : " + runtime);
				System.out.println("관람등급 : " + rating);
				System.out.println("장르 : " + genre);
				System.out.println("포스터 : " + posters);
				System.out.println("스틸컷 : " + stlls);
				System.out.println("--------------------");
              
				
				movielist.add(vo);
            }
        }

        // 예시로 첫 번째 영화의 제목을 출력해보는 부분
       System.out.println("==============================================");
       for(MovieVO vo : movielist) {
    	   System.out.println("배우명 : " + vo.getM_opendate());
    	   System.out.println(vo.getM_title());
       }
       
       MovieVO vo = new MovieVO(); 
       System.out.println("AAAAAAA = "+movielist.get(1));
       System.out.println(vo.getM_title());


    }
}






