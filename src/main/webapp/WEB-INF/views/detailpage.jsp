<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="default">
    <!-- Facebook Meta Tags / 페이스북 오픈 그래프 -->
    <meta property="og:url" content="http://kindtiger.dothome.co.kr/insta">
    <meta property="og:type" content="website">
    <meta property="og:title" content="instagram">
    <meta property="og:description" content="instagram clone">
    <meta property="og:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
    .
    <!-- Twitter Meta Tags / 트위터 -->
    <meta name="twitter:card" content="instagram clone">
    <meta name="twitter:title" content="instagram">
    <meta name="twitter:description" content="instagram clone">
    <meta name="twitter:image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">

    <!-- Google / Search Engine Tags / 구글 검색 엔진 -->
    <meta itemprop="name" content="instagram">
    <meta itemprop="description" content="instagram clone">
    <meta itemprop="image" content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">


    <title>instagram</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/team/reset.css">
    <link rel="stylesheet" href="/resources/css/team/common.css">
    <link rel="stylesheet" href="/resources/css/team/style.css">
    <link rel="stylesheet" href="/resources/css/team/detail-page.css">
    <link rel="shortcut icon" href="/resources/img/team/instagram.png">


    <style>
        #main_container {
            /*height: 6000px;*/
        }
    </style>
</head>
<body>


<section id="container">


    <header id="header">
        <section class="h_inner">

            <h1 class="logo">
                <a href="index.html">
                    <div class="sprite_insta_icon"></div>
                    <div>
                        <div class="sprite_write_logo"></div>
                    </div>
                </a>
            </h1>

            <div class="search_field">
                <input type="text" placeholder="검색" tabindex="0">

                <div class="fake_field">
                    <span class=sprite_small_search_icon></span>
                    <span>검색</span>
                </div>
            </div>


            <div class="right_icons">
                <a href="new_post.html"><div class="sprite_camera_icon"></div></a>
                <a href="login.html"><div class="sprite_compass_icon"></div></a>
                <a href="follow.html"><div class="sprite_heart_icon_outline"></div></a>
                <a href="profile.html"><div class="sprite_user_icon_outline"></div></a>
            </div>
        </section>
    </header>


    <div id="main_container">

        <section class="b_inner">

            <div class="contents_box">

                <article class="contents cont01">

                    <div class="img_section">
                        <div class="trans_inner">
                            <div><img src="/resources/img/team/img_section/img03.jpg" alt=""></div>
                        </div>
                    </div>


                    <div class="detail--right_box">

                        <header class="top">
                            <div class="user_container">
                                <div class="profile_img">
                                    <img src="/resources/img/team/thumb.jpeg" alt="">
                                </div>
                                <div class="user_name">
                                    <div class="nick_name">KindTiger</div>
                                    <div class="country">Seoul, South Korea</div>
                                </div>
                            </div>
                            <div class="sprite_more_icon" data-name="more">
                                <ul class="more_detail">
                                    <li>팔로우</li>
                                    <li>수정</li>
                                    <li>삭제</li>
                                </ul>
                            </div>

                        </header>

                        <section class="scroll_section">
                            <div class="admin_container">
                                <div class="admin"><img src="/resources/img/team/thumb.jpeg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">Kindtiger</span>강아지가 많이 힘든가보다ㅜㅜㅜㅜㅜ조금만힘내
                                    <div class="time">2시간</div>
                                </div>
                            </div>

                            <div class="user_container-detail">
                                <div class="user"><img src="/resources/img/team/thumb02.jpg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">in0.lee</span>너무귀엽네요 ㅎㅎㅎ맞팔해요~!
                                    <div class="time">2시간 <span class="try_comment">답글 달기</span></div>
                                    <div class="icon_wrap">
                                        <div class="more_trigger">
                                            <div class="sprite_more_icon"></div>
                                        </div>
                                        <div>
                                            <div class="sprite_small_heart_icon_outline"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="user_container-detail">
                                <div class="user"><img src="/resources/img/team/thumb03.jpg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">ye_solkim</span>강아지 이름이 뭐에요???
                                    <div class="time">2시간 <span class="try_comment">답글 달기</span></div>
                                    <div class="icon_wrap">
                                        <div class="more_trigger">
                                            <div class="sprite_more_icon"></div>
                                        </div>
                                        <div>
                                            <div class="sprite_small_heart_icon_outline"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="user_container-detail">
                                <div class="user"><img src="/resources/img/team/thumb02.jpg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">in0.lee</span>너무귀엽네요 ㅎㅎㅎ맞팔해요~!
                                    <div class="time">2시간 <span class="try_comment">답글 달기</span></div>
                                    <div class="icon_wrap">
                                        <div class="more_trigger">
                                            <div class="sprite_more_icon"></div>
                                        </div>
                                        <div>
                                            <div class="sprite_small_heart_icon_outline"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="user_container-detail">
                                <div class="user"><img src="/resources/img/team/thumb03.jpg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">in0.lee</span>너무귀엽네요
                                    <div class="time">2시간 <span class="try_comment">답글 달기</span></div>
                                    <div class="icon_wrap">
                                        <div class="more_trigger">
                                            <div class="sprite_more_icon"></div>
                                        </div>
                                        <div>
                                            <div class="sprite_small_heart_icon_outline"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="user_container-detail">
                                <div class="user"><img src="/resources/img/team/thumb02.jpg" alt="user"></div>
                                <div class="comment">
                                    <span class="user_id">in0.lee</span>너무귀엽네요 ㅎㅎㅎ맞팔해요~!
                                    <div class="time">2시간 <span class="try_comment">답글 달기</span></div>
                                    <div class="icon_wrap">
                                        <div class="more_trigger">
                                            <div class="sprite_more_icon"></div>
                                        </div>
                                        <div>
                                            <div class="sprite_small_heart_icon_outline"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </section>


                        <div class="bottom_icons">
                            <div class="left_icons">
                                <div class="heart_btn">
                                    <div class="sprite_heart_icon_outline" data-name="heartbeat"></div>
                                </div>
                                <div>
                                    <div class="sprite_bubble_icon"></div>
                                </div>
                                <div>
                                    <div class="sprite_share_icon" data-name="share"></div>
                                </div>
                            </div>

                            <div class="right_icon">
                                <div class="sprite_bookmark_outline" data-name="book-mark"></div>
                            </div>
                        </div>

                        <div class="count_likes">
                            좋아요
                            <span class="count">2,351</span>
                            개
                        </div>
                        <div class="timer">2시간</div>

                        <div class="commit_field">
                            <input type="text" placeholder="댓글달기..">

                            <div class="upload_btn">게시</div>
                        </div>



                    </div>


                </article>


            </div>


        </section>

    </div>


    <div class="del_pop">
        <div class="btn_box">
            <div class="del">삭제</div>
            <div class="cancel">취소</div>
        </div>
   </div>

</section>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<!--<script src="js/detail.js"></script>-->


</body>
</html>