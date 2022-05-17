const checkBtn = document.querySelectorAll("check");

function check() {
   with (document.contentwriter) {
      if (name.value.length == 0) {
         alert("제목을 입력해주세요.");
         name.focus();
         return false;
      }

      if (email.value.length == 0) {
         alert("이메일을 입력해주세요.");
         email.focus();
         return false;
      }

      if (subject.value.length == 0) {
         alert("제목을 입력해주세요");
         subject.focus();
         return false;
      }

      if (content.value.length == 0) {
         alert("내용을 입력해주세요.");
         content.focus();
         return false;
      }
      
      if (password.value.length == 0) {
		 alert("비밀번호를 입력해주세요.");
         password.focus();
         return false;
	  }
      document.contentwriter.submit();
   }
}

checkBtn.addEventListener("click", check);
