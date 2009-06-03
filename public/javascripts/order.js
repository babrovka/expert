$(document).ready(function() {

   $('a#new_message').click(function () { 
      size=$("p.upload").size();
      $("p#upload_"+size).after($("p#upload_"+size).clone().attr("id", "upload_"+(size+1)));
      $("p#upload_"+(size+1)+" > input").each(function () {
           if (this.id) this.id = this.id.replace("_"+(size-1)+"_", "_"+size+"_");
           if (this.name) this.name = this.name.replace("["+(size-1)+"]", "["+size+"]");
        });
      $("p#upload_"+(size+1)).html($("p#upload_"+(size+1)).html().replace(""+size+".", ""+(size+1)+"."));
   });

});

