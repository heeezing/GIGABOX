package kr.spring.movieapi;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import kr.spring.movie.vo.MovieVO;

public class KmdbApi {

    public static void main(String[] args) throws IOException {
    	
    	 LocalDate currentDate = LocalDate.now();
    	 LocalDate oneMonthAgo = currentDate.minusMonths(1);
         DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
         //오늘날짜
         String today = currentDate.format(formatter); 
         //개봉일 시작 ( 오늘날짜 한달전 )
         String OneMonthAgo = oneMonthAgo.format(formatter);
         //movieSeq담기
         List<String> movieseqlist = new ArrayList<>();
         
    	
        StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2"); /*URL*/
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=7C19X7UCO798503H925F"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("listCount","UTF-8") + "=" + URLEncoder.encode("3", "UTF-8")); /*출력 갯수*/
        urlBuilder.append("&" + URLEncoder.encode("detail","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*detail 출력여부*/
        urlBuilder.append("&" + URLEncoder.encode("sort","UTF-8") + "=" + URLEncoder.encode("prodYear,1", "UTF-8")); /*제작년도 정렬*/
        urlBuilder.append("&" + URLEncoder.encode("releaseDts","UTF-8") + "=" + URLEncoder.encode(OneMonthAgo, "UTF-8")); /*개봉일 시작*/
        urlBuilder.append("&" + URLEncoder.encode("releaseDte","UTF-8") + "=" + URLEncoder.encode( today, "UTF-8")); /*개봉일 끝(SYSDATE로 하고싶은데)*/
        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("극영화", "UTF-8"));
        URL url = new URL(urlBuilder.toString());
        System.out.println(url);

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
            String movieSeq = "";
            String title ="";
            String titleEng = "";
            for (int j = 0; j < jArray.length(); j++) {
            	MovieVO vo = new MovieVO(); 
                JSONObject ko = (JSONObject) jArray.get(j);
                movieSeq = ko.getString("movieSeq");
                title = ko.getString("title");
                titleEng = ko.getString("titleEng");
                vo.setMovieSeq(movieSeq);
                movieseqlist.add(vo.getMovieSeq());
                vo.setM_title(title);
                vo.setM_titleEng(titleEng);

				JSONObject kObject = ko.getJSONObject("directors");
				JSONArray larray = kObject.getJSONArray("director");
				String directorNm = "";
				for(int x=0;x<larray.length();x++) {
					if(x>0)directorNm += ", ";
					JSONObject mo = (JSONObject)larray.get(x);
					directorNm = mo.getString("directorNm");
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
				}	
				vo.setM_vod(vodUrl);
				
				JSONObject zObject = ko.getJSONObject("actors");
				JSONArray xarray = zObject.getJSONArray("actor");
				String actorNm = "";
				for(int y=0;y<qarray.length();y++) {
					if(y>0) actorNm +=", ";
					JSONObject wo = (JSONObject)xarray.get(y);
					actorNm += wo.getString("actorNm");
				}	
				vo.setM_actor(actorNm);
				movielist.add(vo);
            }
        }

       System.out.println("==============================================");
	   //잘 들어갔는지 테스트
       MovieVO vo = new MovieVO();
	   System.out.println("movielist?" + movielist);
       System.out.println("AAAAAAA = "+ movielist.get(1));
       
       System.out.println("movieseq?" +  movieseqlist);
    }
}






