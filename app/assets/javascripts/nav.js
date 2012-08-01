
      $(document).ready(function(){
        $("#user_login").click(function(){
          if($(this).val() == "ID"){ $(this).val("") }
        })
        $("#user_password").click(function(){
          if($(this).val() == "PASSWORD"){ $(this).val("") }
        })

        $("#user_login").blur(function(){
          if($(this).val() == ""){ $(this).val("ID") }
        })
        $("#user_password").blur(function(){
          if($(this).val() == ""){ $(this).val("PASSWORD") }
        })

      })
      $(function(){

        //Hide SubLevel Menus
        $('#NaviArea ul li ul').hide();

        //OnHover Show SubLevel Menus
        $('#NaviArea ul li').hover(
        //OnHover
        function(){
          //Hide Other Menus
          $('#NaviArea ul li').not($('ul', this)).stop();

          // Show Hoved Menu
          $('ul', this).slideDown();
        });

        $("#toppage").mouseover(function(){
          $('#NaviArea ul li ul').slideUp();
        });
        $(".ContentsArea").mouseover(function(){
          $('#NaviArea ul li ul').slideUp();
        });
        $($("#NaviArea ul li")[2]).mouseover(function(){
          $('#NaviArea ul li ul').slideUp();
        });
        $($("#NaviArea ul li")[8]).mouseover(function(){
          $('#NaviArea ul li ul').slideUp();
        });
        $(".Header").mouseover(function(){
          $('#NaviArea ul li ul').slideUp();
        });

      });