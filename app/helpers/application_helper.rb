module ApplicationHelper
def mensagem
   texto = ""
   [:aviso, :importante, :erro, :info].each {|type|
   if flash[type]
      texto += "<p class=\"#{type}\">#{flash[type]}</p>"
   end
   }
   texto
end
def flash_helper 
    flash.each do |key, msg|
      concat(content_tag :div, msg, :class => key)
    end
    nil
end
end

