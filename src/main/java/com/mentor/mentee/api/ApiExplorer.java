//package com.mentor.mentee.api;
//
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.net.URLEncoder;
//import java.io.BufferedReader;
//import java.io.IOException;
//
//public class ApiExplorer {
//    public static void main(String[] args) throws IOException {
//        StringBuilder urlBuilder = new StringBuilder("http://api.data.go.kr/openapi/tn_pubr_public_lbrry_api"); /*URL*/
//        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=서비스키"); /*Service Key*/
//        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("0", "UTF-8")); /*페이지 번호*/
//        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 결과 수*/
//        urlBuilder.append("&" + URLEncoder.encode("type","UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); /*XML/JSON 여부*/
//        urlBuilder.append("&" + URLEncoder.encode("LBRRY_NM","UTF-8") + "=" + URLEncoder.encode("꿈이있는나무작은도서관", "UTF-8")); /*도서관명*/
//        urlBuilder.append("&" + URLEncoder.encode("CTPRVN_NM","UTF-8") + "=" + URLEncoder.encode("전라북도", "UTF-8")); /*시도명*/
//        urlBuilder.append("&" + URLEncoder.encode("SIGNGU_NM","UTF-8") + "=" + URLEncoder.encode("전주시", "UTF-8")); /*시군구명*/
//        urlBuilder.append("&" + URLEncoder.encode("LBRRY_SE","UTF-8") + "=" + URLEncoder.encode("작은도서관", "UTF-8")); /*도서관유형*/
//        urlBuilder.append("&" + URLEncoder.encode("CLOSE_DAY","UTF-8") + "=" + URLEncoder.encode("매주일요일, 법정공휴일", "UTF-8")); /*휴관일*/
//        urlBuilder.append("&" + URLEncoder.encode("WEEKDAY_OPER_OPEN_HHMM","UTF-8") + "=" + URLEncoder.encode("10:00", "UTF-8")); /*평일운영시작시각*/
//        urlBuilder.append("&" + URLEncoder.encode("WEEKDAY_OPER_COLSE_HHMM","UTF-8") + "=" + URLEncoder.encode("18:00", "UTF-8")); /*평일운영종료시각*/
//        urlBuilder.append("&" + URLEncoder.encode("SAT_OPER_OPER_OPEN_HHMM","UTF-8") + "=" + URLEncoder.encode("10:00", "UTF-8")); /*토요일운영시작시각*/
//        urlBuilder.append("&" + URLEncoder.encode("SAT_OPER_CLOSE_HHMM","UTF-8") + "=" + URLEncoder.encode("15:00", "UTF-8")); /*토요일운영종료시각*/
//        urlBuilder.append("&" + URLEncoder.encode("HOLIDAY_OPER_OPEN_HHMM","UTF-8") + "=" + URLEncoder.encode("00:00", "UTF-8")); /*공휴일운영시작시각*/
//        urlBuilder.append("&" + URLEncoder.encode("HOLIDAY_CLOSE_OPEN_HHMM","UTF-8") + "=" + URLEncoder.encode("00:00", "UTF-8")); /*공휴일운영종료시각*/
//        urlBuilder.append("&" + URLEncoder.encode("SEAT_CO","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*열람좌석수*/
//        urlBuilder.append("&" + URLEncoder.encode("BOOK_CO","UTF-8") + "=" + URLEncoder.encode("12574", "UTF-8")); /*자료수(도서)*/
//        urlBuilder.append("&" + URLEncoder.encode("PBLICTN_CO","UTF-8") + "=" + URLEncoder.encode("0", "UTF-8")); /*자료수(연속간행물)*/
//        urlBuilder.append("&" + URLEncoder.encode("NONE_BOOK_CO","UTF-8") + "=" + URLEncoder.encode("0", "UTF-8")); /*자료수(비도서)*/
//        urlBuilder.append("&" + URLEncoder.encode("LON_CO","UTF-8") + "=" + URLEncoder.encode("5", "UTF-8")); /*대출가능권수*/
//        urlBuilder.append("&" + URLEncoder.encode("LON_DAYCNT","UTF-8") + "=" + URLEncoder.encode("14", "UTF-8")); /*대출가능일수*/
//        urlBuilder.append("&" + URLEncoder.encode("RDNMADR","UTF-8") + "=" + URLEncoder.encode("전라북도 전주시 완산구 새터로 122-11", "UTF-8")); /*소재지도로명주소*/
//        urlBuilder.append("&" + URLEncoder.encode("OPER_INSTITUTION_NM","UTF-8") + "=" + URLEncoder.encode("(사)물댄동산", "UTF-8")); /*운영기관명*/
//        urlBuilder.append("&" + URLEncoder.encode("PHONE_NUMBER","UTF-8") + "=" + URLEncoder.encode("063-229-6511", "UTF-8")); /*도서관전화번호*/
//        urlBuilder.append("&" + URLEncoder.encode("PLOT_AR","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*부지면적*/
//        urlBuilder.append("&" + URLEncoder.encode("BULD_AR","UTF-8") + "=" + URLEncoder.encode("347", "UTF-8")); /*건물면적*/
//        urlBuilder.append("&" + URLEncoder.encode("HOMEPAGE_URL","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*홈페이지주소*/
//        urlBuilder.append("&" + URLEncoder.encode("LATITUDE","UTF-8") + "=" + URLEncoder.encode("35.8351264", "UTF-8")); /*위도*/
//        urlBuilder.append("&" + URLEncoder.encode("LONGITUDE","UTF-8") + "=" + URLEncoder.encode("127.1206937649", "UTF-8")); /*경도*/
//        urlBuilder.append("&" + URLEncoder.encode("REFERENCE_DATE","UTF-8") + "=" + URLEncoder.encode("2020-08-31", "UTF-8")); /*데이터기준일자*/
//        urlBuilder.append("&" + URLEncoder.encode("instt_code","UTF-8") + "=" + URLEncoder.encode("4640000", "UTF-8")); /*제공기관코드*/
//        URL url = new URL(urlBuilder.toString());
//        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//        conn.setRequestMethod("GET");
//        conn.setRequestProperty("Content-type", "application/json");
//        System.out.println("Response code: " + conn.getResponseCode());
//        BufferedReader rd;
//        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//        } else {
//            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//        }
//        StringBuilder sb = new StringBuilder();
//        String line;
//        while ((line = rd.readLine()) != null) {
//            sb.append(line);
//        }
//        rd.close();
//        conn.disconnect();
//        System.out.println(sb.toString());
//    }
//}