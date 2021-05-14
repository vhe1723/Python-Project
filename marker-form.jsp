<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- 달력 -->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link rel="shortcut icon" href="../favicon.ico">
    <link rel="stylesheet" type="text/css" href="css/default_copy.css" />
    <link rel="stylesheet" type="text/css" href="css/component_copy.css" />
    <script src="js/modernizr.custom.js"></script>
    <script src="js/classie.js"></script>
    
    <!-- 마커클러스터 라이브러리삽입 -->
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
    <!-- 구글키 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2BcxuyRqDagD9gh4z3UDHMNnHbMV1-ao&callback=initMap&language=ko&region=kr" async defer>
    </script>


</head>


<body>
    <script>
      // 사용자가 검색하는 주소와 키워드
        var adr1;
        var adr2;
        var kwd1;
        
        // **** 카테고리 선택 -> 카테고리
        function categoryChange(e) {
            var loc_0 = ["중분류"]
            var loc_a = ["중분류","강남구","강동구","강북구","강서구","관악구","광진구",
                        "구로구","금천구","노원구","도봉구","동대문구","동작구",
                        "마포구","서대문구","서초구","성동구","성북구","송파구",
                        "양천구","영등포구","용산구","은평구","종로구","중구","중랑구"]
            var loc_b = ["중분류","강서구","금정구","기장군","남구","동구","동래구",
                        "부산진구","북구","사상구","사하구","서구","수영구",
                        "연제구","영도구","중구","해운대구"]
            var loc_c = ["중분류","남구","달서구","달성군","동구","북구","서구","수성구","중구"]
            var loc_d = ["중분류","강화군","계양구","남동구","동구","미추홀구","부평구","서구","연수구","옹진군","중구"]
            var loc_e = ["중분류","광산구","남구","동구","북구","서구"]
            var loc_f = ["중분류","대덕구","동구","서구","유성구","중구"]
            var loc_g = ["중분류","남구","동구","북구","울주군","중구"]
            var loc_h = ["중분류","세종"]
            var loc_i = ["중분류","가평군","고양시","고양시 덕양구","고양시 일산동구","고양시 일산서구",
                        "과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시",
                        "부천시","성남시","성남시 분당구","성남시 수정구","성남시 중원구","수원시",
                        "수원시 권선구","수원시 영통구","수원시 장안구","수원시 팔달구","시흥시","안산시",
                        "안산시 단원구","안산시 상록구","안성시","안양시","안양시 동안구","안양시 만안구",
                        "양주시","양평군","여주시","연천군","오산시","용인시","용인시 기흥구","용인시","용인시 기흥구",
                        "용인시 수지구","용인시 처인구","의왕시","의정부시","이천시","파주시","평택시","포천군","포천시",
                        "하남시","화성시"]
            var loc_j = ["중분류","강릉시","고성군","동해시","삼척시","속초시","양구군","양양군","영월군","원주시","인제군",
                        "정선군","철원군","춘천시","태백시","평창군","흥천군","회천군","횡성군"]
            var loc_k = ["중분류","괴산군","단양군","보은군","영동군","옥천군","음성군","제천시","증평군","진천군","청원군",
                        "청주시","청주시 상당구","청주시 서원구","청주시 청원구","청주시 흥덛구","충주시"]
            var loc_l = ["중분류","계룡시","공주시","금산군","논산시","당진시","보령시","부여군","서산시","서천군","아산시",
                        "연기군","예산군","천안시","천안시 동남구","천안시 서북구","청양군","태안군","흥성군"]
            var loc_m = ["중분류","고창군","군산시","김제시","남원시","무주군","부안군","순창군","완주군","익산시","임실군",
                        "장수군","전주시","전주시 덕진구","전주시 완산구","정읍시","진안군"]
            var loc_n = ["중분류","강진군","고흥군","곡성군","광양시","구례군","나주시","담양군","목포시","무안군","보성군",
                        "순천시","신안군","여수시","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군",
                        "화순군"]
            var loc_o = ["중분류","경산시","경주시","고령군","구미시","군위군","김천시","문경시","봉화군","상주시","성주군",
                        "안동시","영덕군","영양군","영주시","영천시","예천군","울릉군","울진군","의성군","청도군","청송군",
                        "칠곡군","포항시","포항시 남구","포항시 북구"]
            var loc_p = ["중분류","거제시","거창군","고성군","김해시","남해군","밀양시","사천시","산청군","양산시","의령군",
                        "진주시","창녕군","창원시","창원시 마산합포구","창원시 마산회의구","창원시 성산구","창원시 의창구",
                        "창원시 진해구","통영시","하동군","함안군","함양군","합천군"]
            var loc_q = ["중분류","서귀포시","제주시"]
            
            var target = document.getElementById("loc-2");

            if(e.value == "0") var locs = loc_0;
            else if(e.value == "서울") var locs = loc_a;
            else if(e.value == "부산") var locs = loc_b;
            else if(e.value == "대구") var locs = loc_c;
            else if(e.value == "인천") var locs = loc_d;
            else if(e.value == "광주") var locs = loc_e;
            else if(e.value == "대전") var locs = loc_f;
            else if(e.value == "울산") var locs = loc_g;
            else if(e.value == "세종") var locs = loc_h;
            else if(e.value == "경기") var locs = loc_i;
            else if(e.value == "강원") var locs = loc_j;
            else if(e.value == "충북") var locs = loc_k;
            else if(e.value == "충남") var locs = loc_l;
            else if(e.value == "전북") var locs = loc_m;
            else if(e.value == "전남") var locs = loc_n;
            else if(e.value == "경북") var locs = loc_o;
            else if(e.value == "경남") var locs = loc_p;
            else if(e.value == "제주") var locs = loc_q;

            target.options.length = 0;

            for (loc in locs) {
                var opt = document.createElement("option");
                opt.value = locs[loc];
                opt.innerHTML = locs[loc];
                target.appendChild(opt);
            }
            // 사용자가 선택한 주소 대분류
            adr1 = e.options[e.selectedIndex].text;
        }

        function adrChange(e) {
           // 사용자가 선택한 주소 중분류
            adr2 = e.options[e.selectedIndex].text;
        }

        function kwdChange(e) {
           // 사용자가 검색한 키워드
            kwd1 = e.options[e.selectedIndex].text;
        }


        // ***** 달력 관련 *****

        // 달력 띄우기
        $(function(){
            $("#date1").datepicker();
            $("#date2").datepicker();
        });

        
        // ***** 지도 관련 *****
        // 지도와 지오코더
        var map;
        var geocoder;
        
        function initMap() {

            //지도가 보여질 요소 찾아오기
            var e= document.getElementById('map');
            
            // Goolgle지도 객체 생성 및 e요소 보여주기!! (시작위치: 서울 중구)
            map = new google.maps.Map(e, {center: {lat: 37.5579452, lng: 126.9941904}, zoom: 12});

            geocoder = new google.maps.Geocoder();
            
            
            //////////////////////////////////////////////////////////////////
            
            // 지도 중심위치 세션스토리지에서 불러오기
            var address = sessionStorage.getItem("address");
            
            geocoder.geocode({'address': address}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                   // 중심위치 위경도 알아내서 위치 이동
                    map.setCenter(results[0].geometry.location);

                    // **** 마커 표시
                    var infowindow = new google.maps.InfoWindow();

                    var marker, i;
                    var locations = [];
                    
                    <%
                    // db에서 위경도 받아오기
               ResultSet rs = null;
               Statement stmt = conn.createStatement();
               
               String sql = "SELECT * FROM tmp_hrd;";
               rs = stmt.executeQuery(sql);
               
               int i = 0;
               while(rs.next()) {
                  String place = rs.getString("place");
                  String lat = rs.getString("lat");
                  String lng = rs.getString("lng");
                  String link = rs.getString("link");
                  String title = rs.getString("title");
                    %>
                      
                       marker = new google.maps.Marker({
                           position: new google.maps.LatLng(<%=lat%>, <%=lng%>),
                           map: map
                       });
                    
                       // 클릭 시 팝업 뜨는 것
                  google.maps.event.addListener(marker, 'click', (function(marker, i) {
                     return function() {
                         //html로 표시될 인포 윈도우의 내용
                         infowindow.setContent("과정 : <%=title%><br>기관 : <%=place%><br><a href='<%=link%>'target='blank'>해당사이트이동</a>");
                          //인포윈도우가 표시될 위치
                          infowindow.open(map, marker);
                      }
                  })(marker, i));
                    
                       // 마커 눌렀을 때 변화
                  if(marker) {
                      marker.addListener('click', function() {
                          //중심 위치를 클릭된 마커의 위치로 변경
                          map.setCenter(this.getPosition());
                          //마커 클릭 시의 줌 변화
                          map.setZoom(16);
                      });
                  }
                  
               <%
                  i++;
               }
               %>
                      
                }
                else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
            
            //////////////////////////////////////////////////////////////////
            
            // 검색 버튼 클릭시 세션스토리지에 주소 저장
            document.getElementById('search-btn').addEventListener('click', function() {
               adr = adr1 + " " + adr2;
               sessionStorage.setItem("address", adr);
            });
            
        }
        
        // left-list 클릭시 변화
        function moveMap(lat, lng) {
           // 중심 위치 받아옴
            var center = new google.maps.LatLng(lat, lng);
           // 중심 위치를 클릭된 리스트의 위치로 변경
            map.panTo(center);
            map.setZoom(14);
        }
        

</script>


    <!-- 전체 맵 -->
    <div map id="map">
    </div>

    <!-- 좌측 전체 -->
    <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
       <div _showbtn>
          <button id="showLeft">search</button>
       </div>
       
        <div _left>
            <!-- 검색 툴창 -->

            <div _left-search>
                <form method="post" action="main-server.jsp">
                        <!-- 첫번째 검색창 -->
                        <div class="search1">
                            <select class="select-box-1" name='standard' onchange="kwdChange(this)">
                                <option value="all">전체</option>
                                <option value="title">과정</option>
                                <option value="place">기관</option>
                            </select>
                            <input class="input-keyword" name='keyword' id="kwd2" placeholder="키워드">
                        </div>
                        <div class="search2">
                            <select class="select-box" id="loc-1" name='loc1' onchange="categoryChange(this)">
                                <option value="0">시/도</option>
                                <option value="서울">서울</option>
                                <option value="부산">부산</option>
                                <option value="대구">대구</option>
                                <option value="인천">인천</option>
                                <option value="광주">광주</option>
                                <option value="대전">대전</option>
                                <option value="울산">울산</option>
                                <option value="세종">세종</option>
                                <option value="경기">경기</option>
                                <option value="강원">강원</option>
                                <option value="충북">충북</option>
                                <option value="충남">충남</option>
                                <option value="전북">전북</option>
                                <option value="전남">전남</option>
                                <option value="경북">경북</option>
                                <option value="경남">경남</option>
                                <option value="제주">제주</option>
                            </select>
                            <select class="select-box" id="loc-2" name='loc2' onchange="adrChange(this)">
                                <option>시/군/구</option>
                            </select>
                        </div>
                        <div class="search3">
                            <input class="input-date" name='term_start' id="date1" placeholder="시작 날짜">
                            <input class="input-date" name='term_end' id="date2" placeholder="종료 날짜">
                        </div>
                        <div class="search4">
                            <input id="search-btn" type="submit" value="검색">
                        </div>
                </form>
            </div>
            
            <div _left-list>
        
            <% 
            // db에서 리스트에 띄울 정보 가져옴
         String sql2 = "SELECT * FROM tmp_hrd;";
         rs = stmt.executeQuery(sql2);
         
         while(rs.next()){
            String title = rs.getString("title");
            String place = rs.getString("place");
            String term = rs.getString("term");
            String lat = rs.getString("lat");
            String lng = rs.getString("lng");
            String term_time = rs.getString("term_time");
            String emp_rate = rs.getString("emp_rate");
            
            // 리스트 출력 부분
            out.println("<div onclick='moveMap(" + lat + ", " + lng + ")'><h4>" + title + "</h4>");
            out.println("<h5>" + place + "<br>");
            out.println(term + " (" + term_time + ")<br>취업률: "+emp_rate+"%</h5></div><hr>");
         }
         
         stmt.close();
         conn.close();
            %>
            
        </div>
    </nav>

    

    <script>
        var menuLeft = document.getElementById('cbp-spmenu-s1'),
            showLeft = document.getElementById('showLeft'),
            body = document.body;

        showLeft.onclick = function() {
            classie.toggle(this, 'active');
            classie.toggle(menuLeft, 'cbp-spmenu-open');
            disableOther('showLeft');
        };
    </script>
    
</body>

</html>