class HomeController < ApplicationController
$gender = "Male"
  def index
    @s3s_last4 = S3.all.last(4)
    @s3s_last1 = S3.all.last(1)
    @todayspick = S3.order('RAND()').limit(1)

    @game_joins =  S3.joins(:nfcs).where(:nfcs => { :id => 1 })


    #바지
    @show_pants = Baji.order('RAND()').limit(1)

    # 카운트 만들자, 만들어 두고 보류, 테이블 두 개 엮어서 nfc이용해서 s3의 img_url 가지고 나와야 된다
    #@count = Nfc.last(5)
    @count_in_nfcs = Nfc.joins("INNER JOIN s3s ON s3s.id = nfcs.id").last(4)
    @count_join_s3s = S3.joins("INNER JOIN nfcs ON s3s.id = nfcs.id").first(4).reverse()


    #배열 생성 및 정렬 nfc의 카운트 횟수 담아주는 array 생성, 카운트 칼럼의 count 순서를 역순으로 정렬
    @dictionary = Hash.new

    @nfc = Nfc.all

    @array = []
    # @count_in_nfcs.each do |i|
    @nfc.each do |i|

      @array.push(i.count)
      @array.sort! { |x, y| y <=> x }

    @count = 0
    end

    # ####################################

    # 뷰 사진 정렬 ==> 딕셔너리로 해보자
   @array_pic = []
   @count_join_s3s.each do |i|
     @array_pic.push(i.img_url)
   end

   for i in 0..3
    @dictionary[@array_pic[i]] = @array[i]
   end

###########################3



    #옷 데이터

    # 쇼핑몰 추천 함수#

    # 남자
    @images_m1 = ["/assets/aland_m_1.jpg", "/assets/aland_m_2.jpg", "/assets/aland_m_3.jpg"]
    @images_m2 = ["/assets/spao_m_1.jpg", "/assets/spao_m_2.jpg", "/assets/spao_m_3.jpg"]
    @images_m3 = ["/assets/uniqlo_m_1.jpg", "/assets/uniqlo_m_2.jpg", "/assets/uniqlo_m_3.jpg"]

    # 남자옷 링크
    @link_m1 = ["http://www.a-land.co.kr/shop/goods_view.php?id=0000436702&cid=001001002003001&depth=1",
    "http://www.a-land.co.kr/shop/goods_view.php?id=0000436602&cid=001001002002002&depth=1",
    "http://www.a-land.co.kr/shop/goods_view.php?id=0000436587&cid=001001001007000&depth="]
    @link_m2 = ["http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no=1805717071&vir_vend_no=VV16001887&sale_shop_divi_cd=11&disp_ctg_no=&sale_area_no=D1606000566&tr_yn=N&conts_dist_no=1805717071&conts_divi_cd=20&rel_no=1805717071&rel_divi_cd=10&brand_nm=%EC%8A%A4%ED%8C%8C%EC%98%A4(SPAO)&goods_nm=%EB%8D%B0%EB%8B%98+%EB%94%94%EC%8A%A4%ED%8A%B8%EB%A1%9C%EC%9D%B4%EB%93%9C+%ED%95%98%ED%94%84+%ED%8C%AC%EC%B8%A0_SPTN825C23&cust_sale_price=29900&ga_ctg_nm=BOTTOM&dlp_list=&dlp_category=MEN%2FBOTTOM%2F%EB%B0%98%EB%B0%94%EC%A7%80",
    "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no=1803610378&vir_vend_no=VV16001928&sale_shop_divi_cd=11&disp_ctg_no=&sale_area_no=D1606000566&tr_yn=N&conts_dist_no=1803610378&conts_divi_cd=20&rel_no=1803610378&rel_divi_cd=10&brand_nm=%EC%8A%A4%ED%8C%8C%EC%98%A4(SPAO)&goods_nm=%EB%A1%B1+%EC%99%80%EC%9D%B4%EB%93%9C+%EC%BD%94%ED%8A%BC%ED%8C%AC%EC%B8%A0_SPTC824G16&cust_sale_price=29900&ga_ctg_nm=BOTTOM&dlp_list=&dlp_category=MEN%2FBOTTOM%2F%EB%B0%98%EB%B0%94%EC%A7%80",
    "http://spao.elandmall.com/goods/initGoodsDetail.action?goods_no=1801533297&vir_vend_no=VV16001928&sale_shop_divi_cd=11&disp_ctg_no=&sale_area_no=D1606000566&tr_yn=N&conts_dist_no=1801533297&conts_divi_cd=20&rel_no=1801533297&rel_divi_cd=10&brand_nm=%EC%8A%A4%ED%8C%8C%EC%98%A4(SPAO)&goods_nm=%EB%8D%B0%EB%8B%98+%EC%9B%8C%ED%81%AC+%EC%9E%90%EC%BC%93_SPJE812C11&cust_sale_price=29900&ga_ctg_nm=OUTER&dlp_list=&dlp_category=MEN%2FOUTER%2F%EC%9E%90%EC%BC%93"
    ]
    @link_m3 = ["http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31110975&displayNo=NQ1A01A12A03&stonType=P&storeNo=83&siteNo=50706" ,
    "http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31111579&displayNo=NQ1A01A12A04&stonType=P&storeNo=83&siteNo=50706",
    "http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31112167&displayNo=NQ1A01A11A03&stonType=P&storeNo=83&siteNo=50706"
    ]



    # 여자
    @images_w1 = ["/assets/style_w_3.jpg", "/assets/style_w_11.jpg", "/assets/style_w_22.jpg"]
    @images_w2 = ["/assets/mixxo_w_1.jpg", "/assets/mixxo_w_2.jpg", "/assets/style_w.jpg"]
    @images_w3 = ["/assets/uniqlo_w_1.jpg", "/assets/uniqlo_w_2.jpg", "/assets/uniqlo_w_3.jpg"]

    # 여자옷 링크
    @link_w1 = ["http://stylenanda.com/product/detail.html?product_no=228767&cate_no=121&display_group=1",
      "http://stylenanda.com/product/detail.html?product_no=229654&cate_no=53&display_group=1",
      "http://stylenanda.com/product/detail.html?product_no=229587&cate_no=53&display_group=1"
    ]
    @link_w2 = ["http://mixxo.elandmall.com/goods/initGoodsDetail.action?goods_no=1806776918&vir_vend_no=VV16001901&sale_shop_divi_cd=11&disp_ctg_no=&sale_area_no=D1606000566&tr_yn=N&conts_dist_no=1806776918&conts_divi_cd=20&rel_no=1806776918&rel_divi_cd=10&brand_nm=%EB%AF%B8%EC%8F%98(MIXXO)&goods_nm=%EB%8D%94%EB%B8%94%EB%B2%84%ED%8A%BC+%EB%A6%B0%EB%84%A8%EC%85%94%EC%B8%A0+MIWYW8601A&cust_sale_price=39900&ga_ctg_nm=%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4%2F%EC%85%94%EC%B8%A0&dlp_list=&dlp_category=CLOTHING%2F%EB%B8%94%EB%9D%BC%EC%9A%B0%EC%8A%A4%2C%EC%85%94%EC%B8%A0%2F%EC%85%94%EC%B8%A0",
    "http://mixxo.elandmall.com/goods/initGoodsDetail.action?goods_no=1806767646&vir_vend_no=VV16001901&sale_shop_divi_cd=11&disp_ctg_no=&sale_area_no=D1606000566&tr_yn=N&conts_dist_no=1806767646&conts_divi_cd=20&rel_no=1806767646&rel_divi_cd=10&brand_nm=%EB%AF%B8%EC%8F%98(MIXXO)&goods_nm=%EC%97%B0%EC%B2%AD+%EB%8D%B0%EB%8B%98+%EC%88%8F%ED%8C%AC%EC%B8%A0+MIWTH8616J&cust_sale_price=39900&ga_ctg_nm=%ED%8C%AC%EC%B8%A0&dlp_list=&dlp_category=CLOTHING%2F%ED%8C%AC%EC%B8%A0%2F%EB%8D%B0%EB%8B%98+%ED%8C%AC%EC%B8%A0",
    "http://stylenanda.com/product/detail.html?product_no=229654&cate_no=53&display_group=1"
    ]
    @link_w3 = ["http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31111674&displayNo=NQ1A02A12A06&stonType=P&storeNo=83&siteNo=50706",
    "http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31111912&displayNo=NQ1A02A12A03&stonType=P&storeNo=83&siteNo=50706",
    "http://store-kr.uniqlo.com/display/showDisplayCache.lecs?goodsNo=NQ31111437&displayNo=NQ1A02A10A02&stonType=P&storeNo=83&siteNo=50706"
    ]



    #난수 생성
    @rand_num1 = rand(2)
    @rand_num2 = rand(2)
    @rand_num3 = rand(2)


    # if문 돌리기

    if $gender == "Male"
      # 랜덤으로 쇼핑몰 3개에서 옷 꺼내오기
      @shoppingmall_num1 = @images_m1[@rand_num1]
      @link_random_num1 = @link_m1[@rand_num1]


      @shoppingmall_num2 = @images_m2[@rand_num2]
      @link_random_num2 = @link_m2[@rand_num2]

      @shoppingmall_num3 = @images_m3[@rand_num3]
      @link_random_num3 = @link_m3[@rand_num3]

    elsif $gender == "Female"
      @shoppingmall_num1 = @images_w1[@rand_num1]
      @link_random_num1 = @link_w1[@rand_num1]

      @shoppingmall_num2 = @images_w2[@rand_num2]
      @link_random_num2 = @link_w2[@rand_num2]

      @shoppingmall_num3 = @images_w3[@rand_num3]
      @link_random_num3 = @link_w3[@rand_num3]
    end

  end

  


  def history
    @realtestsall = S3.all

    # 삭제 기능 구현
    # realtest = Realtest.new
    # realtest.id = params[:idd]
  end

  def destroy
    delete = S3.find(params[:id])
    delete.destroy
    redirect_to '/home/history'
  end


  def information

  end

  def infoupdate
    $gender = params[:gender]
    redirect_to '/home/index'
  end

  # @books = Book.limit(4) 처음부터 4개 꺼내오는 방법
end
