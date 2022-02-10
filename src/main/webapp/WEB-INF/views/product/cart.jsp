<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	/* Set rates + misc */
	var shippingRate = 3000; 
	var fadeTime = 300;


	/* Assign actions */
	$('.product-quantity input').change( function() {
	  updateQuantity(this);
	});

	$('.product-removal button').click( function() {
	  removeItem(this);
	});


	/* Recalculate cart */
	function recalculateCart()
	{
	  var subtotal = 0;
	  
	  /* Sum up row totals */
	  $('.product').each(function () {
		var price = $(this).children('.product-line-price').html();
	    subtotal += parseFloat(price);
	  });
	  
	  /* Calculate totals */
	  var shipping = (subtotal > 0 ? shippingRate : 0);
	  var total = subtotal + shipping;
	  
	  /* Update totals display */
	  $('.totals-value').fadeOut(fadeTime, function() {
	    $('#cart-subtotal').html(subtotal);
	    $('#cart-shipping').html();
	    $('#cart-total').html(total);
	    if(total == 0){
	      $('.checkout').fadeOut(fadeTime);
	    }else{
	      $('.checkout').fadeIn(fadeTime);
	    }
	    $('.totals-value').fadeIn(fadeTime);
	  });
	}

	/* Update quantity */
	function updateQuantity(quantityInput)
	{
	  /* Calculate line price */
	  var productRow = $(quantityInput).parent().parent();
	  var price = parseFloat(productRow.children('.product-price').text());
	  var quantity = $(quantityInput).val();
	  var linePrice = price * quantity;
	  /* Update line price display and recalc cart totals */
	  productRow.children('.product-line-price').each(function () {
	    $(this).fadeOut(fadeTime, function() {
	      $(this).text(linePrice);
	      recalculateCart();
	      $(this).fadeIn(fadeTime);
	    });
	  });  
	}


	/* Remove item from cart */
	function removeItem(removeButton)
	{
	  /* Remove row from DOM and recalc cart total */
	  var productRow = $(removeButton).parent().parent();
	  productRow.slideUp(fadeTime, function() {
	    productRow.remove();
	    recalculateCart();
	  });
	}

	$(".checkout").click(function() {
		//가맹점 식별코드
		IMP.init('imp20573051');
		IMP.request_pay({
		    pg : 'html5_inicis',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '상품명' , //결제창에서 보여질 이름
		    amount : 100, //실제 결제되는 가격
		    buyer_email : 'cnlguq@gmail.com',
		    buyer_name : '김지원',
		    buyer_tel : '010-9865-0906',
		    buyer_addr : '광주 서구 화정동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
			console.log(rsp);
		    if ( rsp.success ) {
		    	var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		    } else {
		    	 var msg = '결제에 실패하였습니다.';
		         msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});
	});
	
});
</script>
<style>

.product-image {
  float: left;
  width: 20%;
}

.product-details {
  float: left;
  width: 37%;
}

.product-price {
  float: left;
  width: 12%;
}

.product-quantity {
  float: left;
  width: 10%;
}

.product-removal {
  float: left;
  width: 9%;
}

.product-line-price {
  float: left;
  width: 12%;
  text-align: right;
}

/* This is used as the traditional .clearfix class */
.group:before, .shopping-cart:before, .column-labels:before, .product:before, .totals-item:before,
.group:after,
.shopping-cart:after,
.column-labels:after,
.product:after,
.totals-item:after {
  content: "";
  display: table;
}

.group:after, .shopping-cart:after, .column-labels:after, .product:after, .totals-item:after {
  clear: both;
}

.group, .shopping-cart, .column-labels, .product, .totals-item {
  zoom: 1;
}

/* Apply clearfix in a few places */
/* Apply dollar signs */
.product .product-price:after, .product .product-line-price:after, .totals-value:after {
  content: "원";
}

/* Body/Header stuff */
body {
  font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-weight: 100;
  color: black;
}

h1 {
  font-weight: 100;
}

label {
  color: graytext;
}

.shopping-cart {
  margin-top: -45px;
}

/* Column headers */
.column-labels label {
  padding-bottom: 15px;
  margin-bottom: 15px;
  border-bottom: 3px solid black;
}
.column-labels .product-image, .column-labels .product-details, .column-labels .product-removal {
  text-indent: -9999px;
}

/* Product entries */
.product {
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 2px solid #BDBDBD;
}
.product .product-image {
  text-align: center;
}
.product .product-image img {
  width: 100px;
}
.product .product-details .product-title {
  margin-right: 20px;
  font-family: "HelveticaNeue-Medium", "Helvetica Neue Medium";
}
.product .product-details .product-description {
  margin: 5px 20px 5px 0;
  line-height: 1.4em;
}
.product .product-quantity input {
  width: 40px;
  
}
.product .remove-product {
  border: 0;
  padding: 4px 8px;
  background-color: #c66;
  color: #fff;
  font-family: "HelveticaNeue-Medium", "Helvetica Neue Medium";
  font-size: 12px;
  border-radius: 3px;
}
.product .remove-product:hover {
  background-color: #a44;
}

/* Totals section */
.totals .totals-item {
  float: right;
  clear: both;
  width: 100%;
  margin-bottom: 10px;
}
.totals .totals-item label {
  float: left;
  clear: both;
  width: 79%;
  text-align: right;
}
.totals .totals-item .totals-value {
  float: right;
  width: 21%;
  text-align: right;
}
.totals .totals-item-total {
  font-family: "HelveticaNeue-Medium", "Helvetica Neue Medium";
}

.checkout {
  float: right;
  border: 0;
  margin-top: 20px;
  padding: 6px 25px;
  background-color: #6b6;
  color: #fff;
  font-size: 25px;
  border-radius: 3px;
}

.checkout:hover {
  background-color: #494;
}

/* Make adjustments for tablet */
@media screen and (max-width: 800px) {
  .shopping-cart {
    margin: 0;
    padding-top: 20px;
    border-top: 1px solid #eee;
  }

  .column-labels {
    display: none;
  }

  .product-image {
    float: right;
    width: auto;
  }
  .product-image img {
    margin: 0 0 10px 10px;
  }

  .product-details {
    float: none;
    margin-bottom: 10px;
    width: auto;
  }

  .product-price {
    clear: both;
    width: 70px;
  }

  .product-quantity {
    width: 100px;
  }
  .product-quantity input {
    margin-left: 20px;
  }

  .product-quantity:before {
    content: "x";
  }

  .product-removal {
    width: auto;
  }

  .product-line-price {
    float: right;
    width: 70px;
  }
}
/* Make more adjustments for phone */
@media screen and (max-width: 500px) {
  .product-removal {
    float: right;
  }

  .product-line-price {
    float: right;
    clear: left;
    width: auto;
    margin-top: 10px;
  }

  .product .product-line-price:before {
    content: "Item Total: ₩";
  }

  .totals .totals-item label {
    width: 60%;
  }
  .totals .totals-item .totals-value {
    width: 40%;
  }
}

img{
width: 100px;
height: 100px;
}
</style>
<div class="container" style="margin-top: 100px; margin-bottom: 200px;">

	<h1>장바구니</h1>
	<div class="shopping-cart">
		<div class="column-labels">
			<label class="product-image">Image</label>
			<label class="product-details">Product</label>
			<label class="product-price">Price</label>
			<label class="product-quantity">Quantity</label>
			<label class="product-removal">Remove</label>
			<label class="product-line-price">Total</label>
		</div>
		
	<c:forEach items="${cart}" var="cart">
		<c:set value="${cart.goods_image}" var="img"></c:set>
		<div class="product">
			<div class="product-image">
				<c:choose>
					<c:when test="${empty img}">
						<img src="${contextPath}/resources/img/default.jpg">
					</c:when>
					<c:otherwise>
						<c:forEach items="${cart.attachList}" var="cartimg">
							<c:choose>
								<c:when test="${cartimg.fileName eq img}">
									<img src="${contextPath}/resources/fileUpload/${cartimg.uploadpath}/${cartimg.uuid}_${cartimg.fileName}">
								</c:when>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="product-details">
				<div class="product-title">${cart.goods_name}</div>
				<p class="product-description">${cart.goods_contents}</p>
			</div>
			<div class="product-price">${cart.goods_cost}</div>
			<div class="product-quantity">
				<input type="number" value="1" min="1">
			</div>
			<div class="product-removal">
				<button class="remove-product" data-num="${cart.goods_num}">Remove</button>
			</div>
			<div class="product-line-price">${cart.goods_cost}</div>
		</div>
	</c:forEach>
	
	  <div class="totals">
	    <div class="totals-item">
	      <label>상품 총 가격</label>
	      <div class="totals-value" id="cart-subtotal">
	      	      	<c:set value="0" var="subtotal"></c:set>
	      	<c:forEach items="${cart}" var="cost">
	      	<c:set value="${cost.goods_cost + subtotal}" var="subtotal"></c:set>
	      	</c:forEach>
	      	<c:out value="${subtotal}"></c:out>
	      </div>
	    </div>
<!-- 	    <div class="totals-item">
	      <label>세금 (5%)</label>
	      <div class="totals-value" id="cart-tax">3.60</div>
	    </div> -->
	    <div class="totals-item">
	      <label>배송비</label>
	      <div class="totals-value" id="cart-shipping">3000</div>
	    </div>
	    <div class="totals-item totals-item-total">
	      <label>총 가격</label>
	      <div class="totals-value" id="cart-total"><c:out value="${subtotal + 3000}"></c:out></div>
	    </div>
	  </div>
	      <button class="checkout">결제하기</button>
	</div>
</div>

<script>
$(function() {
	$(".remove-product").on("click", function() {
		var num = $(this).data("num");
		$.ajax({
			type : "post",
			url  : "/product/deletecart",
			dataType : "json",
			data : {
				"goods_num" : num
			},
			success : function(data) {
			}
		});
	});
	
});

$(document).keydown(function (e) {
    
    if (e.which === 116) {
        if (typeof event == "object") {
            event.keyCode = 0;
        }
        return false;
    } else if (e.which === 82 && e.ctrlKey) {
        return false;
    }
}); 
</script>
<script language='javascript'>
function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;
</script>
<body oncontextmenu="return false">
<%@ include file="../common/footer.jsp" %>