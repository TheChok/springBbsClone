<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
    <h2>commentTest</h2>
    comment: <input type="text" name="comment"/>
    <br>
    <button id="sendBtn" type="button">SEND</button>
    <button id="modBtn"  type="button">수정</button>
    <div id="commentList">
    </div>
    <div id="replyForm" style="display: none">
        <input 	type="text" name="replyComment"/>
        <button type="button" id="wrtRepBtn" >등록</button>
    </div>

    <script>
        let bno = 2690; // 하드코딩 - 테스트용
        
        let showList = function (bno) {
            $.ajax({
                type	: 'GET',       			// 요청 메서드
                url		: '/comments?bno='+bno, // 요청 URI
                // dataType : 'json', 			// 전송받을 데이터의 타입 -> 'text'로도 적을 수 있다.
                // dataType을 생략하고 작성하면 default값 json으로 적용된다. 그래서 주석처리해서 생략한것.
                success : function(result){		// dataType이 json이면 결과값을 .parse 할 필요가 없다.
                    $("#commentList").html(toHtml(result));
                },
                error   : function(){			// 에러가 발생했을 때, 호출될 함수
                	alert("error") 
                }	
            });
        }
		
        
        //-- $(document).ready(function(){ --//
        $(document).ready(function(){
        	showList(bno);
			
            // modBtn //
            $("#modBtn").click(function(){
                let cno 	= $(this).attr("data-cno");
                let comment = $("input[name=comment]").val();
				
                if (comment.trim() == '') {
                    alert("댓글을 입력해주세요.");
                    $("input[name=comment]").focus();	
                    return;
                }
				
                $.ajax({
                    type	:'PATCH',       		// 요청 메서드
                    url		: '/comments/'+cno,  	// 요청 URI - /comments?bno=2029 POST <- 컨트롤러에 있는 url 참조해서.
                    headers : {						// 요청 헤더 
                    	"content-type": "application/json"
                    }, 
                    data 	: JSON.stringify({		// 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    	bno		: bno, 
                    	comment	: comment
                    }),  
                    success : function(result){
                        alert(result);
                        showList(bno);
                    },
                    error   : function(){			// 에러가 발생했을 때, 호출될 함수 
                    	alert("error")
                    }	
                });
            });	// End - modBtn
            
            
            // wrtRepBtn //
            $("#wrtRepBtn").click(function(){
                let comment = $("input[name=replyComment]").val();
                let pcno 	= $("#replyForm").parent().attr("data-pcno");
				
                if (comment.trim() == '') {
                    alert("댓글을 입력해주세요.");
                    $("input[name=replyComment]").focus();
                    return;
                }
				
                $.ajax({
                    type	:'POST',       			// 요청 메서드
                    url		: '/comments?bno='+bno,	// 요청 URI - /comments?bno=2029 POST <- 컨트롤러에 있는 url 참조해서.
                    headers : {						// 요청 헤더
                    	"content-type": "application/json"
                    }, 
                    data 	: JSON.stringify({		// 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    	pcno	: pcno,
                    	bno		: bno,
                    	comment	: comment
                    }),  
                    success : function(result){
                        alert(result);
                        showList(bno);
                    },
                    error   : function(){			// 에러가 발생했을 때, 호출될 함수
                    	alert("error")
                    } 
                });
				
                $("#replyForm").css("display", "none");
                $("input[name=replyComment]").val('');
                $("#replyForm").appendTo("body");
            });	// End - wrtRepBtn
            
            
            // sendBtn //
            $("#sendBtn").click(function(){
                let comment = $("input[name=comment]").val();
				
                if (comment.trim() == '') {
                    alert("댓글을 입력해주세요.");
                    $("input[name=comment]").focus();
                    return;
                }
				
                $.ajax({
                    type	:'POST',       				// 요청 메서드
                    url		: '/comments?bno='+bno,  	// 요청 URI - /comments?bno=2029 POST <- 컨트롤러에 있는 url 참조해서.
                    headers : {							// 요청 헤더
                    	"content-type": "application/json"
                    }, 
                    data 	: JSON.stringify({			// 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    	bno		: bno, 
                    	comment	: comment
                    }),  
                    success : function(result){
                        alert(result);
                        showList(bno);
                    },
                    error   : function(){				// 에러가 발생했을 때, 호출될 함수
                    	alert("error") 
                    } 
                });
            });	// End - sendBtn
            
            
            
            // $("#commentList").on("click", ".---Btn", function() {} 이것을 쓰는 이유는
            // 웹 브라우저는 html - css - javascript 순서로 동작하는데
            // html 코드가 로딩된 시점에서는 id="commentList" div 태그만 존재하고
            // 로딩 후 javascript(JQuery)에서 버튼을 만들어주는 순서이기 때문에
            // $(".modBtn").onclick({}); 이벤트를 만들어도 작동이 안 된다.
            // html 코드 상 존재하는 commentList를 기준으로 이벤트 기능을 만들어준다.
            
            
			
            // commentList 동적데이터 버튼 설정
            // $(".modBtn").onclick(function{}) <- No
            $("#commentList").on("click", ".modBtn", function() {	// <- Yes
                let cno 	= $(this).parent().attr("data-cno");
                let comment = $("span.comment", $(this).parent()).text();
				
                $("input[name=comment]").val(comment);
                $("#modBtn").attr("data-cno", cno);
            });
			
            
            $("#commentList").on("click", ".replyBtn", function() {
                $("#replyForm").appendTo($(this).parent());	// 1. replyForm을 옮기고
                $("#replyForm").css("display", "block");	// 2. 답글을 입력할 폼을 보여줌.
            });
			
            
            $("#commentList").on("click", ".delBtn", function() {
                let cno = $(this).parent().attr("data-cno");
                let bno = $(this).parent().attr("data-bno");
				
                $.ajax({
                    type	:'DELETE',       					// 요청 메서드
                    url		: '/comments/'+cno+'?bno='+bno,  	// 요청 URI
                    success : function(result){
                        alert(result);
                        showList(bno);
                    },
                    error   : function(){ alert("error") } 		// 에러가 발생했을 때, 호출될 함수
                });
            });
        });	//-- End of $(document).ready(function(){ --//
		
        
        //-- 호출메서드 작성 --//
        let toHtml = function (comments) {
            let tmp =	"<ul>";
			
            comments.forEach(function(comments) {
                tmp += 		'<li data-cno='+ comments.cno +' data-pcno='+ comments.pcno +' data-bno='+ comments.bno +'>'
                if (comments.cno!=comments.pcno) {
                    tmp += 		'&nbspㄴ'
					tmp += 		' commenter='+'<span class="commenter">'+ comments.commenter +'</span>';
                }
                tmp +=     		' comment='+'<span class="comment">'+ comments.comment +'</span>'
                tmp +=     		' up_date='+ comments.up_date
                tmp +=     		'<button class="delBtn">삭제</button>'
                tmp +=     		'<button class="modBtn">수정</button>'
                tmp +=     		'<button class="replyBtn">답글</button>'
                tmp += 		'</li>'
            })
            return tmp+ "</ul>";
        };
    </script>

</body>
</html>