const cancelBtn = document.querySelector(".cancel-img");

function check() {
   with (document.contentwriter) {
      if (name.value.length == 0) {
         alert("이름을 입력해주세요.");
         name.focus();
         return false;
      } else if (email.value.length == 0) {
         alert("이메일을 입력해주세요.");
         email.focus();
         return false;
      } else if (subject.value.length == 0) {
         alert("제목을 입력해주세요");
         subject.focus();
         return false;
      } else if (content.value.length == 0) {
         alert("내용을 입력해주세요.");
         content.focus();
         return false;
      } else if (password.value.length == 0) {
		 alert("비밀번호를 입력해주세요.");
         password.focus();
         return false;
	  }
   }
}

cancelBtn.addEventListener("click", history.go(-1));

